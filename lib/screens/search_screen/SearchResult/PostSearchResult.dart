import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/tractor/data.dart';

import '../../../const/colors.dart';
import '../../../const/fonts.dart';
import '../../../language/language_key.dart';
import '../../../services/api_methods.dart';
import '../../../widgets/all_widgets.dart';
import '../../../widgets/distence_widget.dart';
import '../../harvester/harvester_details_screen.dart';
import '../../implements/implements_details_screen.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';

class PostSearchResult extends StatefulWidget {
  final int category_id;
  final int search_id;
  final String query;
  const PostSearchResult({Key? key,
    required this.category_id,
    required this.query,
    required this.search_id}) : super(key: key);

  @override
  State<PostSearchResult> createState() => _PostSearchResultState();
}

class _PostSearchResultState extends State<PostSearchResult> {

  List initDataList = [];
  bool isDataObtained = true;
  List listData = [];
  var ds;
@override
  void initState() {
    doThisONLaunch();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(search_result.tr),
        centerTitle: true,
        backgroundColor: darkgreen,
      ),
      body: Container(
        child: isDataObtained
            ? Center(
          child: progressIndicator(context),
        )
            : Column(
          children: [
            listData.isEmpty && listData.length == 0
                ? Expanded(
              child: Center(
                child: barlowRegular(
                  text: noDataFound.tr,
                  size: 15,
                  color: black,
                ),
              ),
            ) : Expanded(
              child: ListView.builder(
                itemCount: listData.length,
                itemBuilder: (context, index) {
                  var ds = listData[index];
                  AppFonts.dateFormatChanged(ds["created_at"]);
                  return InkWell(
                    onTap: () {
                      ds["category_id"] == 4
                          ? goto(
                        context,
                        HarvesterDetailsScreen(ds),
                      )
                          : ds["category_id"] == 5
                          ? goto(
                        context,
                        ImplementsDetailsScreen(ds),
                      )
                          : goto(
                        context,
                        TractorDetailsScreen(
                          ds,
                        ),
                      );
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius:
                              BorderRadius.circular(8),
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
                                errorWidget:
                                    (context, url, dynamic) {
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
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 190,
                                    child: barlowBold(
                                      text: (ds["brand_name"] ??
                                          "") +
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
                                        text:
                                        "Rs. ${ds["price"] ?? ""}",
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
                                            padding:
                                            const EdgeInsets
                                                .only(left: 4),
                                            child: barlowRegular(
                                              text:
                                              ds["city_name"] ??
                                                  "",
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
                                            padding:
                                            const EdgeInsets
                                                .only(left: 4),
                                            child: barlowRegular(
                                              text: AppFonts.newDate
                                                  .toString(),
                                              color: black,
                                              size: 13,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                  ShowDistanceVertical(UserData.lat,UserData.long,ds['latlong'].toString())
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
  doThisONLaunch() async {

    initDataList = [];

    try{
      initDataList = await ApiMethods().PostSearchResult(widget.category_id, widget.search_id, widget.query);
      print(initDataList);
    }catch(e){
      print('Error : $e');
    }


    setState(() {
      listData = initDataList;
      isDataObtained = false;
    });
    print(listData.length);
  }
}
