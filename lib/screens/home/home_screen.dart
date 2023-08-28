import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:krishivikas/Screens/account/login_screen.dart';
import 'package:krishivikas/Screens/chat/all_chats_list_screen.dart';
import 'package:krishivikas/Screens/account/profile_screen.dart';
import 'package:krishivikas/Screens/fertilizer/fertilizer_details_screen.dart';
import 'package:krishivikas/Screens/harvester/harvester_details_screen.dart';
import 'package:krishivikas/Screens/implements/implements_details_screen.dart';
import 'package:krishivikas/Screens/pesticides/pesticides_details_screen.dart';
import 'package:krishivikas/Screens/rent/rent_category_screen.dart';
import 'package:krishivikas/Screens/seeds/seeds_details_screen.dart';
import 'package:krishivikas/Screens/select_category_screen.dart';
import 'package:krishivikas/Screens/select_user_type_screen.dart';
import 'package:krishivikas/Screens/tractor/ads.dart';
import 'package:krishivikas/Screens/tractor/data.dart';
import 'package:krishivikas/Screens/tractor_details_screen.dart';
import 'package:krishivikas/Screens/tyres/tyres_details_screen.dart';
import 'package:krishivikas/const/api_urls.dart';
import 'package:krishivikas/const/app_images.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/const/global.dart';
import 'package:krishivikas/screens/maintenace/maintenancePage.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/services/save_user_info.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:krishivikas/widgets/banner_screen.dart';
import 'package:krishivikas/widgets/categories.dart';
import 'package:krishivikas/widgets/custom_container_button.dart';
import 'package:krishivikas/widgets/krishi_item_ads.dart';
import 'package:krishivikas/widgets/slider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../language/language_key.dart';
import '../Iffco/IFFCO_Model.dart';
import '../category/product_selection_screen.dart';
import '../favorite/favorite_screen.dart';
import '../notification/notification.dart';
import '../notification/notifications_screen.dart';
import 'package:in_app_update/in_app_update.dart';

