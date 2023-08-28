import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:krishivikas/language/language_key.dart';
import '../shared_preference.dart';
import '../varieble_const.dart';
int selectedContainerIndex =  SharedPreferencesHelper.getValue('selected_container') ?? -1;
class ManufacturingScreen extends StatefulWidget {
  const ManufacturingScreen({Key? key}) : super(key: key);

  @override
  State<ManufacturingScreen> createState() => _ManufacturingScreenState();
}

class _ManufacturingScreenState extends State<ManufacturingScreen> {

  void selectContainer(int index) async {
    SharedPreferencesHelper.setValue('selected_container', index);
    setState(() {
      selectedContainerIndex = index;
    });
  }

  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  suceessDate() {
    var endDate = _endController.text;
    var startDate = _startController.text;
    int startDateTime = int.parse(startDate);
    int endDateTime = int.parse(endDate);
    if (selectedContainerIndex == -1) {
      for (var i =endDateTime ; i >= startDateTime; i--){
        print(" text form - $i");
        byYear += "${i.toString()},";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
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
                    int date = DateTime.now().year;
                    int underDate = date - 3;
                    for (int dateCounter = DateTime
                        .now()
                        .year; underDate <= dateCounter; dateCounter--) {
                      print("Viku - ${dateCounter.toString()}");
                      byYear += "${dateCounter.toString()},";
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          selectedContainerIndex == 0 ? 2 : 10),
                      color: selectedContainerIndex == 0
                          ? Colors.greenAccent.withOpacity(0.3)
                          : Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: selectedContainerIndex == 0
                            ? Colors.greenAccent
                            : Colors.black.withOpacity(0.2),
                      )),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 30,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            under_three_year.tr,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: selectedContainerIndex == 0
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
                    int date = DateTime
                        .now()
                        .year;
                    int underDate = date - 3;
                    for (int dateCounter = DateTime
                        .now()
                        .year; underDate <= dateCounter; dateCounter--) {
                      print("Viku - ${dateCounter.toString()}");
                      byYear += "${dateCounter.toString()},";
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          selectedContainerIndex == 1 ? 2 : 10),
                      color: selectedContainerIndex == 1
                          ? Colors.greenAccent.withOpacity(0.3)
                          : Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: selectedContainerIndex == 1
                            ? Colors.greenAccent
                            : Colors.black.withOpacity(0.2),
                      )),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 30,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            under_five_year.tr,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: selectedContainerIndex == 1
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
                    int date = DateTime
                        .now()
                        .year;
                    int underDate = date - 3;
                    for (int dateCounter = DateTime
                        .now()
                        .year; underDate <= dateCounter; dateCounter--) {
                      print("Viku - ${dateCounter.toString()}");
                      byYear += "${dateCounter.toString()},";
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          selectedContainerIndex == 2 ? 2 : 10),
                      color: selectedContainerIndex == 2
                          ? Colors.greenAccent.withOpacity(0.3)
                          : Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: selectedContainerIndex == 2
                            ? Colors.greenAccent
                            : Colors.black.withOpacity(0.2),
                      )),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 30,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            under_seven_year.tr,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: selectedContainerIndex == 2
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
                    int date = DateTime
                        .now()
                        .year;
                    int underDate = date - 3;
                    for (int dateCounter = DateTime
                        .now()
                        .year; underDate <= dateCounter; dateCounter--) {
                      print("Viku - ${dateCounter.toString()}");
                      byYear += "${dateCounter.toString()},";
                    }
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          selectedContainerIndex == 3 ? 2 : 10),
                      color: selectedContainerIndex == 3
                          ? Colors.greenAccent.withOpacity(0.3)
                          : Colors.white.withOpacity(0.2),
                      border: Border.all(
                        color: selectedContainerIndex == 3
                            ? Colors.greenAccent
                            : Colors.black.withOpacity(0.2),
                      )),
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  height: 30,
                  child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            seven_years_obove.tr,
                            style: TextStyle(
                                fontSize: 13,
                                fontWeight: selectedContainerIndex == 3
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ),
                      )),
                ),
              ),
            ),
             Padding(
              padding: EdgeInsets.only(left: 10, right: 10, top: 15),
              child: Text(
                below_option.tr,
                style: TextStyle(fontSize: 12),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                children: [
                  Container(
                    height: 30,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        )),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10),
                        child: TextField(
                          onSubmitted:(value){
                            setState(() {
                              selectedContainerIndex= -1;
                            });
                          },
                          controller: _startController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4),

                            /// here char limit is 5
                          ],
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 13, color: Colors
                              .black, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            hintText: "2003",
                            hintStyle: TextStyle(fontSize: 13),
                            border: InputBorder.none,
                            errorBorder: OutlineInputBorder(
                              //<-- SEE HERE
                              borderSide:
                              BorderSide(width: 3, color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "to",
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 30,
                    width: 55,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.2),
                          width: 1,
                        )),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0, right: 8),
                        child: TextField(
                          onSubmitted:(value){
                            setState(() {
                              selectedContainerIndex= -1;
                            });
                            suceessDate();
                          },
                          controller: _endController,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(4),

                            /// here char limit is 5
                          ],
                          keyboardType: TextInputType.number,
                          style: const TextStyle(fontSize: 13, color: Colors
                              .black, fontWeight: FontWeight.bold),
                          decoration: const InputDecoration(
                            hintText: "2023",
                            hintStyle: TextStyle(fontSize: 13),
                            border: InputBorder.none,
                            errorBorder: OutlineInputBorder(
                              //<-- SEE HERE
                              borderSide:
                              BorderSide(width: 3, color: Colors.redAccent),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        )
      ],
    );
  }
}