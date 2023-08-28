import 'package:flutter/material.dart';
import 'package:krishivikas/Screens/popular%20brands/brand_short_details.dart';
import 'package:krishivikas/services/api_methods.dart';
import 'package:krishivikas/widgets/all_widgets.dart';

class NewBrandsList extends StatefulWidget {
  NewBrandsList({Key? key}) : super(key: key);

  @override
  State<NewBrandsList> createState() => _NewBrandsListState();
}

class _NewBrandsListState extends State<NewBrandsList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: FutureBuilder<List>(
        future: ApiMethods().postMasterBrandData(
          "https://kv.ratemyevent.in/api/master-brand",
        ),
        builder: (context, snapshot) {
          return snapshot.hasData
              ? snapshot.data!.length == 0
                  ? Center(
                      child: Text(
                        "No data",
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio:
                              fullWidth(context) / (fullHeight(context) / 2.5),
                        ),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: InkWell(
                              onTap: () {
                                goto(
                                  context,
                                  BrandShortDetails(
                                    snapshot.data![index]["id"],
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.white,
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2,
                                    )
                                  ],
                                ),
                                height: 200,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.network(
                                        snapshot.data![index]["brand_image"],
                                        height: 45,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data![index]["brand_name"],
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    )
              : Center(
                  child: progressIndicator(context),
                );
        },
      ),
    );
  }
}