import '../search_screen/search_page.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AppUpdateInfo? _updateInfo;

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  int currentIndex = 0;

  bool isDataObtained = false;

  List<Widget> body = [
    HomeScreen(),
    FavoriteScreen(),
    AllChatsListScreen(),
    ProfileScreen(),
  ];

  var title = [
    appTitle.tr,
    favouriteAds.tr,
    chat.tr,
    profile.tr,
  ];

  var isReg;

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> appUpdateRequired() async {
    await InAppUpdate.checkForUpdate().then((info) {
      print("65");
      if (info.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().then((value) {
          if (value == AppUpdateResult.success) {
            setState(() {});
            print("70");
          } else {
            print("72");
            exit(0);
          }
          setState(() {});
        }).catchError((e) {
          showSnack(e.toString());
          print("78");

          setState(() {
            exit(0);
          });
        });
      } else {
        setState(() {});
      }
    }).catchError((e) {
      print("89");
      showSnack(e.toString());
      setState(() {});
    });
  }

  void showSnack(String text) {
    if (_scaffoldKey.currentContext != null) {
      ScaffoldMessenger.of(_scaffoldKey.currentContext!)
          .showSnackBar(SnackBar(content: Text(text)));
    }
  }
  String locationDataAv = "";

  getLocationData() async{
    await FirebaseFirestore.instance.collection('location').doc(FirebaseAuth.instance.currentUser?.uid).get().then((value) {
      setState(() {
        locationDataAv = value['location'];
      });
    });
    if(locationDataAv!='true'){
      FirebaseAuth.instance.signOut();
      gotoWithoutBack(
        context,
        LoginScreen(),
      );
    }
  }

  checkMaintenance() async {
    await ApiMethods().getMaintenance().then((value) {
      print(value.response);
      if(value.response==true){
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MaintenancePage()));
      }
    });
  }


  getCurrentLocation() async{
    Position position = await ApiMethods().getGeoLocationPosition();
    double? lat = position.latitude;
    double? long = position.longitude;
    setState(() {
      UserData.lat = lat;
      UserData.long = long;
    });
    //print(long);

  }

  bool? iffco_on = false;
  String? iffco_banner = '';
  checkIFFCO_ON_OFF() async{
    await ApiMethods().getIFFCO_Check().then((value) {
      setState(() {
        iffco_on = value.response;
        iffco_banner = value.image;
      });
    });
  }

  var addressInfo;
  getZipCodeLocation() async{
    addressInfo = await ApiMethods().getDataByPostApi(
      {
        "pincode": SharedPreferencesFunctions.zipcode
      },
      baseUrl + zipCodeUrl,
    );
      if(UserData.long==null||UserData.lat==null)
        print("Location Not Enable");
        setState(() {
          UserData.lat = double.parse(addressInfo[0]["latitude"]);
          UserData.long = double.parse(addressInfo[0]["longitude"]);
        }
    );

  }

  Future<void> initializeNotifications() async {
    AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic notifications',
          defaultColor: Colors.teal,
          ledColor: Colors.teal,
        ),
      ],
    );
    showNotification();
  }

  Future<void> showNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 0,
        channelKey: 'basic_channel',
        title: 'Please Complete Registration',
        body: 'Tap here to complete registration',
      ),
      actionButtons: [
        NotificationActionButton(
          key: 'registration_action',
          label: 'Complete Registration',
          actionType: ActionType.Default,
        ),
      ],
    );
  }

  @override
  void initState() {
    doThisOnLaunch();
    getCurrentLocation();
    getZipCodeLocation();
    getLocationData();
    checkMaintenance();
    checkBannerAndVideoList();
    checkIFFCO_ON_OFF();
    appUpdateRequired();
    print("currentLocation");
    print(currentLocation);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    handleDynamicLinks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // dynamicLinkService.handleDynamicLinks(context);
    return WillPopScope(
      child: Scaffold(
        extendBody: true,
        backgroundColor: white,
        bottomNavigationBar: (title[currentIndex] == title[3])
            ? SizedBox.shrink()
            : BottomAppBar(
          elevation: 5,
          color: darkgreen,
          shape: const CircularNotchedRectangle(),
          child: SizedBox(
            height: 56,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                            () {
                          currentIndex = 0;
                        },
                      );
                    },
                    icon: Icon(
                      Icons.home,
                      color: white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(
                            () {
                          currentIndex = 1;
                        },
                      );
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: white,
                    ),
                  ),
                  const SizedBox(
                    width: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      setState(
                            () {
                          currentIndex = 2;
                        },
                      );
                    },
                    icon: Icon(
                      Icons.chat_bubble_rounded,
                      color: white,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(
                            () {
                          goto(context, ProfileScreen());
                        },
                      );
                    },
                    icon: Icon(
                      Icons.person,
                      color: white,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: (title[currentIndex] == title[3])
            ? SizedBox.shrink()
            : floatingButton(context),
        appBar: (title[currentIndex] == title[0])
            ? AppBar(
                  automaticallyImplyLeading: true,
                  leadingWidth: 0,
                  title: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title[0],
                      style: TextStyle(
                        color: white,
                        fontFamily: "YesevaOne",
                        fontStyle: FontStyle.normal,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  leading: Text(""),
                  backgroundColor: darkgreen,
                  actions: [
                    IconButton(
                      onPressed: () {
                        goto(
                          context,
                          SearchScreen(),
                        );
                      },
                      icon: Icon(
                        Icons.search,
                        color: white,
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                       var telUrl =  Uri.parse('tel:8100975657');
                        if (await canLaunchUrl(telUrl)) {
                        await launchUrl(telUrl,mode: LaunchMode.externalApplication);
                        } else {
                        throw 'Could not launch $telUrl';
                        }
                      },
                      icon: Icon(
                        Icons.call,
                        color: white,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationsPage()));
                      },
                      icon: Icon(
                        Icons.notifications,
                        color: white,
                      ),
                    ),
                  ],
                )
            : AppBar(
                title: barlowBold(
                  text: title[currentIndex] == title[3]
                      ? profile.tr
                      : title[currentIndex],
                  color: white,
                  size: 20,
          ),
                    automaticallyImplyLeading: true,
                    backgroundColor: darkgreen,
                    leading: IconButton(
                      icon: Icon(
                        (Platform.isAndroid)
                            ? Icons.arrow_back
                            : Icons.arrow_back_ios_new_rounded,
                        color: white,
                      ),
                      onPressed: () => gotoWithoutBack(
                        context,
                        HomeScreen(),
                      ),
                    ),
                    actions: [
                      (title[currentIndex] == title[3])
                          ? IconButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationsPage()));
                            },
                            icon: Icon(
                              Icons.notifications,
                              color: white,
                            ),
                        )
                          : SizedBox.shrink(),
                    ],
        ),
        body: currentIndex == 0
            ? RefreshIndicator(
          onRefresh: () {
            return Future.delayed(Duration(seconds: 1), () {
              // checkBannerAndVideoList();
              // doThisOnLaunch();
              // HomeScreen();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(),
                  ));
            });
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                (isDataObtained)
                    ? Sliders(
                  slidersList: appBannerVideo,
                )
                    : SizedBox.shrink(),
                VSpace(10),
                Container(
                  height: fullHeight(context) * 0.2,
                  child: Categories(),
                ),
                Stack(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomContainerButton2(
                            title: rent.tr,
                            onTap: () async {

                              var userInfo = await ApiMethods().getUserInfoByPostApi(
                                baseUrl + profileUrl,
                                await SharedPreferencesFunctions.userId!,
                                await SharedPreferencesFunctions.token!,
                              );

                              isReg = userInfo["user_type_id"];

                              if (userInfo["user_type_id"] == 1 || userInfo["user_type_id"] == 2) {
                                IsRegistered = true;
                              }

                              await goto(
                                context,
                                isReg == 1 || isReg == 2
                                    ? RentCategoryScreen()
                                    : SelectUserType("home"),
                              );
                            }),
                        CustomContainerButton2(
                            title: sell.tr,
                            onTap: () async {

                              var userInfo = await ApiMethods().getUserInfoByPostApi(
                                baseUrl + profileUrl,
                                await SharedPreferencesFunctions.userId!,
                                await SharedPreferencesFunctions.token!,
                              );

                              isReg = userInfo["user_type_id"];

                              if (userInfo["user_type_id"] == 1 || userInfo["user_type_id"] == 2) {
                                IsRegistered = true;
                              }

                              await goto(
                                context,
                                isReg == 1 || isReg == 2
                                    ? SelectCategoryScreen()
                                    : SelectUserType("home"),
                              );
                            })
                      ],
                    ),
                  ],
                ),
                Ads(
                  categoryType: tractor.tr,
                  categoryId: 1,
                  tabBar: "Tractor",
                ),
                VSpace(10),
                Ads(
                  categoryType: goodsVehicle.tr,
                  categoryId: 3,
                  tabBar: "Vehicles",
                ),
                '$iffco_banner'!=''?
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>IFFCO_Product_Screen()));
                          },
                          child: Image.network('$iffco_banner'))),
                ):Container(),
                KrishiItemAds(
                  seedId: 6,
                  pesticidesId: 8,
                  fertilizerID: 9,
                  categoryTitle: farmProducts.tr,
                  tabSeed: seeds.tr,
                  tabPesticides: pesticides.tr,
                  tabFertilizer: fertilizer.tr,
                ),
                VSpace(10),
                (isDataObtained)
                    ? BannerScreen(
                  photo: appBannerVideo[3].toString(),
                )
                    : progressIndicator(context),
                VSpace(10),
                // const PopularBrands(),
                Ads(
                  categoryType: harvester.tr,
                  categoryId: 4,
                  tabBar: "Harvester",
                ),
                // VSpace(15),
                // // const PopularBrands(),
                // Ads(
                //   categoryType: "Power Tiller",
                //   categoryId: 9,
                //   tabBar: "Power Tiller",
                // ),
                VSpace(15),
                buildWhatYouDo(
                  context,
                  AppImages.buy_rent_banner,
                ),
                VSpace(15),
                Ads(
                  categoryType: implement.tr,
                  categoryId: 5,
                  tabBar: "Implements",
                ),
                VSpace(10),
                Ads(
                  categoryType: tyre.tr,
                  categoryId: 7,
                  tabBar: "Tyres",
                ),
                VSpace(30),
                (isDataObtained)
                    ? BannerScreen(
                  photo: appBannerVideo[4].toString(),
                )
                    : progressIndicator(context),
                VSpace(80),
              ],
            ),
          ),
        )
            : body[currentIndex],
      ),
      onWillPop: () {
        return showExitPopup(context);
      },
    );
  }

  doThisOnLaunch() async {

    await SharedPreferencesFunctions().getUserId();
    await SharedPreferencesFunctions().getToken();

    var userInfo = await ApiMethods().getUserInfoByPostApi(
      baseUrl + profileUrl,
      await SharedPreferencesFunctions.userId!,
      await SharedPreferencesFunctions.token!,
    );

    if (userInfo["user_type_id"] == 1 || userInfo["user_type_id"] == 2) {
      setState(
            () {
          IsRegistered = true;
          CurrentUserType = userInfo["user_type_id"];
        },
      );

    }
    print("IsRegistered = ");
    print(IsRegistered);
    if(!IsRegistered){
      initializeNotifications();
      print("Notification Sent For Not Registered");
    }
  }

  checkBannerAndVideoList() {
    if (appBannerVideo.isEmpty) {
      getBannerAndVideoList();
      setState(() {});
    } else {
      setState(() {});
      isDataObtained = true;
    }
  }

  getBannerAndVideoList() async {
    appBannerVideo = [];
    var result = await ApiMethods().getBanners(
      baseUrl + bannersVideosUrl,
    );

    var sliderType;

    if (SharedPreferencesFunctions().getLanguage() == "English") {
      sliderType = "slider_en";
    } else if (SharedPreferencesFunctions().getLanguage() == "Hindi") {
      sliderType = "slider_hn";
    } else {
      sliderType = "slider_bn";
    }
    result.forEach((element) {
      if (element['name'].toString().contains(sliderType)) {
        appBannerVideo.add(
          element['value'],
        );
      }
    });

    setState(() {});
    isDataObtained = true;
  }

  Widget floatingButton(context) {
    return FloatingActionButton(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      onPressed: () async {
        var userInfo = await ApiMethods().getUserInfoByPostApi(
          baseUrl + profileUrl,
          await SharedPreferencesFunctions.userId!,
          await SharedPreferencesFunctions.token!,
        );

        isReg = userInfo["user_type_id"];

        if (userInfo["user_type_id"] == 1) {
          IsRegistered = true;
        }

        await goto(
          context,
          isReg == 1 || isReg == 2
              ? ProductSelectionScreen()
              : SelectUserType("home"),
        );
        setState(() {});
      },
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          border: Border.all(
            color: white,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(
            40,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.add,
            size: 40,
            color: white,
          ),
        ),
      ),
    );
  }

  Widget buildWhatYouDo(context, String image) {
    return Container(
      width: fullWidth(context),
      height: 200,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            AppImages.buy_rent_banner,
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          VSpace(10),
          barlowBold(
            text: whatWouldYouLikeToDo.tr,
            color: white,
            size: 20,
          ),
          VSpace(30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomContainerButton(
                  title: rent.tr,
                  onTap: () async {
                    await goto(
                      context,
                      IsRegistered
                          ? RentCategoryScreen()
                          : SelectUserType("home"),
                    );
                    setState(() {});
                  }),
              CustomContainerButton(
                  title: sell.tr,
                  onTap: () async {
                    await goto(
                      context,
                      IsRegistered
                          ? SelectCategoryScreen()
                          : SelectUserType("home"),
                    );
                    setState(() {});
                  })
            ],
          )
        ],
      ),
    );
  }

  showExitPopup(context) {
    (currentIndex == 0)
        ? showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 90,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                barlowRegular(
                  text: exitApp.tr,
                  color: black,
                  size: 15,
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: barlowBold(
                          text: yes.tr,
                          color: white,
                          size: 15,
                        ),
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: darkgreen,
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: barlowBold(
                          text: no.tr,
                          color: black,
                          size: 15,
                        ),
                        style: ElevatedButton.styleFrom(
                          // ignore: deprecated_member_use
                          primary: white,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    )
        : gotoUtillBack(
      context,
      HomeScreen(),
    );
  }

  Future<void> handleDynamicLinks() async {
    final PendingDynamicLinkData? initialLink =
    await FirebaseDynamicLinks.instance.getInitialLink();
    // await SharedPreferencesFunctions().getUserId();
    // await SharedPreferencesFunctions().getToken();
    String dynamicLinkItemId = "";
    String dynamicLinkItemCategory = "";
    String Shareurl = baseUrl + sharingUrl;
    List ShareItemList = [];
    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      // ignore: unnecessary_null_comparison
      if (deepLink != null) {
        if (deepLink.queryParameters["itemId"] != "") {
          dynamicLinkItemId = deepLink.queryParameters["itemId"].toString();
          dynamicLinkItemCategory =
              deepLink.queryParameters["ItemCategory"].toString();

          List newTractorsList = await ApiMethods().getSingleProductApi(
            Shareurl,
            // SharedPreferencesFunctions.userId!,
            // SharedPreferencesFunctions.token!,
            dynamicLinkItemCategory.toString(),
            dynamicLinkItemId.toString(),
          );

          try {
            ShareItemList = [];
            ShareItemList.addAll(newTractorsList);
          } catch (e) {
            Get.snackbar(
              "Error",
              e.toString(),
            );
          }
          if (ShareItemList.isNotEmpty) {
            if (dynamicLinkItemCategory == "1" ||
                dynamicLinkItemCategory == "3") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TractorDetailsScreen(ShareItemList[0])));
              });
              // goto(context, TractorDetailsScreen(ShareItemList[0]));
            } else if (dynamicLinkItemCategory == "4") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HarvesterDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "5") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ImplementsDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "7") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TyresDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "6") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SeedsDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "8") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PesticidesDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "9") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        FertilizerDetailsScreen(ShareItemList[0])));
              });
            } else {
              Future(() {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              });
            }
          }
        }
      }
    }

    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) async {
      final Uri deepLink = dynamicLinkData.link;
      // ignore: unnecessary_null_comparison
      if (deepLink != null) {
        if (deepLink.queryParameters["itemId"] != "") {
          dynamicLinkItemId = deepLink.queryParameters["itemId"].toString();
          dynamicLinkItemCategory =
              deepLink.queryParameters["ItemCategory"].toString();

          List newTractorsList = await ApiMethods().getSingleProductApi(
            Shareurl,
            dynamicLinkItemCategory.toString(),
            dynamicLinkItemId.toString(),
          );

          try {
            ShareItemList = [];
            ShareItemList.addAll(newTractorsList);
          } catch (e) {
            Get.snackbar(
              "Error",
              e.toString(),
            );
          }
          if (ShareItemList.isNotEmpty) {
            if (dynamicLinkItemCategory == "1" ||
                dynamicLinkItemCategory == "3") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TractorDetailsScreen(ShareItemList[0])));
              });
              // goto(context, TractorDetailsScreen(ShareItemList[0]));
            } else if (dynamicLinkItemCategory == "4") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        HarvesterDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "5") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        ImplementsDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "7") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        TyresDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "6") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SeedsDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "8") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        PesticidesDetailsScreen(ShareItemList[0])));
              });
            } else if (dynamicLinkItemCategory == "9") {
              Future(() {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        FertilizerDetailsScreen(ShareItemList[0])));
              });
            } else {
              Future(() {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              });
            }
          }
        }
      }
    }).onError((error) {
      print('Link Failed: ${error.message}');
    });
  }
