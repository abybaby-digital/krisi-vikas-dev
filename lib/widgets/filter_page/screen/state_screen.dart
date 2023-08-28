import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:krishivikas/language/language_key.dart';
import '../../../const/api_urls.dart';
import '../../../services/save_user_info.dart';
import '../../all_widgets.dart';
import '../Api/api_method.dart';
import '../Model/StateModel.dart';
import '../Model/pin_code_nodel.dart';
import '../shared_preference.dart';
import '../varieble_const.dart';

List<int> selectedStateItems = [];

class StateScreen extends StatefulWidget {
  final String item;

  const StateScreen({Key? key, required this.item}) : super(key: key);

  @override
  State<StateScreen> createState() => _StateScreenState();
}

class _StateScreenState extends State<StateScreen> {
  List<PinCodeDatum> filterData = [];
  List initDataList = [];
  List<PinCodeDatum> listData = [];
  bool isDataObtained = true;

  // Array index convert String value
  check() {
    var concatenate = StringBuffer();
    for (var item in selectedStateItems) {
      concatenate.write("${item.toString().toLowerCase()},");
    }
    print(concatenate); // displays 'onetwothree'
    stateId = concatenate.toString();
    print("stateId: $stateId"); // displays ''
  }

  @override
  void initState() {
    checkUserCurrentState();
    PinData();
    check();
    super.initState();
  }

  //
  // @override
  // void setState(VoidCallback fn) {
  //   check();
  //   super.setState(fn);
  // }
  //
  checkUserCurrentState() async {
    var stateName = PinCode().PinData();
    var alreadyAddedStateId =
    await SharedPreferencesHelper.getValue("get_state_id");
    if (alreadyAddedStateId != null) {
      check();
    } else {
      stateName.then((value) async {
        setUserState(value?.data[0].stateId);
        var state =
        int.parse(await SharedPreferencesHelper.getValue("get_state_id"));
        if (value?.data[0].stateId != state) {
          setUserState(value?.data[0].stateId);
          check();
        } else {
          checSharePre();
        }
      });
    }
  }

  setUserState(int? stateId) {
    try {
      SharedPreferencesHelper.setValue('get_state_id', "$stateId")
          .then((value) {
        checSharePre();
      });
    } catch (e) {
      print("found try catch issue $e ");
    }
  }

  checSharePre() async {
    try {
      var state =
      int.parse(await SharedPreferencesHelper.getValue("get_state_id"));
      print("build method ${state}");
      // stateId= state.toString();
      stateItemSelection(state, "state");
      check();
    } catch (e) {
      print("found try catch issue 2 $e ");
    }
  }

  //Selext item
  void stateItemSelection(int item, String state) async {
    print("call this method ");
    setState(() {
      print("items print:: $item");
      if (selectedStateItems.contains(item)) {
        selectedStateItems.remove(item);
        SharedPreferencesHelper.removeValue('${state}_$item', item);
      } else {
        selectedStateItems.add(item);
        SharedPreferencesHelper.setValue('${state}_$item', item);
      }
    });
    print("selectedItems print:: $selectedStateItems");
  }

  @override
  void setState(VoidCallback fn) {
    check();
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:FutureBuilder<StateModel?>(
        future: ApiStateRemotes().brandData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            StateModel data = snapshot.data;
            List<StateDatum> da = data.data;
            return ListView(
              children: [
                ListView.builder(
                    physics: const ScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    itemCount: da.length,
                    itemBuilder: (context, index) {
                      // print("check state name ${da[index].stateName}");
                      // print("check second state name ${}");

                      final item = da[index];
                      var text = item.id;
                      final isSelected = selectedStateItems.contains(text);

                      return InkWell(
                        onTap: () {
                          stateItemSelection(text, "state");
                          check();
                        },
                        child: Padding(
                            padding:
                            EdgeInsets.only(left: 8.0, right: 8, top: 5),
                            child: Container(
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              height: 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      isSelected == true ? 2 : 10),
                                  color: isSelected == true
                                      ? Colors.greenAccent.withOpacity(0.3)
                                      : Colors.white.withOpacity(0.2),
                                  border: Border.all(
                                    color: isSelected == true
                                        ? Colors.greenAccent
                                        : Colors.black.withOpacity(0.2),
                                  )),
                              child: Center(
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 8.0, right: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10),
                                          child: Text(
                                            da[index].stateName,
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
    Map data = {"pincode": SharedPreferencesFunctions.zipcode};
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
      final List<PinCodeDatum> ListPinCodeData =
      PinCodeModal
          .fromJson(responseData)
          .data
          .toList();
      listData = ListPinCodeData;
      // stateItemSelection(listData[0].stateId, "state");
      //selectedStateItems.add(listData[0].stateId,);
      isDataObtained = false;
      setState(() {});
      return listData;
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }
}
