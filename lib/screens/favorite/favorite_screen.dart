import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/fertilizer/fertilizer_details_screen.dart';
import 'package:krishivikas/Screens/implements/implements_details_screen.dart';
import 'package:krishivikas/Screens/pesticides/pesticides_details_screen.dart';
import 'package:krishivikas/Screens/seeds/seeds_details_screen.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/Screens/tyres/tyres_details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/controllers/favorite_controller.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/screens/harvester/harvester_details_screen.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import '../../const/fonts.dart';

// ignore: must_be_immutable
class FavoriteScreen extends StatelessWidget {
  FavoriteScreen({
    Key? key,
  }) : super(
          key: key,
        );

  FavoriteController favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: favoriteController.isLoading.isTrue
          ? Center(
              child: progressIndicator(context),
            )
          : favoriteController.favAds.length == 0 ||
                  favoriteController.favAds.isEmpty
              ? Center(
                  child: barlowRegular(
                    text: noDataFound.tr,
                    color: black,
                    size: 15,
                  ),
                )
              : Obx(
                  () => ListView.builder(
                    itemCount: favoriteController.favAds.length,
                    itemBuilder: (context, index) {
                      var ds = favoriteController.favAds[index];

                      AppFonts.dateFormatChanged(ds["created_at"]);

                      // return SeedsRelated(ds, context);
                      if (ds["category_id"].toString() == "1" ||
                          ds["category_id"].toString() == "3" ||
                          ds["category_id"].toString() == "4" ||
                          ds["category_id"].toString() == "5") {
                        return TractorGvCard(ds, context);
                      } else if (ds["category_id"].toString() == "6" ||
                          ds["category_id"].toString() == "8" ||
                          ds["category_id"].toString() == "9") {
                        return SeedsRelated(ds, context);
                      } else if (ds["category_id"].toString() == "7") {
                        return TyreRelated(ds, context);
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
    );
  }

  Widget TractorGvCard(dynamic ds, BuildContext context) {
    return InkWell(
      onTap: () {
        print(ds["category_id"]);
        if (ds["category_id"] == "1" || ds["category_id"] == "3") {
          goto(
            context,
            TractorDetailsScreen(ds),
          );
        }
        else if (ds["category_id"] == 4) {
          goto(
            context,
            HarvesterDetailsScreen(ds),
          );
        }
        else if (ds["category_id"] == 5) {
          goto(
            context,
            ImplementsDetailsScreen(ds),
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: ds["front_image"],
                  fit: BoxFit.cover,
                  width: 125,
                  height: 90,
                  placeholder: (context, url) {
                    return Center(
                      child: barlowRegular(
                        text: loading.tr,
                        size: 15,
                        color: black,
                      ),
                    );
                  },
                  errorWidget: (context, url, dynamic) {
                    return Center(
                      child: barlowRegular(
                        text: noImage.tr,
                        size: 15,
                        color: black,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 190,
                      child: barlowBold(
                        text: (ds["brand_name"] ?? "") +
                            " " +
                            (ds["model_name"] ?? ""),
                        size: 16,
                        color: black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        HSpace(5),
                        barlowBold(
                          text: "Rs. ${ds["price"] ?? ""}",
                          size: 17,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                              ),
                              child: barlowRegular(
                                text: ds["city_name"] ?? "",
                                color: black,
                                size: 13,
                              ),
                            )
                          ],
                        ),
                        HSpace(13),
                        Row(
                          children: [
                            Image.asset(
                              "assets/calendar.png",
                              width: 15,
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                              ),
                              child: barlowRegular(
                                text: AppFonts.newDate.toString(),
                                color: black,
                                size: 13,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    VSpace(5),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget SeedsRelated(dynamic ds, BuildContext context) {
    return InkWell(
      onTap: () {
        if (ds["category_id"] == "6") {
          goto(
            context,
            SeedsDetailsScreen(ds),
          );
        }
        if (ds["category_id"] == "8") {
          goto(
            context,
            PesticidesDetailsScreen(ds),
          );
        }
        if (ds["category_id"] == "9") {
          goto(
            context,
            FertilizerDetailsScreen(ds),
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: ds["image1"],
                  fit: BoxFit.cover,
                  width: 125,
                  height: 90,
                  placeholder: (context, url) {
                    return Center(
                      child: barlowRegular(
                        text: loading.tr,
                        size: 15,
                        color: black,
                      ),
                    );
                  },
                  errorWidget: (context, url, dynamic) {
                    return Center(
                      child: barlowRegular(
                        text: noImage.tr,
                        size: 15,
                        color: black,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 190,
                      child: barlowBold(
                        text: (ds["title"] ?? ""),
                        size: 16,
                        color: black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        HSpace(5),
                        barlowBold(
                          text: "Rs. ${ds["price"] ?? ""}",
                          size: 17,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                              ),
                              child: barlowRegular(
                                text: ds["city_name"] ?? "",
                                color: black,
                                size: 13,
                              ),
                            )
                          ],
                        ),
                        HSpace(13),
                        Row(
                          children: [
                            Image.asset(
                              "assets/calendar.png",
                              width: 15,
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                              ),
                              child: barlowRegular(
                                text: AppFonts.newDate.toString(),
                                color: black,
                                size: 13,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    VSpace(5),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget TyreRelated(dynamic ds, BuildContext context) {
    return InkWell(
      onTap: () {
        if (ds["category_id"] == "7") {
          goto(
            context,
            TyresDetailsScreen(ds),
          );
        }
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: ds["image1"],
                  fit: BoxFit.cover,
                  width: 125,
                  height: 90,
                  placeholder: (context, url) {
                    return Center(
                      child: barlowRegular(
                        text: loading.tr,
                        size: 15,
                        color: black,
                      ),
                    );
                  },
                  errorWidget: (context, url, dynamic) {
                    return Center(
                      child: barlowRegular(
                        text: noImage.tr,
                        size: 15,
                        color: black,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 190,
                      child: barlowBold(
                        text: (ds["brand_name"] ?? "") +
                            " " +
                            (ds["model_name"] ?? ""),
                        size: 16,
                        color: black,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        HSpace(5),
                        barlowBold(
                          text: "Rs. ${ds["price"] ?? ""}",
                          size: 17,
                          color: kPrimaryColor,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                              ),
                              child: barlowRegular(
                                text: ds["city_name"] ?? "",
                                color: black,
                                size: 13,
                              ),
                            )
                          ],
                        ),
                        HSpace(13),
                        Row(
                          children: [
                            Image.asset(
                              "assets/calendar.png",
                              width: 15,
                              height: 15,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 4,
                              ),
                              child: barlowRegular(
                                text: AppFonts.newDate.toString(),
                                color: black,
                                size: 13,
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    VSpace(5),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
