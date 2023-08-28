import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class ImageToFullScreenSlider extends StatefulWidget {
  final String urlData;
  final List SliderListData;
  final int IndexData;

  ImageToFullScreenSlider({
    Key? key,
    required this.urlData,
    required this.SliderListData,
    required this.IndexData,
  }) : super(key: key);

  @override
  _ImageToFullScreenSliderState createState() =>
      _ImageToFullScreenSliderState();
}

class _ImageToFullScreenSliderState extends State<ImageToFullScreenSlider> {
  String titleText = "";
  int startPosition = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisOnLaunch();
    print(widget.IndexData);
    print(widget.SliderListData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          child: GestureDetector(
            child: Container(
              width: fullWidth(context),
              height: fullHeight(context),
              color: Colors.black,
              child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(20.0),
                minScale: 0.1,
                maxScale: 2.6,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: fullHeight(context),
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    enableInfiniteScroll: false,
                    initialPage: startPosition,
                    onPageChanged: (index, reason) {
                      setState(() {
                        ChangeTitleValue(index);
                      });
                    },
                    // autoPlay: false,
                  ),
                  items: widget.SliderListData.map((item) => Container(
                        child: Center(
                          child: CachedNetworkImage(
                            imageUrl: item["imageItem"],
                            fit: BoxFit.fitWidth,
                            width: fullWidth(context),
                            height: fullHeight(context) * 0.65,
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
                      )).toList(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
            top: 70,
            left: fullWidth(context) - 70,
            child: Container(
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
            )),
        Positioned(
            top: 80,
            left: 20,
            child: Container(
              child: barlowBold(
                  color: green, maxLine: 1, size: 25, text: titleText),
            )),
      ]),
    );
  }

  void doThisOnLaunch() {
    for (int i = 0; i < widget.SliderListData.length; i++) {
      if (widget.SliderListData[i]["itemIndex"] == widget.IndexData) {
        startPosition = i;
        ChangeTitleValue(i);
      }
    }
  }

  void ChangeTitleValue(IndexDataForChange) {
    for (int i = 0; i < widget.SliderListData.length; i++) {
      if (i == IndexDataForChange) {
        titleText = widget.SliderListData[i]["title"];
      }
    }
  }
}
