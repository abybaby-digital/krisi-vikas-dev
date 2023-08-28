import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../const/utils.dart';
import '../../widgets/image_picker_custom.dart';
import '../added_product_result_screen.dart';
import '../capture_from_camera.dart';
import '../notification/notifications_screen.dart';
import 'dart:async';
import 'package:camera/camera.dart';

class ImplementsImagesScreen extends StatefulWidget {
  final setType;
  final String? type;
  final int? price;
  final bool? isNegotiable;
  final String? description;
  final int? countryId;
  final int? stateId;
  final int? cityId;
  final int? districtId;
  final String? lat;
  final String? lang;
  final int? zipcode;
  final int? brandId;
  final int? modelId;
  final int? categoryId;
  final int? yearOfPurchase;
  final String? titleForSelectOthers;

  const ImplementsImagesScreen({
    this.setType,
    this.type,
    this.price,
    this.isNegotiable,
    this.description,
    this.countryId,
    this.stateId,
    this.cityId,
    this.districtId,
    this.lat,
    this.lang,
    this.zipcode,
    this.brandId,
    this.modelId,
    this.categoryId,
    this.yearOfPurchase,
    this.titleForSelectOthers,
  });

  @override
  State<ImplementsImagesScreen> createState() => _ImplementsImagesScreenState();
}

class _ImplementsImagesScreenState extends State<ImplementsImagesScreen> {
  String url = "";

  bool showCPI = false;

  // pick camera image moni
  late CameraController _controller;

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

  late CameraDescription firstCamera;

  final ImagePicker picker = new ImagePicker();

  List<String> images = List.filled(4, "");

  List<String> assetImages = [
    AppImages.leftImplementImage,
    AppImages.rightImplementImage,
    AppImages.backImplementImage,
    AppImages.frontImplementImage,
  ];

  List<String> imagesType = [
    leftSideImage.tr,
    rightSideImage.tr,
    frontSideImage.tr,
    backSideImage.tr,
  ];

  bool isImageSelected = false;

  @override
  void initState() {
    super.initState();
    doThisONLaunch();

    getApiUrlByCategoryId();

    CameraTake();
    print("setType implement");
    print(widget.setType);
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
              setState(() {
                showCPI = true;
              });

              int count = 0;
              for (var item in images) {
                if (item != "") {
                  count++;
                }
              }

              if (images[2] == "") {
                showSnackbar(
                  context,
                  frontSideImageRequired.tr,
                );
                setState(
                  () {
                    showCPI = false;
                  },
                );
              } else if (count >= 2) {
                var left_image, right_image, front_image, back_image;

                if (images[0] != "") {
                  left_image = await MultipartFile.fromFile(images[0],
                      filename: images[0].split("/").last);
                }
                if (images[1] != "") {
                  right_image = await MultipartFile.fromFile(images[1],
                      filename: images[1].split("/").last);
                }
                if (images[2] != "") {
                  front_image = await MultipartFile.fromFile(images[2],
                      filename: images[2].split("/").last);
                }
                if (images[3] != "") {
                  back_image = await MultipartFile.fromFile(images[3],
                      filename: images[3].split("/").last);
                }

                FormData formData = FormData.fromMap({
                  "user_id": SharedPreferencesFunctions.userId,
                  "user_token": SharedPreferencesFunctions.token,
                  "type": widget.type ?? "new",
                  "set": widget.setType ?? "",
                  "category_id": widget.categoryId,
                  "brand_id": widget.brandId,
                  "model_id": widget.modelId,
                   "title": widget.titleForSelectOthers.toString(),
                  "year_of_purchase": widget.yearOfPurchase,
                  "description": widget.description ?? "",
                  "left_image": left_image,
                  "right_image": right_image,
                  "front_image": front_image,
                  "back_image": back_image,
                  "price": widget.price,
                  "is_negotiable": widget.isNegotiable,
                  "country_id": widget.countryId,
                  "state_id": widget.stateId,
                  "city_id": widget.cityId,
                  "district_id": widget.districtId,
                  "latlong": "${widget.lat},${widget.lang}",
                  "pincode": widget.zipcode
                });
                var response = await Dio().post(url, data: formData);

                if (response.data["response"]) {
                  gotoWithoutBack(
                    context,
                    AddedProductResultScreen(
                      response.data['last_id'],
                    ),
                  );
                  showSnackbar(
                    context,
                    adAdded.tr,
                  );
                  setState(() {
                    showCPI = false;
                  });
                }
              } else {
                showSnackbar(
                  context,
                  minimumtwoImages.tr,
                );
                setState(() {
                  showCPI = false;
                });
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
              padding: const EdgeInsets.all(12.0),
              child: Container(
                alignment: Alignment.center,
                color: Colors.grey.shade200,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: barlowBold(
                    text: minimumtwoImages.tr,
                    size: 18,
                    color: black,
                  ),
                ),
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
                              File(
                                images[i],
                              ),
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

  doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    CategoryIdWhilePosting = widget.categoryId.toString();
  }

  getApiUrlByCategoryId() {
    if (widget.categoryId == 5) {
      url = baseUrl + implementsAddUrl;
    } else {
      showSnackbar(
        context,
        errorMessage.tr,
      );
    }
  }

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
  //   if (status.isGranted) {
  //     final pickedFile =
  //         await picker.pickImage(source: ImageSource.camera, imageQuality: 60);
  //     setState(
  //       () {
  //         if (pickedFile != null) {
  //           images[i] = pickedFile.path;
  //           isImageSelected = true;
  //         } else {
  //           showSnackbar(
  //             context,
  //             noImageSelect.tr,
  //           );
  //         }
  //       },
  //     );
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
                }),
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
