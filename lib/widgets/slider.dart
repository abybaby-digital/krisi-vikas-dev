import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'all_widgets.dart';

class Sliders extends StatefulWidget {
  final List<String>? slidersList;

  const Sliders({
    Key? key,
    this.slidersList,
  }) : super(key: key);

  @override
  State<Sliders> createState() => _SlidersState();
}

class _SlidersState extends State<Sliders> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CarouselSlider(
          items: [
            sliderImage(widget.slidersList![0].toString(), context),
            sliderImage(widget.slidersList![1].toString(), context),
            sliderImage(widget.slidersList![2].toString(), context),
            // sliderImage(widget.slidersList![3].toString(), context),
          ],
          options: CarouselOptions(
            initialPage: 0,
            autoPlay: true,
            reverse: false,
            height:180,
            disableCenter: true,
            autoPlayCurve: Curves.fastLinearToSlowEaseIn,
            scrollPhysics: NeverScrollableScrollPhysics(),
            viewportFraction: 1,
          ),
        ),
      ],
    );
  }
}
