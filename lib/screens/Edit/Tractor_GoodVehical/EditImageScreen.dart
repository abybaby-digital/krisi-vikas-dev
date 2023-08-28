import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/screens/Edit/Post_Update/PostGVUpdate.dart';
import 'package:krishivikas/screens/capture_from_camera.dart';
import 'package:krishivikas/screens/notification/notifications_screen.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import '../../../Screens/added_product_result_screen.dart';
import '../../../const/utils.dart';
import '../../../widgets/image_picker_custom.dart';
import '../Post_Update/PostTractorUpdate.dart';

class EditTractorImagesScreen extends StatefulWidget {
  final String? set;
  final String? setType;
  final String? rentType;
  final int? price;
  final String? rcAvailabel;
  final String? isNegotiable;
  final String? description;
  final int? yearOfPurchase;
  final ds;

  const EditTractorImagesScreen({
    this.setType,
    this.rentType,
    this.price,
    this.rcAvailabel,
    this.isNegotiable,
    this.yearOfPurchase,
    this.set,
    this.description,
    this.ds,
  });

  @override
  State<EditTractorImagesScreen> createState() => _EditTractorImagesScreenState();
}

class _EditTractorImagesScreenState extends State<EditTractorImagesScreen> {
  bool showCPI = false;

  String url = "";

  // pick camera image moni
  late CameraController _controller;

  late CameraDescription firstCamera;

