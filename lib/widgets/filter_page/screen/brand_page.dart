import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/filter_page/Model/tractor_model.dart';
import '../../../const/api_urls.dart';
import '../../../language/language_key.dart';
import '../../all_widgets.dart';
import '../Api/api_method.dart';
import '../Model/brand_model.dart';
import '../shared_preference.dart';
import '../varieble_const.dart';
import 'package:http/http.dart' as http;

List<int> selectedItems = [];

class BrandPage extends StatefulWidget {
  const BrandPage({Key? key}) : super(key: key);

  @override
  State<BrandPage> createState() => _BrandPageState();
}

class _BrandPageState extends State<BrandPage> {
  List<BrandDatum> filteredData = [];

  Future<List<BrandDatum>?> popularBrandData(String categoryId) async {
    Map data = {"category": categoryId};
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(Uri.parse(baseUrl + brandUrl),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: '*',
        },
        body: body);
    if (response.statusCode == 200) {
      // logger.e(response.statusCode);
      final responseData = json.decode(response.body);
      final List<BrandDatum> dataList = Brand.fromJson(responseData)
          .data
          .where((element) => element.popular == 1)
          .toList();
      filteredData = dataList;
      return dataList;
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }

  check() {
    var concatenate = StringBuffer();
    for (var item in selectedItems) {
      concatenate.write("${item.toString().toLowerCase()},");
    }
    print(concatenate); // displays 'onetwothree'
    brandId = concatenate.toString();
    print("brandId: ${brandId}"); // displays ''
  }

  @override
  void initState() {
    super.initState();
  }

  void toggleItemSelection(int item, String brand) async {
    setState(
      () {
        print("items print:: $item");
        if (selectedItems.contains(item)) {
          selectedItems.remove(item);
          SharedPreferencesHelper.removeValue('${brand}_$item', item);
        } else {
          selectedItems.add(item);
          SharedPreferencesHelper.setValue('${brand}_$item', item);
        }
      },
    );
    print("selectedItems print:: $selectedItems");
  }

  // _favoritePlaces() async {
  //   // selectedItems = [];
  //   // var prefKeys = prefStorage!.getKeys();
  //
  // }
  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    check();
  }

  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              ExpansionTile(
                  key: Key(0.toString()),
                  //attention
                  initiallyExpanded: 0 == selected,
                  iconColor: Colors.black,
                  textColor: Colors.black,
                  collapsedTextColor: Colors.grey,
                  collapsedIconColor: Colors.grey,
                  title: Text(
                    popular_brand.tr,
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  children: [
                    FutureBuilder(
                      future: popularBrandData(category),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return GridView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 4.0),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                              itemCount: filteredData.length,
                              itemBuilder: (context, index) {
                                final item = filteredData[index];
                                var text = item.id;
                                final isSelected = selectedItems.contains(text);
                                return InkWell(
                                  onTap: () {
                                    toggleItemSelection(text, "brand");
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              isSelected == true ? 2 : 10),
                                          color: isSelected == true
                                              ? Colors.greenAccent
                                                  .withOpacity(0.3)
                                              : Colors.white.withOpacity(0.2),
                                          border: Border.all(
                                            color: isSelected == true
                                                ? Colors.greenAccent
                                                : Colors.black.withOpacity(0.2),
                                          )),
                                      child: Center(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.network(
                                              filteredData[index].logo,
                                              width: 50,
                                              height: 50,
                                              fit: BoxFit.contain,
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              filteredData[index].name,
                                              style: const TextStyle(
                                                  fontSize: 8,
                                                  fontWeight: FontWeight.bold),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Icon(Icons.error_outline),
                          );
                        } else {
                          return Center(
                            child: progressIndicator(context),
                          );
                        }
                      },
                    )
                  ],
                  onExpansionChanged: ((newState) {
                    if (newState)
                      setState(() {
                        Duration(seconds: 20000);
                        selected = 0;
                      });
                    else
                      setState(() {
                        selected = -1;
                      });
                  })),
              ExpansionTile(
                iconColor: Colors.black,
                textColor: Colors.black,
                collapsedTextColor: Colors.grey,
                collapsedIconColor: Colors.grey,
                title: Text(
                  all_brand.tr,
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: [
                  FutureBuilder<Brand?>(
                    future: ApiRemotes().brandData(category),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasData) {
                        Brand data = snapshot.data;
                        List<BrandDatum> da = data.data;
                        return GridView.builder(
                            physics: ScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    crossAxisSpacing: 4.0,
                                    mainAxisSpacing: 4.0),
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            itemCount: da.length,
                            itemBuilder: (context, index) {
                              final item = da[index];
                              var text = item.id;
                              final isSelected = selectedItems.contains(text);
                              return InkWell(
                                onTap: () {
                                  toggleItemSelection(text, "brand");
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            isSelected == true ? 2 : 10),
                                        color: isSelected == true
                                            ? Colors.greenAccent
                                                .withOpacity(0.3)
                                            : Colors.white.withOpacity(0.2),
                                        border: Border.all(
                                          color: isSelected == true
                                              ? Colors.greenAccent
                                              : Colors.black.withOpacity(0.2),
                                        )),
                                    child: Center(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Image.network(
                                            da[index].logo,
                                            width: 50,
                                            height: 50,
                                            fit: BoxFit.contain,
                                          ),
                                          SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            da[index].name,
                                            style: const TextStyle(
                                                fontSize: 8,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else if (snapshot.hasError) {
                        return const Center(
                          child: Icon(Icons.error_outline),
                        );
                      } else {
                        return Center(
                          child: progressIndicator(context),
                        );
                      }
                    },
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