// void _handleDeepLink(itemId, dynamicLinkItemCategory, BuildContext context) {
//   if (ShareItemList.isNotEmpty) {
//     if (dynamicLinkItemCategory == "1" || dynamicLinkItemCategory == "3") {
//       Future(() {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     TractorDetailsScreen(ShareItemList[0])));
//       });
//       // goto(context, TractorDetailsScreen(ShareItemList[0]));
//     } else if (dynamicLinkItemCategory == "4") {
//       Future(() {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     HarvesterDetailsScreen(ShareItemList[0])));
//       });
//     } else if (dynamicLinkItemCategory == "5") {
//       Future(() {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     ImplementsDetailsScreen(ShareItemList[0])));
//       });
//     } else if (dynamicLinkItemCategory == "7") {
//       Future(() {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => TyresDetailsScreen(ShareItemList[0])));
//       });
//     } else if (dynamicLinkItemCategory == "6") {
//       Future(() {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => SeedsDetailsScreen(ShareItemList[0])));
//       });
//     } else if (dynamicLinkItemCategory == "8") {
//       Future(() {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     PesticidesDetailsScreen(ShareItemList[0])));
//       });
//     } else if (dynamicLinkItemCategory == "9") {
//       Future(() {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) =>
//                     FertilizerDetailsScreen(ShareItemList[0])));
//       });
//     } else {
//       Future(() {
//         Navigator.push(
//             context, MaterialPageRoute(builder: (context) => HomeScreen()));
//       });
//     }
//   }
// }
}
