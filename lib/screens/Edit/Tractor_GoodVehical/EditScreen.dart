import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:krishivikas/Screens/account/profile_screen.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/screens/Edit/Tractor_GoodVehical/EditImageScreen.dart';
import 'package:krishivikas/screens/Edit/Post_Update/PostGVUpdate.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:dio/dio.dart';

import '../../../const/api_urls.dart';
import '../../../const/app_images.dart';
import '../../../language/language_key.dart';
import '../../../services/save_user_info.dart';
import '../Post_Update/PostTractorUpdate.dart';

class EditScreen extends StatefulWidget {
  final ds;
  const EditScreen({Key? key, required this.ds}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  void _scaleDialog() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: _MarkSoldAlert(ctx),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _MarkSoldAlert(BuildContext context) {
    return AlertDialog(
        title: Text(scale_sold.tr),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await ApiMethods()
                      .MarkItemSold(
                      int.parse(widget.ds['category_id']), widget.ds['id'])
                      .then((value) {
                    gotoWithoutBack(context, ProfileScreen());
                    Fluttertoast.showToast(
                        msg: 'Product marked sold successfully',
                        textColor: Colors.white,
                        backgroundColor: darkgreen,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  });
                },
                child: Text("Yes"),
                style: ElevatedButton.styleFrom(backgroundColor: darkgreen)),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
                style: ElevatedButton.styleFrom(backgroundColor: darkgreen))
          ],
        ));
  }

  void _scaleDialogForDisablePost() {
    showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) {
        return Container();
      },
      transitionBuilder: (ctx, a1, a2, child) {
        var curve = Curves.easeInOut.transform(a1.value);
        return Transform.scale(
          scale: curve,
          child: DisablePost(ctx),
        );
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }

  Widget DisablePost(BuildContext context) {
    return AlertDialog(
        title: Text(scale_disable.tr),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
                onPressed: () async {
                  await ApiMethods()
                      .ItemDisable(
                      int.parse(widget.ds['category_id']), widget.ds['id'])
                      .then((value) {
                    gotoWithoutBack(context, ProfileScreen());
                    Fluttertoast.showToast(
                        msg: 'Product disabled successfully',
                        textColor: Colors.white,
                        backgroundColor: red,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0);
                  });
                },
                child: Text("Yes"),
                style: ElevatedButton.styleFrom(backgroundColor: darkgreen)),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
                style: ElevatedButton.styleFrom(backgroundColor: darkgreen))
          ],
        ));
  }

  String set = '';
  final _setController = TextEditingController();
  final _typeController = TextEditingController();
  final _rentTypeController = TextEditingController();
  final _rcController = TextEditingController();
  final _negotiableController = TextEditingController();
  final _priceController = TextEditingController();
  final _yearController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _setController.text = '${widget.ds['set']}';
    _typeController.text = '${widget.ds['type']}';
    _rcController.text =
    '${widget.ds['rc_available']}' == 'true' ? 'Yes' : 'No';
    _negotiableController.text =
    '${widget.ds['noc_available']}' == 'true' ? 'Yes' : 'No';
    _priceController.text = '${widget.ds['price']}';
    _yearController.text = '${widget.ds['year_of_purchase']}';
    _descriptionController.text = '${widget.ds['description']}';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(edit_post.tr),
        backgroundColor: darkgreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 50,
                width: double.infinity,
                color: greenShade300,
                child: barlowBold(
                  text: edit_post.tr,
                  size: 20,
                  color: white,
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        mark_as_Sold.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: EasyButton(
                            idleStateWidget: Text(
                              sold.tr,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            loadingStateWidget: const CircularProgressIndicator(
                              strokeWidth: 3.0,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                            useWidthAnimation: true,
                            useEqualLoadingStateWidgetDimension: true,
                            width: 150.0,
                            height: 40.0,
                            borderRadius: 4.0,
                            contentGap: 6.0,
                            buttonColor: darkgreen,
                            onPressed: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 2000), () => 42);
                              _scaleDialog();
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            //Text('${widget.ds['status']}'),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text(
                        Sell_OR_Rent.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: CustomDropdown(
                            hintText: "Select Set",
                            items: const ['sell', 'rent'],
                            controller: _setController,
                            onChanged: (value) {
                              setState(() {
                                set = value;
                              });
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            set == 'rent'
                ? Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text(
                        'Rent Type',
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: CustomDropdown(
                              hintText: "Select Rent Type",
                              items: const [
                                'Per Hour',
                                'Per Day',
                                'Per Month'
                              ],
                              controller: _rentTypeController),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
                : Container(),
            widget.ds['user_type_id'] == 2
                ? Card(
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text(
                        Old_OR_New.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        width: 40,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: CustomDropdown(
                              hintText: "Select Type",
                              items: const ['old', 'new'],
                              controller: _typeController),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
                : Container(),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text(
                        Rc_Available.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: CustomDropdown(
                              hintText: "Select RC Available",
                              items: const ['Yes', 'No'],
                              controller: _rcController),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text(
                        Negotiable.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: CustomDropdown(
                              hintText: "Is Negotiable",
                              items: const ['Yes', 'No'],
                              controller: _negotiableController),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text(
                        price.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        width: 80,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _priceController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  child: Row(
                    children: [
                      Text(
                        yearOfPurchase.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: SizedBox(
                          child: TextField(
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(4),
                            ],
                            keyboardType: TextInputType.number,
                            controller: _yearController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            description.tr,
                            style: TextStyle(fontSize: 17),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 100,
                          child: TextField(
                            controller: _descriptionController,
                            maxLines: 5,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                        images.tr,
                        style: TextStyle(fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        '${widget.ds['front_image']}' != ''
                            ? GestureDetector(
                          onTap: () {
                            goto(
                                context,
                                PhotoSelectView(
                                    side: "Front",
                                    imageUrl:
                                    '${widget.ds['front_image']}'));
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              widget.ds['front_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : Container(),
                        SizedBox(
                          width: 5,
                        ),
                        '${widget.ds['back_image']}' != ''
                            ? GestureDetector(
                          onTap: () {
                            goto(
                                context,
                                PhotoSelectView(
                                    side: "Back",
                                    imageUrl:
                                    '${widget.ds['back_image']}'));
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              widget.ds['back_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : Container(),
                        SizedBox(
                          width: 5,
                        ),
                        '${widget.ds['left_image']}' != ''
                            ? GestureDetector(
                          onTap: () {
                            goto(
                                context,
                                PhotoSelectView(
                                    side: "Left",
                                    imageUrl:
                                    '${widget.ds['left_image']}'));
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              widget.ds['left_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : Container(),
                        SizedBox(
                          width: 5,
                        ),
                        '${widget.ds['right_image']}' != ''
                            ? GestureDetector(
                          onTap: () {
                            goto(
                                context,
                                PhotoSelectView(
                                    side: "Right",
                                    imageUrl:
                                    '${widget.ds['right_image']}'));
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              widget.ds['right_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : Container(),
                        SizedBox(
                          width: 5,
                        ),
                        '${widget.ds['meter_image']}' != ''
                            ? GestureDetector(
                          onTap: () {
                            goto(
                                context,
                                PhotoSelectView(
                                    side: "Meter",
                                    imageUrl:
                                    '${widget.ds['meter_image']}'));
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              widget.ds['meter_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : Container(),
                        SizedBox(
                          width: 5,
                        ),
                        '${widget.ds['tyre_image']}' != ''
                            ? GestureDetector(
                          onTap: () {
                            goto(
                                context,
                                PhotoSelectView(
                                    side: "Tyre",
                                    imageUrl:
                                    '${widget.ds['tyre_image']}'));
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(
                              widget.ds['tyre_image'],
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                            : Container(),
                        SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            goto(
                                context,
                                EditTractorImagesScreen(
                                  set: _setController.text.trim().isEmpty
                                      ? '${widget.ds['set']}'
                                      : _setController.text.trim(), // sell/rent
                                  setType: _typeController.text.trim().isEmpty
                                      ? '${widget.ds['type']}'
                                      : _typeController.text.trim(), // old/new
                                  rentType: _rentTypeController.text
                                      .trim()
                                      .isEmpty
                                      ? '${widget.ds['rent_type']}'
                                      : _rentTypeController.text
                                      .trim(), // 'Per Hour', 'Per Day','Per Month'
                                  price: int.parse(
                                      _priceController.text.trim()), // price
                                  rcAvailabel: _rcController.text == 'Yes'
                                      ? 'true'
                                      : 'false', //rc available
                                  isNegotiable:
                                  _negotiableController.text == 'Yes'
                                      ? 'true'
                                      : 'false', //is negotiable
                                  description:
                                  _descriptionController.text.trim().isEmpty
                                      ? ''
                                      : _descriptionController.text
                                      .trim(), //description
                                  yearOfPurchase: int.parse(
                                      _yearController.text.trim()), //year
                                  ds: widget.ds,
                                ));
                          },
                          child: Container(
                            height: 200,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black38),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(update_image.tr),
                                Icon(Icons.arrow_forward)
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(5)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              disable_post.tr,
                              style: TextStyle(fontSize: 17),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: EasyButton(
                                  idleStateWidget: Text(
                                    disable.tr,
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  loadingStateWidget:
                                  const CircularProgressIndicator(
                                    strokeWidth: 3.0,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white,
                                    ),
                                  ),
                                  useWidthAnimation: true,
                                  useEqualLoadingStateWidgetDimension: true,
                                  width: 150.0,
                                  height: 40.0,
                                  borderRadius: 4.0,
                                  contentGap: 6.0,
                                  buttonColor: red,
                                  onPressed: () async {
                                    await Future.delayed(
                                        const Duration(milliseconds: 2000),
                                            () => 42);
                                    _scaleDialogForDisablePost();
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              color: lightgreen,
              child: Center(
                  child: Text(
                    back.tr,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            ),
          ),
          GestureDetector(
            onTap: () async {
              FormData formData = FormData.fromMap({
                "user_id": SharedPreferencesFunctions.userId,
                "user_token": SharedPreferencesFunctions.token,
                "id": widget.ds['id'],
                "set": _setController.text.trim().isEmpty
                    ? '${widget.ds['set']}'
                    : _setController.text.trim(),
                'type': _typeController.text.trim().isEmpty
                    ? '${widget.ds['type']}'
                    : _typeController.text.trim(),
                'spec_id': '',
                "left_image": '',
                "right_image": '',
                "front_image": '',
                "back_image": '',
                "meter_image": '',
                "tyre_image": '',
                'price': int.parse(_priceController.text.trim().toLowerCase()),
                'rent_type': _rentTypeController.text.trim().isEmpty
                    ? '${widget.ds['rent_type']}'
                    : _rentTypeController.text.trim(),
                'rc_available': _rcController.text == 'Yes' ? 'true' : 'false',
                'is_negotiable':
                _negotiableController.text == 'Yes' ? 'true' : 'false',
                'year_of_purchase': int.parse(_yearController.text.trim()),
                'description': _descriptionController.text.trim().isEmpty
                    ? ''
                    : _descriptionController.text.trim(),
              });
              var response = await Dio().post(
                baseUrl + getUrlByCategory('${widget.ds['category_id']}'),
                data: formData,
              );

              if (response.statusCode == 200) {
                int id = widget.ds['id'];
                print("ID : $id");
                // goBack(context);
                gotoWithoutBack(context, SendToPageCategory(id));
                showSnackbar(context, 'Update Successfully');
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 2,
              height: 50,
              color: darkgreen,
              child: Center(
                  child: Text(
                    update.tr,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
    );
  }

  getUrlByCategory(String Category_Id) {
    if (Category_Id == "1") {
      return "tractor-update";
    } else if (Category_Id == "3") {
      return "gv-update";
    }
  }

  SendToPageCategory(int id) {
    if (widget.ds['category_id'] == "1") {
      return PostTractorDetailScreen(id);
    } else if (widget.ds['category_id'] == "3") {
      return PostGvDetailScreen(id);
    }
  }
}

class PhotoSelectView extends StatelessWidget {
  final String side;
  final String imageUrl;
  const PhotoSelectView({Key? key, required this.side, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: fullWidth(context),
        height: fullHeight(context),
        color: Colors.black,
        child: Column(
          children: [
            SizedBox(height: fullHeight(context)*0.10),
            Padding(
              padding: const EdgeInsets.only(left: 8.0,right: 8,top: 20.0,bottom: 20.0),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: barlowBold(
                          color: green, maxLine: 1, size: 25, text: side),
                    ),
                    Container(
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
                    ),

                  ],
                ),
              ),
            ),
            CachedNetworkImage(
              imageUrl: imageUrl,
              imageBuilder: (context, imageProvider) => Container(
                width: fullWidth(context),
                height: fullHeight(context) * 0.625,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    //image size fill
                    image: imageProvider,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
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
              //show no image available image on error loading
            ),
          ],
        ),
      ),
    );
  }
}
