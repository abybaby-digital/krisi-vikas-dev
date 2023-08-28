import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';

import 'availabe_store.dart';
import 'model/iffco_categary.dart';

class IffcoScreen extends StatefulWidget {
  const IffcoScreen({Key? key}) : super(key: key);

  @override
  State<IffcoScreen> createState() => _IffcoScreenState();
}

class _IffcoScreenState extends State<IffcoScreen> {
  final controller = TextEditingController();
  List<ItemData> itemList = ItemData.getItemListData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: const Text("IFFCO-Product"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    prefixIcon:  Icon(Icons.search,color: darkgreen,),
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide:
                             BorderSide(width: 4, color: darkgreen)),
                    hintText: "Search IFFCO Products"),
                onChanged: searchProduct,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.builder(
                  shrinkWrap: true,
                  itemCount: itemList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AvailableStore()));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: 70,
                          height: 100,
                          child: Column(
                            children: [
                              Container(
                                  width: 65,
                                  height: 65,
                                  child: Image.asset(itemList[index].imageAddress)),
                              Expanded(
                                child: Text(
                                  itemList[index].name,
                                  style: const TextStyle(
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  void searchProduct(String query) {
    final suggestions = ItemData.getItemListData().where((ItemData) {
      final title = ItemData.name.toLowerCase();
      final input = query.toLowerCase();

      return title.contains(input);
    }).toList();

    setState(() => itemList = suggestions);
  }
}
