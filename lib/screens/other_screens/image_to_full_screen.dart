import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class ImageToFullScreen extends StatefulWidget {
  final String url;

  ImageToFullScreen(this.url);

  @override
  _ImageToFullScreenState createState() => _ImageToFullScreenState();
}

class _ImageToFullScreenState extends State<ImageToFullScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          child: Container(
            width: fullWidth(context),
            height: fullHeight(context),
            color: Colors.black,
            child: InteractiveViewer(
              boundaryMargin: const EdgeInsets.all(20.0),
              minScale: 0.1,
              maxScale: 2.6,
              child: CachedNetworkImage(
                imageUrl: widget.url,
                placeholder: (context, url) {
                  return Image.asset(
                    AppImages.bannerPlaceHolder,
                  );
                },
                errorWidget: (context, url, error) {
                  return Image.asset(
                    AppImages.bannerPlaceHolder,
                  );
                },
              ),
            ),
          ),
        ),
        Positioned(
            top: 70,
            left: fullWidth(context) - 70,
            child: Container(
              // height: 50,
              // width: 50,
              child: IconButton(
                iconSize: 40,
                icon: Icon(
                  Icons.close,
                  color: white,
                ),
                onPressed: () {
                  goBack(context);
                },
              ),
              // color: red,
            )),
      ]),
    );
  }
}
