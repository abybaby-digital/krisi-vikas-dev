import 'package:flutter/material.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class BannerScreen extends StatelessWidget {
  final String? photo;

  const BannerScreen({
    Key? key,
    this.photo,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return setCloudImageFull(
      photo.toString(),
      context,
    );
  }
}
