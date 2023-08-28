import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:krishivikas/const/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import '../../../const/api_urls.dart';
import '../../../services/save_user_info.dart';
import 'Counter_Model.dart';

class IFFCO_Counter_List extends StatefulWidget {
  @override
  _IFFCO_Counter_ListState createState() => _IFFCO_Counter_ListState();
}

class _IFFCO_Counter_ListState extends State<IFFCO_Counter_List> {
  List<IffcoCounter> _counters = [];
  List<IffcoCounter> _filteredCounters = [];
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    var response = await http.post(
      Uri.parse(baseUrl+IFFCO_Counter),
      body: jsonEncode(
        {
          'pincode':SharedPreferencesFunctions.zipcode
        },
      ),
      headers: {
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);

      final data = jsonData['data'] as List<dynamic>;

      setState(() {
        _counters = data.map((item) => IffcoCounter.fromJson(item)).toList();
        _filteredCounters = _counters;
      });
    } else {
      throw Exception('Failed to fetch Iffco Counters');
    }
  }

  void _filterCounters(String searchText) {
    setState(() {
      _filteredCounters = _counters.where((counter) {
        final name = counter.name.toLowerCase();
        final city = counter.city?.toLowerCase() ?? '';
        final query = searchText.toLowerCase();

        return name.contains(query) || city.contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('IFFCO Counters'),
        centerTitle: true,
        backgroundColor: darkgreen,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              onChanged: _filterCounters,
              decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.green.shade100,
                  hintText: "Search IFFCO Counter near you",
                  prefixIcon: Icon(Icons.search_rounded),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  )
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredCounters.length,
              itemBuilder: (context, index) {
                final counter = _filteredCounters[index];

                return Card(
                  elevation: 5,
                  child: ListTile(
                    title: Text(counter.name),
                    subtitle: Text(counter.address ?? ''),
                    trailing: IconButton(
                      onPressed: () async {
                        var telUrl =  Uri.parse('tel:${counter.phoneNo}');
                        if (await canLaunchUrl(telUrl)) {
                        await launchUrl(telUrl,mode: LaunchMode.externalApplication);
                        } else {
                        throw 'Could not launch $telUrl';
                        }
                      },
                      icon: Icon(Icons.phone),

                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
