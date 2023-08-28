import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../language/language_key.dart';
import '../Api/api_method.dart';
import '../shared_preference.dart';
import '../varieble_const.dart';
int selectedPriceIndex =  SharedPreferencesHelper.getValue('selected_price') ?? -1;
SharedPreferences? prefPrice;
class PricePage extends StatefulWidget {
  const PricePage({Key? key}) : super(key: key);

  @override
  State<PricePage> createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {

  Future<void> selectContainer(int index) async {
    SharedPreferencesHelper.setValue('selected_price', index);
    setState(() {
      selectedPriceIndex = index;
    });
  }
  final String _start = "0";

  final String _end = "100000";
  @override
  void initState() {
    //getPrice();
    super.initState();
    //ApiPriceRemotes().brandData(_start, _end);
  }
  // getPrice() async {
  //   await ApiPriceRemotes().brandData("0", "99999").then((value) {
  //     print(value?.data[0].tractorCount);
  //     setState(() {
  //       first = value?.data[0].tractorCount;
  //     });
  //   });
  //   await ApiPriceRemotes().brandData("100000", "299999").then((value) {
  //     print(value?.data[0].tractorCount);
  //     setState(() {
  //       second = value?.data[0].tractorCount;
  //     });
  //   });
  //   await ApiPriceRemotes().brandData("200000", "299999").then((value) {
  //     print(value?.data[0].tractorCount);
  //     setState(() {
  //       third = value?.data[0].tractorCount;
  //     });
  //   });
  //   await ApiPriceRemotes().brandData("300000", "499999").then((value) {
  //     print(value?.data[0].tractorCount);
  //     setState(() {
  //       fourth = value?.data[0].tractorCount;
  //     });
  //   });
  //   await ApiPriceRemotes().brandData("500000", "4900000").then((value) {
  //     print(value?.data[0].tractorCount);
  //     setState(() {
  //       fifth = value?.data[0].tractorCount;
  //     });
  //   });
  // }

  RangeValues _currentRangeValues = const RangeValues(0, 500000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8, top: 8),
                    child: Text(
                        below_option.tr,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                    child: GestureDetector(
                      onTap: () {
                        selectContainer(0);
                        setState(() {
                          priceStart = "0";
                          priceEnd = "99999";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                selectedPriceIndex == 0 ? 2 : 10),
                            color: selectedPriceIndex == 0
                                ? Colors.greenAccent.withOpacity(0.3)
                                : Colors.white.withOpacity(0.2),
                            border: Border.all(
                              color: selectedPriceIndex == 0
                                  ? Colors.greenAccent
                                  : Colors.black.withOpacity(0.2),
                            )),
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  below_1_lac.tr,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: selectedPriceIndex == 0
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                    child: GestureDetector(
                      onTap: () {
                        selectContainer(1);
                        setState(() {
                          priceStart = "100000";
                          priceEnd = "299999";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                selectedPriceIndex == 1 ? 2 : 10),
                            color: selectedPriceIndex == 1
                                ? Colors.greenAccent.withOpacity(0.3)
                                : Colors.white.withOpacity(0.2),
                            border: Border.all(
                              color: selectedPriceIndex == 1
                                  ? Colors.greenAccent
                                  : Colors.black.withOpacity(0.2),
                            )),
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  below_2_lac.tr,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: selectedPriceIndex == 1
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                    child: GestureDetector(
                      onTap: () {
                        selectContainer(2);
                        setState(() {
                          priceStart = "200000";
                          priceEnd = "299999";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                selectedPriceIndex == 2 ? 2 : 10),
                            color: selectedPriceIndex == 2
                                ? Colors.greenAccent.withOpacity(0.3)
                                : Colors.white.withOpacity(0.2),
                            border: Border.all(
                              color: selectedPriceIndex == 2
                                  ? Colors.greenAccent
                                  : Colors.black.withOpacity(0.2),
                            )),
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  below_3_lac.tr,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: selectedPriceIndex == 2
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                    child: GestureDetector(
                      onTap: () {
                        selectContainer(3);
                        setState(() {
                          priceStart = "300000";
                          priceEnd ="499999";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                selectedPriceIndex == 3 ? 2 : 10),
                            color: selectedPriceIndex == 3
                                ? Colors.greenAccent.withOpacity(0.3)
                                : Colors.white.withOpacity(0.2),
                            border: Border.all(
                              color: selectedPriceIndex == 3
                                  ? Colors.greenAccent
                                  : Colors.black.withOpacity(0.2),
                            )),
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  below_5_lac.tr,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: selectedPriceIndex == 3
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8, top: 5),
                    child: GestureDetector(
                      onTap: () {
                        selectContainer(4);
                        setState(() {
                          priceStart = "500000";
                          priceEnd ="4900000";
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                                selectedPriceIndex == 4 ? 2 : 10),
                            color: selectedPriceIndex == 4
                                ? Colors.greenAccent.withOpacity(0.3)
                                : Colors.white.withOpacity(0.2),
                            border: Border.all(
                              color: selectedPriceIndex == 4
                                  ? Colors.greenAccent
                                  : Colors.black.withOpacity(0.2),
                            )),
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: Center(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  five_lac_obove.tr,
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: selectedPriceIndex == 4
                                          ? FontWeight.bold
                                          : FontWeight.normal),
                                ),
                              ),
                            )),
                      ),
                    ),
                  ),
                   Padding(
                    padding: EdgeInsets.only(left: 8.0, right: 8, top: 15),
                    child: Text(
                      below_option.tr,
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children:  [
                              Text(
                                min_price.tr,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                max_price.tr,
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                    width: 1,
                                  )),
                              child: Center(
                                  child: Text(
                                    _currentRangeValues.start.round().toString(),
                                    style: const TextStyle(fontSize: 12),
                                  )),
                            ),
                            Container(
                              height: 40,
                              width: 80,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Colors.black.withOpacity(0.2),
                                    width: 1,
                                  )),
                              child: Center(
                                  child: Text(
                                    _currentRangeValues.end.round().toString(),
                                    style: const TextStyle(fontSize: 12),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0, right: 18),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            Text(
                              min_price.tr,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              max_price.tr,
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      RangeSlider(
                        values: _currentRangeValues,
                        max: 500000,
                        divisions: 10,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            selectedPriceIndex= -1;
                            _currentRangeValues = values;
                            priceStart = _currentRangeValues.start.round().toString();
                            priceEnd = _currentRangeValues.end.round().toString();
                          });
                        },
                      )
                    ],
                  ),

                  // CustomMultiSelectField<String>(
                  //   title: "Prices",
                  //   items: Price,
                  //   width: deviceWidth,
                  //   enableAllOptionSelect: true,
                  //   onSelectionDone: _onCountriesSelectionComplete,
                  //   itemAsString: (item) => item.toString(),
                  // ),
                ],
              ),
            ),
          ],
        ));
  }
}