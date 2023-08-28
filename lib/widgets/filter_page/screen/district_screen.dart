import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../const/api_urls.dart';
import '../../../language/language_key.dart';
import '../../../services/save_user_info.dart';
import '../../all_widgets.dart';
import '../Api/api_method.dart';
import '../Model/district_model.dart';
import '../Model/pin_code_nodel.dart';
import '../shared_preference.dart';
import '../varieble_const.dart';

List<int> selectedDistrictItems = [];
class DistrictListWidget extends StatefulWidget {
  final String item;
  const DistrictListWidget({Key? key, required this.item}) : super(key: key);
  @override
  _DistrictListWidgetState createState() => _DistrictListWidgetState();
}

class _DistrictListWidgetState extends State<DistrictListWidget> {
  List<PinCodeDatum> filterData = [];
  List initDataList = [];

  check() {
    var concatenate = StringBuffer();
    for (var item in selectedDistrictItems) {
      concatenate.write("${item.toString().toLowerCase()},");
    }
    print(concatenate); // displays 'onetwothree'
    districtId = concatenate.toString();
    print("districtId: $districtId"); // displays ''
  }
  checkUserCurrentState() async{
    var stateName = PinCode().PinData();
    var alreadyAddedDistrictId = await SharedPreferencesHelper.getValue("get_district_id");
    if(alreadyAddedDistrictId !=null){
      check();
    }else{
      stateName.then((value) =>
      {
        setUserState(value?.data[0].districtId),
        check()
      });
    }
  }

  setUserState(int? districtId){
    try {
      SharedPreferencesHelper.setValue('get_district_id', "$districtId")
          .then((value) {
        checSharePre();
      });
    } catch (e) {
      print("found try catch issue $e ");
    }
  }
  @override
  void initState() {
    PinData();
    checkUserCurrentState();
    super.initState();
   // FetchData();
  }
  checSharePre() async {
    try {
      var district = int.parse(await SharedPreferencesHelper.getValue("get_district_id"));
      print("build method ${district}");
      // stateId= state.toString();
      toggleItemSelection(district, "district");
    } catch (e) {
      print("found try catch issue 2 $e ");
    }
  }
  // checSharePre()async{
  //   try{
  //     var state = int.parse(await SharedPreferencesHelper.getValue("get_district_id"));
  //     print("build method ${state}");
  //     toggleItemSelection(state ,"district");
  //   }catch(e){
  //     print("found try catch issue 2 $e ");
  //   }
  // }
  void toggleItemSelection(int item, String district) async {
    setState(
      () {
        print("items print:: $item");
        if (selectedDistrictItems.contains(item)) {
          selectedDistrictItems.remove(item);
          SharedPreferencesHelper.removeValue('${district}_$item',item);
        } else {
          selectedDistrictItems.add(item);
          SharedPreferencesHelper.setValue('${district}_$item',item);
        }
      },
    );
    print("selectedItems print:: $selectedDistrictItems");
  }
  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    check();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DistrictModel?>(
        future: ApiDRemotes().brandData(stateId.isNotEmpty?stateId:listData[0].stateId.toString()),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            DistrictModel data = snapshot.data;
            List<DistrictDatum> da = data.data;
            return ListView(
              children: [
                ListView.builder(
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    itemCount: da.length,
                    itemBuilder: (context, index) {
                      final item = da[index];
                      var text = item.id;
                      final isSelected =
                          selectedDistrictItems.contains(text);
                      return InkWell(
                        onTap: () {
                          check();
                          toggleItemSelection(text, "district");
                        },
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 8.0, right: 8, top: 5),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: 30,
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
                                  child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10),
                                      child: Text(
                                        da[index].districtName,
                                        style: TextStyle(
                                            fontSize: 13,
                                            fontWeight: isSelected == true
                                                ? FontWeight.bold
                                                : FontWeight.normal),
                                      ),
                                    ),
                                    (widget.item == tractor.tr) ?
                                    Text(
                                      "${da[index].tractorCount} items",
                                      style: TextStyle(fontSize: 10),
                                    ) : (widget.item == goodsVehicle.tr)
                                        ? Text(
                                      "${da[index]
                                          .goodsVehicleCount} items",
                                      style: TextStyle(fontSize: 10),)
                                        : (widget.item == seeds.tr)
                                        ? Text(
                                      "${da[index].seedsCount} items",
                                      style: TextStyle(fontSize: 10),)
                                        : (widget.item == pesticides.tr)
                                        ? Text(
                                      "${da[index].pesticidesCount} items",
                                      style: TextStyle(fontSize: 10),)
                                        : (widget.item == fertilizer.tr)
                                        ? Text(
                                      "${da[index].fertilizersCount} items",
                                      style: TextStyle(fontSize: 10),)
                                        : (widget.item == harvester.tr)
                                        ? Text(
                                      "${da[index].harvesterCount} items",
                                      style: TextStyle(fontSize: 10),)
                                        : (widget.item == implement.tr)
                                        ? Text(
                                      "${da[index].implementsCount} items",
                                      style: TextStyle(fontSize: 10),)
                                        : (widget.item == tyre.tr) ?Text(
                                      "${da[index].tyresCount} items",
                                      style: TextStyle(fontSize: 10),):Container(),
                                  ],
                                ),
                              )),
                            )),
                      );
                    })
              ],
            );
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
    );
  }
  Future<List<PinCodeDatum>?> PinData() async {
    Map data = {"pincode":SharedPreferencesFunctions.zipcode};
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(
        Uri.parse(baseUrl + pincodeUrl),
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
      final List<PinCodeDatum> ListPinCodeData = PinCodeModal.fromJson(responseData).data.toList();
      listData = ListPinCodeData;
      //toggleItemSelection(listData[0].districtId, "district");
      //selectedDistrictItems.add(listData[0].districtId);
      setState(() {});
      return listData;
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }
}