  Future<void> CameraTake() async {
    // Obtain a list of the available cameras on the device.
    final cameras = await availableCameras();

    // Get a specific camera from the list of available cameras.
    firstCamera = cameras.first;

    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      firstCamera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );
    await _controller.initialize();
  }

  // pick camera image moni

  @override
  void initState() {
    super.initState();
    doThisONLaunch();
    CameraTake();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 50,
              width: fullWidth(context) * 0.50,
              decoration: BoxDecoration(
                color: darkgreen,
                border: Border(
                  right: BorderSide(
                    color: white,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: barlowBold(
                text: previous.tr,
                color: white,
                size: 20,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              setState(
                    () {
                  showCPI = true;
                },
              );

              int count = 0;
              for (var item in images) {
                if (item != "") {
                  count++;
                }
              }

              if (count >= 1) {
                var left_image,
                    right_image,
                    front_image,
                    back_image,
                    meter_image,
                    tyre_image;
                if (images[0] != "") {
                  left_image = await MultipartFile.fromFile(
                    images[0],
                    filename: images[0].split("/").last,
                  );
                }
                if (images[1] != "") {
                  right_image = await MultipartFile.fromFile(
                    images[1],
                    filename: images[1].split("/").last,
                  );
                }
                if (images[2] != "") {
                  front_image = await MultipartFile.fromFile(
                    images[2],
                    filename: images[2].split("/").last,
                  );
                }
                if (images[3] != "") {
                  back_image = await MultipartFile.fromFile(
                    images[3],
                    filename: images[3].split("/").last,
                  );
                }
                if (images[4] != "") {
                  meter_image = await MultipartFile.fromFile(
                    images[4],
                    filename: images[4].split("/").last,
                  );
                }
                if (images[5] != "") {
                  tyre_image = await MultipartFile.fromFile(
                    images[5],
                    filename: images[5].split("/").last,
                  );
                }

                print(SharedPreferencesFunctions.userId);
                print(SharedPreferencesFunctions.token);
                print(back_image);
                print(left_image);
                print(right_image);

                FormData formData = FormData.fromMap({
                  "user_id": SharedPreferencesFunctions.userId,
                  "user_token": SharedPreferencesFunctions.token,
                  "id":widget.ds['id'],
                  "set":'${widget.set}'.toLowerCase(),
                  'type':'${widget.setType}'.toLowerCase(),
                  'spec_id':'',
                  "left_image": left_image,
                  "right_image": right_image,
                  "front_image": front_image,
                  "back_image": back_image,
                  "meter_image": meter_image,
                  "tyre_image": tyre_image,
                  'price':widget.price,
                  'rent_type':widget.rentType,
                  'rc_available':widget.rcAvailabel,
                  'is_negotiable':widget.isNegotiable,
                  'year_of_purchase':'${widget.yearOfPurchase}',
                  'description':widget.description,
                });
                var response = await Dio().post(
                  baseUrl+getUrlByCategory(),
                  data: formData,
                );

                if (response.statusCode == 200) {
                  int id = widget.ds['id'];
                  print("ID : $id");
                  gotoWithoutBack(
                    context,
                      SendToPageCategory(id)
                  );
                  showSnackbar(context, adAdded.tr);
                  setState(
                        () {
                      showCPI = false;
                    },
                  );
                }
              } else {
                showSnackbar(
                  context,
                  minimumtwoImages.tr,
                );
                setState(
                      () {
                    showCPI = false;
                  },
                );
              }
            },
            child: Container(
              height: 50,
              width: fullWidth(context) * 0.50,
              decoration: BoxDecoration(
                color: darkgreen,
                border: Border(
                  left: BorderSide(
                    color: white,
                  ),
                ),
              ),
              alignment: Alignment.center,
              child: showCPI
                  ? Center(
                child: progressIndicator(context),
              )
                  : barlowBold(
                text: submitValue.tr,
                color: white,
                size: 20,
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: appTitle.tr,
          color: white,
          size: 20,
        ),
        // actions: [
        //   IconButton(
        //     onPressed: () {
        //       goto(
        //         context,
        //         NotificationsScreen(),
        //       );
        //     },
        //     icon: Icon(
        //       Icons.notifications,
        //       color: white,
        //     ),
        //   )
        // ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              width: double.infinity,
              color: greenShade300,
              child: barlowBold(
                text: uploadPhoto.tr,
                size: 20,
                color: white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: assetImages.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.2,
                  mainAxisSpacing: 5,
                  crossAxisSpacing: 5,
                ),
                itemBuilder: (context, i) {
                  return InkWell(
                    onTap: () {
                      takeImage(i);
                      setState(() {});
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.7),
                            blurRadius: 4,
                          )
                        ],
                      ),
                      height: fullWidth(context) * 0.35,
                      width: fullWidth(context) * 0.45,
                      child: images[i] == ""
                          ? Column(
                        children: [
                          Image.asset(
                            assetImages[i],
                            fit: BoxFit.cover,
                            height: fullWidth(context) * 0.28,
                            width: fullWidth(context) * 0.30,
                          ),
                          barlowBold(
                            text: imagesType[i],
                            size: 17,
                            color: black,
                          ),
                        ],
                      )
                          : Image.file(
                        File(images[i]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              ),
            ),
            VSpace(10)
          ],
        ),
      ),
    );
  }

  getUrlByCategory() {
    if (widget.ds['category_id'] == "1") {
      return "tractor-update";
    } else if (widget.ds['category_id'] == "3") {
      return "gv-update";
    }
  }

  SendToPageCategory(int id) {
    if (widget.ds['category_id']  == "1") {
      return PostTractorDetailScreen(id);
    } else if (widget.ds['category_id'] == "3") {
      return PostGvDetailScreen(id);
    }
  }

  doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
  }

  final ImagePicker picker = new ImagePicker();

  List<String> images = List.filled(6, "");
  List<String> assetImages = [
    AppImages.leftImage,
    AppImages.rightImage,
    AppImages.frontImage,
    AppImages.backImage,
    AppImages.meterImage,
    AppImages.tyreImage,
  ];
  List<String> imagesType = [
    leftSideImage.tr,
    rightSideImage.tr,
    frontSideImage.tr,
    backSideImage.tr,
    meterImage.tr,
    tyreImage.tr,
  ];

  List<String> vehicleAssetImages = [
    AppImages.leftVehicleImage,
    AppImages.rightVehicleImage,
    AppImages.frontVehicleImage,
    AppImages.backVehicleImage,
    AppImages.meterImage,
    AppImages.tyreImage,
  ];

  bool isImageSelected = false;

  Future getImageFromGallery(int i) async {
    Navigator.of(context).pop();
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
    }
    try {
      if (status.isGranted) {
        await ImagePickerCustom.SelectImageFromGalary();
        final pickedFile = ImagePickerCustom.Image;
        setState(
              () {
            if (pickedFile != null) {
              images[i] = pickedFile;
              isImageSelected = true;
            } else {
              showSnackbar(context, noImageSelect.tr);
            }
          },
        );
      }
    } catch (e) {
      print("Error:${e}");
    }
  }

  // Future captureImageFromCamera(int i) async {
  //   Navigator.of(context).pop();
  //   var status = await Permission.camera.status;
  //   if (status.isDenied) {
  //     await Permission.camera.request();
  //   }
  //   try {
  //     if (status.isGranted) {
  //       final pickedFile = await picker.pickImage(
  //           source: ImageSource.camera, imageQuality: 60);
  //       setState(
  //         () {
  //           if (pickedFile != null) {
  //             images[i] = pickedFile.path;
  //             isImageSelected = true;
  //           } else {
  //             showSnackbar(context, noImageSelect.tr);
  //           }
  //         },
  //       );
  //     }
  //   } catch (e) {
  //     print("Error:${e}");
  //   }
  // }

  Future captureImageFromCamera(int i) async {
    Navigator.of(context).pop();
    var status = await Permission.camera.status;
    if (status.isDenied) {
      await Permission.camera.request();
    }
    try {
      if (status.isGranted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => TakePictureScreen(
                camera: firstCamera,
              )),
        ).then((object) {
          if (Utils.capturedImagePath.isNotEmpty) {
            final pickedFile = Utils.capturedImagePath;
            setState(
                  () {
                if (pickedFile != "") {
                  images[i] = pickedFile;
                  isImageSelected = true;
                  Utils.capturedImagePath = "";
                } else {
                  showSnackbar(context, noImageSelect.tr);
                  Utils.capturedImagePath = "";
                }
              },
            );
          }
        });
      }
    } catch (e) {
      print("Error:${e}");
    }
  }

  takeImage(int i) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: barlowBold(
            text: selectOption.tr,
            size: 20,
            color: black,
          ),
          children: [
            SimpleDialogOption(
              child: barlowRegular(
                text: imageFromGallery.tr,
                size: 17,
                color: black,
              ),
              onPressed: () async {
                getImageFromGallery(i);
              },
            ),
            SimpleDialogOption(
              child: barlowRegular(
                text: imageFromCamera.tr,
                size: 17,
                color: black,
              ),
              onPressed: () async {
                captureImageFromCamera(i);
              },
            ),
            SimpleDialogOption(
              child: barlowRegular(
                text: cancel.tr,
                size: 17,
                color: black,
              ),
              onPressed: () {
                goBack(context);
              },
            ),
          ],
        );
      },
    );
  }
}
