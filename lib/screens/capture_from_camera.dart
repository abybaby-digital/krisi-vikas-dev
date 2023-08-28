import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/utils.dart';

import '../const/colors.dart';
import '../widgets/all_widgets.dart';

// TakePictureScreen(
//         // Pass the appropriate camera to the TakePictureScreen widget.
//         camera: firstCamera,
// )

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  TakePictureScreen({
    key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }
  String compressedImagePath = "";
  customCompressed({required String imagePathToCompress, quality = 100, percentage = 15}) async{
    await FlutterNativeImage.compressImage(
        imagePathToCompress,
        quality: 100,
        percentage: 70
    ).then((value) {
      print(value.absolute.path);
      setState(() {
        compressedImagePath = value.absolute.path;
      });
    });
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: barlowBold(
          text: 'Take a picture',
          color: white,
          size: 20,
        ),
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: Stack(children: [
        Container(
          height: fullHeight(context) * 0.75,
          width: fullWidth(context),
          color: white,
          child: FutureBuilder<void>(
            future: _initializeControllerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                // If the Future is complete, display the preview.
                return CameraPreview(_controller);
              } else {
                // Otherwise, display a loading indicator.
                return const Center(
                    child: CircularProgressIndicator(color: Colors.green));
              }
            },
          ),
        ),
        Positioned(
          left: fullWidth(context) * 0.25,
          top: fullHeight(context) * 0.65,
          child: Center(
            child: Image.asset(
              AppImages.kv_logo_one,
              width: 180,
              height: 60,
            ),
          ),
        ),
      ]),

      bottomNavigationBar: Container(
        height: fullHeight(context) * 0.15,
        width: fullWidth(context),
        color: white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Material(
                elevation: 10,
                borderRadius: BorderRadius.all(Radius.circular(100)),
                color: green,
                child: InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(100)),
                  onTap: () async {
                    // Take the Picture in a try / catch block. If anything goes wrong,
                    // catch the error.
                    try {
                      // Ensure that the camera is initialized.
                      await _initializeControllerFuture;

                      // Attempt to take a picture and get the file `image`
                      // where it was saved.
                      final image = await _controller.takePicture();

                      if (!mounted) return;
                      await customCompressed(imagePathToCompress: image.path);
                      // If the picture was taken, display it on a new screen.
                      await Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => DisplayPictureScreen(
                            // Pass the automatically generated path to
                            // the DisplayPictureScreen widget.
                            imagePath: compressedImagePath,
                          ),
                        ),
                      )
                          .then((object) {
                        if (Utils.capturedImagePath.isNotEmpty) {
                          Navigator.pop(context);
                        }
                      });
                      ;
                    } catch (e) {
                      // If an error occurs, log the error to the console.
                      print(e);
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 45,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              color: white,
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: fullHeight(context) * 0.20,
      //   width: fullWidth(context),
      //   color: white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Container(),
      //       Container(
      //         child: RotatedBox(
      //             quarterTurns: 1,
      //             child: Column(
      //               children: [
      //                 Center(
      //                   child: Material(
      //                     elevation: 10,
      //                     borderRadius: BorderRadius.all(Radius.circular(100)),
      //                     color: green,
      //                     child: InkWell(
      //                       borderRadius:
      //                           BorderRadius.all(Radius.circular(100)),
      //                       onTap: () async {
      //                         // Take the Picture in a try / catch block. If anything goes wrong,
      //                         // catch the error.
      //                         try {
      //                           // Ensure that the camera is initialized.
      //                           await _initializeControllerFuture;

      //                           // Attempt to take a picture and get the file `image`
      //                           // where it was saved.
      //                           final image = await _controller.takePicture();

      //                           if (!mounted) return;

      //                           // If the picture was taken, display it on a new screen.
      //                           await Navigator.of(context)
      //                               .push(
      //                             MaterialPageRoute(
      //                               builder: (context) => DisplayPictureScreen(
      //                                 // Pass the automatically generated path to
      //                                 // the DisplayPictureScreen widget.
      //                                 imagePath: image.path,
      //                               ),
      //                             ),
      //                           )
      //                               .then((object) {
      //                             if (Utils.capturedImagePath.isNotEmpty) {
      //                               Navigator.pop(context);
      //                             }
      //                           });
      //                           ;
      //                         } catch (e) {
      //                           // If an error occurs, log the error to the console.
      //                           print(e);
      //                         }
      //                       },
      //                       child: Padding(
      //                         padding: const EdgeInsets.all(12.0),
      //                         child: const Icon(
      //                           Icons.camera_alt,
      //                           size: 45,
      //                           color: Colors.white,
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 ),
      //                 VSpace(8),
      //                 barlowBold(
      //                   color: black,
      //                   maxLine: 2,
      //                   size: 15,
      //                   text: "CLICK HERE",
      //                 ),
      //               ],
      //             )),
      //         color: white,
      //       ),
      //       Container(
      //         child: RotatedBox(
      //             quarterTurns: 1,
      //             child: Column(
      //               children: [
      //                 Container(
      //                   width: fullWidth(context) * 0.20,
      //                   height: fullHeight(context) * 0.10,
      //                   child: Center(
      //                     child: Image.asset(
      //                       AppImages.cam_rotate,
      //                     ),
      //                   ),
      //                 ),
      //                 Padding(
      //                   padding: const EdgeInsets.only(left: 5.0),
      //                   child: barlowBold(
      //                     color: black,
      //                     maxLine: 2,
      //                     size: 12,
      //                     text: "Click in landscape mode for best experience",
      //                   ),
      //                 ),
      //               ],
      //             )),
      //         color: white,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: darkgreen,
          title: barlowBold(
            text: 'Choice the Picture',
            color: white,
            size: 20,
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: fullHeight(context) * 0.7,
                  child: Image.file(File(imagePath)),
                ),
                Container(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Utils.capturedImagePath = "";

                              Navigator.pop(context);
                            },
                            child: const Text('Cancel'),
                            style:
                                ElevatedButton.styleFrom(backgroundColor: red),
                          ),
                        )),
                        Container(
                            child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              Utils.capturedImagePath = imagePath;
                              Navigator.pop(context);
                            },
                            child: const Text('Ok'),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: green),
                          ),
                        )),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}


// Image.file(File(imagePath))