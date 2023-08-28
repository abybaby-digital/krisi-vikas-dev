import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/fonts.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

import '../../const/api_urls.dart';

class BrandShortDetails extends StatefulWidget {
  final int masterBrandId;
  BrandShortDetails(this.masterBrandId);

  @override
  State<BrandShortDetails> createState() => _BrandShortDetailsState();
}

class _BrandShortDetailsState extends State<BrandShortDetails> {
  int districtId = 0000;

  doThisONLaunch() async {
    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();
    await SharedPreferencesFunctions().getUserZipcode();

    var addressInfo = await ApiMethods().getDataByPostApi(
      {"pincode": SharedPreferencesFunctions.zipcode},
      baseUrl + zipCodeUrl,
    );
    if (addressInfo.isNotEmpty) {
      districtId = addressInfo[0]["district_id"];
    }

    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    doThisONLaunch();
  }

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkgreen,
        title: Text(
          "All brand tractors",
          style: TextStyle(
            fontFamily: AppFonts.barlowRegular,
            fontStyle: FontStyle.normal,
          ),
        ),
      ),
      body: FutureBuilder<List>(
          future: ApiMethods().getDataByPostApi(
              {"master_brand_id": widget.masterBrandId, "district": districtId},
              "https://kv.ratemyevent.in/api/master-brand-data"),
          builder: (context, snapshot) {
            return snapshot.hasData
                ? snapshot.data!.length == 0
                    ? progressIndicator(context)
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var ds = snapshot.data![index];
                          return InkWell(
                            onTap: () {
                              goto(
                                context,
                                TractorDetailsScreen(ds),
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
                                                child: Text("Loading"),
                                              );
                                            },
                                            errorWidget:
                                                (context, url, dynamic) {
                                              return Center(
                                                  child: Text("No Image"));
                                            },
                                          )),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              ds["brand_name"] ?? "",
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              children: [
                                                Image.asset(
                                                  "assets/rupee.png",
                                                  width: 15,
                                                  height: 15,
                                                ),
                                                HSpace(5),
                                                Text(
                                                  "Rs. ${ds["price"] ?? ""}",
                                                  style: TextStyle(
                                                      fontSize: 17,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: kPrimaryColor),
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
                                                    const Icon(
                                                      Icons.location_on,
                                                      size: 16,
                                                      color: Colors.grey,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4),
                                                      child: Text(
                                                          ds["state_name"] ??
                                                              ""),
                                                    )
                                                  ],
                                                ),
                                                HSpace(8),
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons
                                                          .access_time_outlined,
                                                      size: 16,
                                                      color: Colors.grey,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 4),
                                                      child: Text(
                                                          ds["created_at"]
                                                              .toString()
                                                              .substring(
                                                                  0, 10)),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            ),
                          );
                        },
                      )
                : progressIndicator(context);
          }),
    );
  }
}
