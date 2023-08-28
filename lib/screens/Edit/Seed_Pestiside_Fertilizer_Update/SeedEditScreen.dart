import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:easy_loading_button/easy_loading_button.dart';
import 'package:photo_view/photo_view.dart';
import 'package:dio/dio.dart';

import '../../../Screens/account/profile_screen.dart';
import '../../../const/api_urls.dart';
import '../../../services/api_methods.dart';
import '../../../services/save_user_info.dart';
import '../Post_Update/PostSeedUpdate.dart';
import 'SeedEditImageScreen.dart';

class SeedEditScreen extends StatefulWidget {
  final ds;
  const SeedEditScreen({Key? key, required this.ds}) : super(key: key);

  @override
  State<SeedEditScreen> createState() => _SeedEditScreenState();
}

class _SeedEditScreenState extends State<SeedEditScreen> {

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
                onPressed: () async{
                  await ApiMethods().MarkItemSold(int.parse(widget.ds['category_id']), widget.ds['id']).then((value) {
                    gotoWithoutBack(context, ProfileScreen());
                    Fluttertoast.showToast(
                        msg: 'Product marked sold successfully',
                        textColor: Colors.white,
                        backgroundColor: darkgreen,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0
                    );
                  });
                },
                child: Text("Yes"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: darkgreen
                )
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("No"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: darkgreen
                )
            )
          ],
        )
    );
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
                onPressed: () async{
                  await ApiMethods().ItemDisable(int.parse(widget.ds['category_id']), widget.ds['id']).then((value) {
                    gotoWithoutBack(context, ProfileScreen());
                    Fluttertoast.showToast(
                        msg: 'Product disabled successfully',
                        textColor: Colors.white,
                        backgroundColor: red,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        fontSize: 16.0
                    );
                  });
                },
                child: Text("Yes"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: darkgreen
                )
            ),
            ElevatedButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("No"),
                style: ElevatedButton.styleFrom(
                    backgroundColor: darkgreen
                )
            )
          ],
        )
    );
  }
  final _titleController = TextEditingController();
  final _negotiableController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    _negotiableController.text = '${widget.ds['noc_available']}'=='1'?'Yes':'No';
    _priceController.text = '${widget.ds['price']}';
    _titleController.text = '${widget.ds['title']}';
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
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(mark_as_Sold.tr,style: TextStyle(
                          fontSize: 17
                      ),),
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
                              await Future.delayed(const Duration(milliseconds: 2000), () => 42);
                              _scaleDialog();
                            }
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      Text(title.tr,style: TextStyle(
                          fontSize: 17
                      ),),
                      SizedBox(width: 83,),
                      Expanded(
                        child: SizedBox(
                          child: TextField(
                            controller: _titleController,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5),
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                            ),
                            style: TextStyle(
                                fontSize: 20
                            ),
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
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      Text(Negotiable.tr,style: TextStyle(
                          fontSize: 17
                      ),),
                      SizedBox(width: 40,),
                      Expanded(
                        child: SizedBox(
                          child: CustomDropdown(
                              hintText: "Is Negotiable",
                              items: const ['Yes', 'No'],
                              controller: _negotiableController
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
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Row(
                    children: [
                      Text(price.tr,style: TextStyle(
                          fontSize: 17
                      ),),
                      SizedBox(width: 80,),
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
                            style: TextStyle(
                                fontSize: 20
                            ),
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
                padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
                child: Container(
                  height: 100,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent),
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(description.tr,style: TextStyle(
                              fontSize: 17
                          ),),
                        ],
                      ),
                      SizedBox(height: 5,),
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
                            style: TextStyle(
                                fontSize: 20
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(images.tr,style: TextStyle(
                          fontSize: 17
                      ),),
                    ],
                  ),
                  SizedBox(height: 5,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        '${widget.ds['image1']}'!=''?
                        GestureDetector(
                          onTap:(){
                            goto(context, PhotoSelectView(side: "Image 1", imageUrl: '${widget.ds['image1']}'));
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(widget.ds['image1'],fit: BoxFit.cover,),
                          ),
                        ):Container(),
                        SizedBox(width: 5,),
                        '${widget.ds['image2']}'!=''?
                        GestureDetector(
                          onTap:(){
                            goto(context, PhotoSelectView(side: "Image 2", imageUrl: '${widget.ds['image2']}'));
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(widget.ds['image2'],fit: BoxFit.cover,),
                          ),
                        ):Container(),
                        SizedBox(width: 5,),
                        '${widget.ds['image3']}'!=''?
                        GestureDetector(
                          onTap:(){
                            goto(context, PhotoSelectView(side: "Image 3", imageUrl: '${widget.ds['image3']}'));
                          },
                          child: Container(
                            height: 200,
                            width: 200,
                            child: Image.network(widget.ds['image3'],fit: BoxFit.cover,),
                          ),
                        ):Container(),
                        SizedBox(width: 5,),
                        SizedBox(width: 5,),
                        GestureDetector(
                          onTap: (){
                            goto(context, SeedsEditImageScreen(
                              title: _titleController.text.trim().isEmpty?'':_titleController.text.trim(),
                              price: int.parse(_priceController.text.trim()), // price
                              isNegotiable: _negotiableController.text=='Yes'?'1':'0', //is negotiable
                              description: _descriptionController.text.trim().isEmpty?'':_descriptionController.text.trim(), //description
                              ds: widget.ds,
                            ));
                          },
                          child: Container(
                            height: 200,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.black38
                            ),
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
                  SizedBox(height: 15,),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(5)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(disable_post.tr,style: TextStyle(
                                fontSize: 17
                            ),),
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: EasyButton(
                                  idleStateWidget: Text(
                                    disable.tr,
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
                                  buttonColor: red,
                                  onPressed: () async {
                                    await Future.delayed(const Duration(milliseconds: 2000), () => 42);
                                    _scaleDialogForDisablePost();
                                  }
                              ),
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
            onTap: (){
              Navigator.pop(context);
            },
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: 50,
              color: lightgreen,
              child: Center(
                  child: Text(back.tr,style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                  ),)
              ),
            ),
          ),
          GestureDetector(
            onTap: () async {
              FormData formData = FormData.fromMap({
                "user_id": SharedPreferencesFunctions.userId,
                "user_token": SharedPreferencesFunctions.token,
                "id":widget.ds['id'],
                'title':_titleController.text.trim().isEmpty?'':_titleController.text.trim(),
                "image1": '',
                "image2": '',
                "image3": '',
                'price':int.parse(_priceController.text.trim().toLowerCase()),
                'is_negotiable':_negotiableController.text=='Yes'?'1':'0',
                'description':_descriptionController.text.trim().isEmpty?'':_descriptionController.text.trim(),
              });
              var response = await Dio().post(
                baseUrl+getUrlByCategory('${widget.ds['category_id']}'),
                data: formData,
              );

              if (response.statusCode == 200) {
                int id = widget.ds['id'];
                print("ID : $id");
                gotoWithoutBack(
                  context,
                  PostSeedDetailScreen(id,widget.ds['category_id']),
                );
                showSnackbar(context, 'Update Successfully');
              }
            },
            child: Container(
              width: MediaQuery.of(context).size.width/2,
              height: 50,
              color: darkgreen,
              child: Center(child: Text(update.tr,style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white
              ),)),
            ),
          ),
        ],
      ),
    );
  }
  getUrlByCategory(String Category_Id) {
    if (Category_Id == "6") {
      return "seed-update";
    } else if (Category_Id == "8") {
      return "pesticides-update";
    } else if (Category_Id == "9") {
      return "fertilizer-update";
    }
  }
}

class PhotoSelectView extends StatelessWidget {
  final String side;
  final String imageUrl;
  const PhotoSelectView({Key? key, required this.side, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(side),
        backgroundColor: darkgreen,
      ),
      body: Container(
          child: PhotoView(
            imageProvider: NetworkImage(imageUrl),
          )
      ),
    );
  }
}

