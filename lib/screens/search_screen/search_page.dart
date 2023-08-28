import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:krishivikas/const/colors.dart';
import 'package:krishivikas/language/language_key.dart';
import 'package:krishivikas/screens/search_screen/recentSearch.dart';
import 'package:krishivikas/screens/search_screen/search_model.dart';
import 'package:krishivikas/widgets/all_widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/api_urls.dart';
import '../../widgets/filter_page/varieble_const.dart';
import 'SearchResult/PostFertilizerSearchResult.dart';
import 'SearchResult/PostPestisideSearchResult.dart';
import 'SearchResult/PostSearchResult.dart';
import 'SearchResult/PostTyreSearchResult.dart';
import 'SearchResult/SeedsResultList.dart';
import 'category_model.dart';

int selectedSearchIndex = -1;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool showButton = false;

  void performSearch(String searchTerm, int searchCount) {
    // Perform the search

    // Save the recent search
    RecentSearch recentSearch = RecentSearch(searchTerm, searchCount);
    saveRecentSearch(recentSearch);
  }

  void saveRecentSearch(RecentSearch recentSearch) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<String>? recentSearches = prefs.getStringList('recent_searches');

    if (recentSearches == null) {
      recentSearches = [];
    }

    String searchItem =
        '${recentSearch.stringValue},${recentSearch.intValue.toString()}';
    recentSearches.insert(0, searchItem);

    // Limit the number of recent searches if desired
    if (recentSearches.length > 5) {
      recentSearches = recentSearches.sublist(0, 5);
    }

    await prefs.setStringList('recent_searches', recentSearches);
  }

  Future<List<RecentSearch>> getRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? recentSearches = prefs.getStringList('recent_searches');

    if (recentSearches == null) {
      return [];
    }

    List<RecentSearch> parsedSearches = recentSearches.map((searchItem) {
      List<String> parts = searchItem.split(',');
      String stringValue = parts[0];
      int intValue = int.parse(parts[1]);
      return RecentSearch(stringValue, intValue);
    }).toList();

    return parsedSearches;
  }

  final TextEditingController controller = TextEditingController();
  List<DatumSearch> selectedSearchItems = [];
  List<DatumSearch> allSearchItems = [];
  String categoryId = "";
  int searchID = 0;

  Future<List<DatumSearch>?> searchData() async {
    Map data = {"category_id": categoryId};
    String body = json.encode(data);
    // logger.e(body);
    final response = await http.post(
        Uri.parse(baseUrl + searchUrl),
        headers: {
          "Accept": "application/json",
          "Access-Control_Allow_Origin": "*",
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: '*',
        },
        body: body);
    if (response.statusCode == 200) {
      // logger.e(response.statusCode);
      final responseData = json.decode(response.body);
      final List<DatumSearch> dataList =
          Search.fromJson(responseData).data.toList();
      allSearchItems = dataList;
      return allSearchItems;
    } else {
      // logger.e(response.statusCode);
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    checkSearch();
    controller.addListener(searchListener);
  }

  @override
  void dispose() {
    controller.removeListener(searchListener);
    selectedSearchIndex = -1;
    controller.dispose();
    super.dispose();
  }

  void searchListener() {
    search(controller.text);
  }

  void search(String query) {
    if (query.isEmpty) {
      setState(() {
        selectedSearchItems = allSearchItems;
      });
    } else {
      setState(() {
        selectedSearchItems = allSearchItems
            .where((e) => e.keyword.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    }
  }

  // Initial Selected Value
  String dropdownvalue = tractor.tr;
  var searchTitle = "Search";

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    checkSearch();
  }

  // List of items in our dropdown menu
  var items = [
    tractor.tr,
    goodsVehicle.tr,
    seeds.tr,
    pesticides.tr,
    fertilizer.tr,
    harvester.tr,
    implement.tr,
    tyre.tr,
  ];
  bool isShowUsers = false;
  bool isRecentUsers = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: darkgreen,
        title: Text(
          search_screen.tr,
          //${categoryId} ${searchID.toString()}
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: darkgreen, width: 2),
                borderRadius: BorderRadius.circular(8),
              ),
              width: MediaQuery.of(context).size.width,
              height: 50,
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8),
                child: DropdownButton<String>(
                  underline: Container(),
                  hint: Text(dropdownvalue.toString()),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: darkgreen,
                  ),
                  iconSize: 36,
                  isExpanded: true,
                  value: dropdownvalue,
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              onChanged: (String _) {
                setState(() {
                  showButton = true;
                  isShowUsers = true;
                });
                print(_);
              },
              onSubmitted: (String _) {
                setState(() {
                  isShowUsers = true;
                  // performSearch(controller.text);
                });
                print(_);
              },
              controller: controller,
              decoration: InputDecoration(
                hintText: searchTitle,
                prefixIcon: Icon(
                  Icons.search,
                  color: darkgreen,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
                child: isShowUsers
                    ? FutureBuilder(
                        future: searchData(),
                        builder: (BuildContext context,
                            AsyncSnapshot<dynamic> snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: selectedSearchItems.isEmpty
                                  ? allSearchItems.length
                                  : selectedSearchItems.length,
                              itemBuilder: (BuildContext context, int index) {
                                final DatumSearch item =
                                    selectedSearchItems.isEmpty
                                        ? allSearchItems[index]
                                        : selectedSearchItems[index];
                                return ListTile(
                                  onTap: () {
                                    setState(() {
                                      isRecentUsers = true;
                                      print(isRecentUsers);
                                      searchTitle = item.keyword;
                                      performSearch(item.keyword, item.id);
                                      if (dropdownvalue == tractor.tr) {
                                        goto(
                                            context,
                                            PostSearchResult(
                                              category_id: 1,
                                              query: controller.text.trim(),
                                              search_id: searchID,
                                            ));
                                      } else if (dropdownvalue ==
                                          goodsVehicle.tr) {
                                        goto(
                                            context,
                                            PostSearchResult(
                                              category_id: 3,
                                              query: controller.text.trim(),
                                              search_id: searchID,
                                            ));
                                      } else if (dropdownvalue == seeds.tr) {
                                        goto(
                                            context,
                                            SeedsSearchResultList(
                                              category_id: 6,
                                              query: controller.text.trim(),
                                              search_id: searchID,
                                            ));
                                      } else if (dropdownvalue ==
                                          pesticides.tr) {
                                        goto(
                                            context,
                                            PesticideSearchResultList(
                                              category_id: 8,
                                              query: controller.text.trim(),
                                              search_id: searchID,
                                            ));
                                      } else if (dropdownvalue ==
                                          fertilizer.tr) {
                                        goto(
                                            context,
                                            FertilizerSearchResultList(
                                              category_id: 9,
                                              query: controller.text.trim(),
                                              search_id: searchID,
                                            ));
                                      } else if (dropdownvalue == harvester.tr) {
                                        goto(
                                            context,
                                            PostSearchResult(
                                              category_id: 4,
                                              query: controller.text.trim(),
                                              search_id: searchID,
                                            ));
                                      } else if (dropdownvalue ==
                                          implement.tr) {
                                        goto(
                                            context,
                                            PostSearchResult(
                                              category_id: 5,
                                              query: controller.text.trim(),
                                              search_id: searchID,
                                            ));
                                      } else {
                                        goto(
                                            context,
                                            PostSearchResultTyreList(
                                              category_id: 7,
                                              query: controller.text.trim(),
                                              search_id: searchID,
                                            ));
                                      }
                                    });
                                  },
                                  title: Text(item.keyword),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 16,
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Icon(Icons.error_outline),
                            );
                          } else {
                            return Center(
                              child: progressIndicator(context),
                            );
                          }
                        },
                      )
                    : isRecentUsers
                        ? ListView(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Visibility(
                                    visible: true,
                                    child: Text(
                                      "RECENT SEARCHES",
                                      style: TextStyle(
                                          color: Colors.grey, fontSize: 12),
                                    ),
                                  ),
                                  Container(
                                    height:
                                        MediaQuery.of(context).size.height / 3,
                                    child: FutureBuilder<List<RecentSearch>>(
                                      future: getRecentSearches(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<List<RecentSearch>>
                                              snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Center(
                                            child: progressIndicator(context),
                                          );
                                        }
                                        if (snapshot.hasError) {
                                          return Center(child: Text('Error'));
                                        }
                                        List<RecentSearch> recentSearches =
                                            snapshot.data ?? [];
                                        return ListView.builder(
                                          itemCount: recentSearches.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            RecentSearch searchItem =
                                                recentSearches[index];
                                            return ListTile(
                                              title:
                                                  Text(searchItem.stringValue),
                                              trailing: Icon(
                                                Icons
                                                    .arrow_forward_ios_outlined,
                                                size: 16,
                                              ),
                                              onTap: () {
                                                setState(() {
                                                  searchTitle =
                                                      searchItem.stringValue;
                                                  if (dropdownvalue ==
                                                      tractor.tr) {
                                                    goto(
                                                        context,
                                                        PostSearchResult(
                                                          category_id: 1,
                                                          query: searchItem
                                                              .stringValue,
                                                          search_id: searchItem
                                                              .intValue,
                                                        ));
                                                  } else if (dropdownvalue ==
                                                      goodsVehicle.tr) {
                                                    goto(
                                                        context,
                                                        PostSearchResult(
                                                            category_id: 3,
                                                            query: searchItem
                                                                .stringValue,
                                                            search_id:
                                                                searchItem
                                                                    .intValue));
                                                  } else if (dropdownvalue ==
                                                      seeds.tr) {
                                                    goto(
                                                        context,
                                                        SeedsSearchResultList(
                                                          category_id: 6,
                                                          query: searchItem
                                                              .stringValue,
                                                          search_id: searchItem
                                                              .intValue,
                                                        ));
                                                  } else if (dropdownvalue ==
                                                      pesticides.tr) {
                                                    goto(
                                                        context,
                                                        PesticideSearchResultList(
                                                          category_id: 8,
                                                          query: searchItem
                                                              .stringValue,
                                                          search_id: searchItem
                                                              .intValue,
                                                        ));
                                                  } else if (dropdownvalue ==
                                                      fertilizer.tr) {
                                                    goto(
                                                        context,
                                                        FertilizerSearchResultList(
                                                          category_id: 9,
                                                          query: searchItem
                                                              .stringValue,
                                                          search_id: searchItem
                                                              .intValue,
                                                        ));
                                                  } else if (dropdownvalue ==
                                                      harvester.tr) {
                                                    goto(
                                                        context,
                                                        PostSearchResult(
                                                            category_id: 4,
                                                            query: searchItem
                                                                .stringValue,
                                                            search_id:
                                                                searchItem
                                                                    .intValue));
                                                  } else if (dropdownvalue ==
                                                      implement.tr) {
                                                    goto(
                                                        context,
                                                        PostSearchResult(
                                                            category_id: 5,
                                                            query: searchItem
                                                                .stringValue,
                                                            search_id:
                                                                searchItem
                                                                    .intValue));
                                                  } else {
                                                    goto(
                                                        context,
                                                        PostSearchResultTyreList(
                                                            category_id: 7,
                                                            query: searchItem
                                                                .stringValue,
                                                            search_id:
                                                                searchItem
                                                                    .intValue));
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: black,
                                  )
                                ],
                              ),
                            ],
                          )
                        : FutureBuilder(
                            future: searchData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: 10,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final DatumSearch item =
                                        selectedSearchItems.isEmpty
                                            ? allSearchItems[index]
                                            : selectedSearchItems[index];
                                    return ListTile(
                                      onTap: () {
                                        setState(() {
                                          searchTitle = item.keyword;
                                          performSearch(item.keyword, 0);
                                          if (dropdownvalue == tractor.tr) {
                                            goto(
                                                context,
                                                PostSearchResult(
                                                  category_id: 1,
                                                  query: controller.text.trim(),
                                                  search_id: 0,
                                                ));
                                          } else if (dropdownvalue ==
                                              goodsVehicle.tr) {
                                            goto(
                                                context,
                                                PostSearchResult(
                                                  category_id: 3,
                                                  query: controller.text.trim(),
                                                  search_id: 0,
                                                ));
                                          } else if (dropdownvalue ==
                                              seeds.tr) {
                                            goto(
                                                context,
                                                SeedsSearchResultList(
                                                  category_id: 6,
                                                  query: controller.text.trim(),
                                                  search_id: 0,
                                                ));
                                          } else if (dropdownvalue ==
                                              pesticides.tr) {
                                            goto(
                                                context,
                                                PesticideSearchResultList(
                                                  category_id: 8,
                                                  query: controller.text.trim(),
                                                  search_id: 0,
                                                ));
                                          } else if (dropdownvalue ==
                                              fertilizer.tr) {
                                            goto(
                                                context,
                                                FertilizerSearchResultList(
                                                  category_id: 9,
                                                  query: controller.text.trim(),
                                                  search_id: 0,
                                                ));
                                          } else if (dropdownvalue ==
                                              harvester.tr) {
                                            goto(
                                                context,
                                                PostSearchResult(
                                                  category_id: 4,
                                                  query: controller.text.trim(),
                                                  search_id: 0,
                                                ));
                                          } else if (dropdownvalue ==
                                              implement.tr) {
                                            goto(
                                                context,
                                                PostSearchResult(
                                                  category_id: 5,
                                                  query: controller.text.trim(),
                                                  search_id: 0,
                                                ));
                                          } else {
                                            goto(
                                                context,
                                                PostSearchResultTyreList(
                                                  category_id: 7,
                                                  query: controller.text.trim(),
                                                  search_id: 0,
                                                ));
                                          }
                                        });
                                      },
                                      title: Text(item.keyword),
                                      trailing: Icon(
                                        Icons.arrow_forward_ios,
                                        size: 16,
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return const Center(
                                  child: Icon(Icons.error_outline),
                                );
                              } else {
                                return Center(
                                  child: progressIndicator(context),
                                );
                              }
                            },
                          ))
          ],
        ),
      ),
      floatingActionButton: SizedBox(
        height: 45,
        width: MediaQuery.of(context).size.width / 1.1,
        child: Visibility(
          visible: showButton,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: darkgreen,
                padding: const EdgeInsets.symmetric(vertical: 15)),
            onPressed: () {
              isRecentUsers = true;
              performSearch(controller.text, searchID);
              if (dropdownvalue == tractor.tr) {
                goto(
                    context,
                    PostSearchResult(
                      category_id: 1,
                      query: controller.text.trim(),
                      search_id: searchID,
                    ));
              } else if (dropdownvalue == goodsVehicle.tr) {
                goto(
                    context,
                    PostSearchResult(
                      category_id: 3,
                      query: controller.text.trim(),
                      search_id: searchID,
                    ));
              } else if (dropdownvalue == seeds.tr) {
                goto(
                    context,
                    SeedsSearchResultList(
                      category_id: 6,
                      query: controller.text.trim(),
                      search_id: searchID,
                    ));
              } else if (dropdownvalue == pesticides.tr) {
                goto(
                    context,
                    PesticideSearchResultList(
                      category_id: 8,
                      query: controller.text.trim(),
                      search_id: searchID,
                    ));
              } else if (dropdownvalue == fertilizer.tr) {
                goto(
                    context,
                    FertilizerSearchResultList(
                      category_id: 9,
                      query: controller.text.trim(),
                      search_id: searchID,
                    ));
              } else if (dropdownvalue == harvester.tr) {
                goto(
                    context,
                    PostSearchResult(
                      category_id: 4,
                      query: controller.text.trim(),
                      search_id: searchID,
                    ));
              } else if (dropdownvalue == implement.tr) {
                goto(
                    context,
                    PostSearchResult(
                      category_id: 5,
                      query: controller.text.trim(),
                      search_id: searchID,
                    ));
              } else {
                goto(
                    context,
                    PostSearchResultTyreList(
                      category_id: 7,
                      query: controller.text.trim(),
                      search_id: searchID,
                    ));
              }
            },
            child: Text(
              search_butt.tr,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  checkSearch() {
    if (dropdownvalue == tractor.tr) {
      categoryId = "1";
    } else if (dropdownvalue == goodsVehicle.tr) {
      categoryId = "3";
    } else if (dropdownvalue == seeds.tr) {
      categoryId = "6";
    } else if (dropdownvalue == pesticides.tr) {
      categoryId = "8";
    } else if (dropdownvalue == fertilizer.tr) {
      categoryId = "9";
    } else if (dropdownvalue == harvester.tr) {
      categoryId = "4";
    } else if (dropdownvalue == implement.tr) {
      categoryId = "5";
    } else {
      categoryId = "7";
    }
  }
} // Demo list to show querying
