import 'package:flutter/material.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class CustomHorizontalProductListWidget extends StatelessWidget {
  final String? image;
  final String? name;
  final String? location;
  final String? price;

  const CustomHorizontalProductListWidget({
    Key? key,
    this.image,
    this.name,
    this.location,
    this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: 12,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              width: fullWidth(context) * 0.5,
              decoration: BoxDecoration(
                color: white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: grey,
                    blurRadius: 2,
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(8),
                        topRight: Radius.circular(8),
                      ),
                      child: Image.asset(
                        AppImages.sliderImage1,
                        width: fullWidth(context),
                        height: fullHeight(context) * 0.13,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 8,
                      ),
                      child: barlowBold(
                        text: "Mahindra JIVO",
                        color: black,
                        size: 15,
                      ),
                    ),
                    Divider(
                      color: grey,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: grey,
                                size: 18,
                              ),
                              barlowRegular(
                                text: "Kolkata",
                                color: grey,
                                size: 12,
                              ),
                            ],
                          ),
                          barlowBold(
                            text: "Rs.50000",
                            color: kPrimaryColor,
                            size: 12,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
