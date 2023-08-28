import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:camera/camera.dart';

import '../../../Screens/added_product_result_screen.dart';
import '../../../Screens/capture_from_camera.dart';
import '../../../Screens/notification/notifications_screen.dart';
import '../../../const/utils.dart';
import '../../../widgets/image_picker_custom.dart';
import '../Post_Update/PostSeedUpdate.dart';
import '../Post_Update/PostTyreUpdate.dart';

class TyreEditImageScreen extends StatefulWidget {
  final String? setType;
  final String? position;
  final int? price;
  final String? isNegotiable;
  final String? description;
  final ds;

  const TyreEditImageScreen(
      {Key? key, this.price, this.isNegotiable, this.description, this.ds, this.setType, this.position}
      ) : super(key: key);

  @override
  State<TyreEditImageScreen> createState() => _TyreEditImageScreenState();
}

class _TyreEditImageScreenState extends State<TyreEditImageScreen> {
  bool showCPI = false;

  String url = "";

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

  List<String> images = List.filled(3, "");

  List<String> assetImages = [
    AppImages.defaultImage,
    AppImages.defaultImage,
    AppImages.defaultImage,
  ];
  List<String> imagesType = [
    imageOne.tr,
    imageTwo.tr,
    imageThree.tr,
  ];

  bool isImageSelected = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisONLaunch();
    getApiUrlByCategoryId();
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
                  left: BorderSide(
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

              if (count >= 1) {
                var first_image, second_image, third_image;

                if (images[0] != "") {
                  first_image = await MultipartFile.fromFile(images[0],
                      filename: images[0].split("/").last);
                }
                if (images[1] != "") {
                  second_image = await MultipartFile.fromFile(images[1],
                      filename: images[1].split("/").last);
                }
                if (images[2] != "") {
                  third_image = await MultipartFile.fromFile(images[2],
                      filename: images[2].split("/").last);
                }

                FormData formData = FormData.fromMap({
                  "user_id": SharedPreferencesFunctions.userId,
                  "user_token": SharedPreferencesFunctions.token,
                  "type": widget.setType,
                  'position':widget.position,
                  "description": widget.description,
                  'id':widget.ds['id'],
                  "image1": first_image,
                  "image2": second_image,
                  "image3": third_image,
                  "price": widget.price,
                  "is_negotiable": widget.description,
                });
                var response = await Dio().post(
                    baseUrl+'tyre-update',
                    data: formData);

                if (response.statusCode == 200) {
                  int id = widget.ds['id'];
                  print("ID : $id");
                  gotoWithoutBack(
                      context,
                      PostTyreDetailScreen(id)
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              assetImages[i],
                              fit: BoxFit.cover,
                              height: fullWidth(context) * 0.10,
                              width: fullWidth(context) * 0.10,
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
                  }),
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
  }

  getApiUrlByCategoryId() {
    url = baseUrl + seedAddUrl;
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
  //     setState(() {
  //       if (pickedFile != null) {
  //         images[i] = pickedFile.path;
  //         isImageSelected = true;
  //       } else {
  //         showSnackbar(
  //           context,
  //           noImageSelect.tr,
  //         );
  //       }
  //     });
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
                }),
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
