import 'package:cached_network_image/cached_network_image.dart';
import 'package:edistribution/products/productsDetails.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:edistribution/widget/customModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:substring_highlight/substring_highlight.dart';

class SearchProducts extends StatefulWidget {
  const SearchProducts({Key? key}) : super(key: key);

  @override
  _SearchProductsState createState() => _SearchProductsState();
}

class _SearchProductsState extends State<SearchProducts> {
  FocusNode myFocusNodeSearch = FocusNode();
  final searchController = TextEditingController();

  int offset = 0;
  var _controller = ScrollController();

  bool initLoad = true;

  @override
  void initState() {
    myFocusNodeSearch.requestFocus();
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        loadOffset();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    myFocusNodeSearch.dispose();
    searchController.dispose();
    GlobalVariables.displayAllItemDescription = [];
    GlobalVariables.searchProduct = [];
    super.dispose();
  }

  Sessiontimer sessionTimer = Sessiontimer();
  void handleUserInteraction([_]) {
    if (GlobalVariables.logcustomerCode.isNotEmpty) {
      sessionTimer.initializeTimer(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
    var safePadding = MediaQuery.of(context).padding.top;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: handleUserInteraction,
      onPanDown: handleUserInteraction,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Column(
            children: [
              Container(height: safePadding, color: brandingColor),
              Container(
                color: brandingColor,
                alignment: Alignment.center,
                height: appBarSize,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, top: 8.0, bottom: 8.0),
                      child: IconButton(
                          onPressed: () => Navigator.pop(context),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                    ),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, top: 8.0, bottom: 8.0),
                        child: Container(
                          width: size.width - 60,
                          height: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5))),
                          child: Row(
                            children: [
                              Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(CupertinoIcons.search,
                                      color: Colors.grey)),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 5.0),
                                  child: TextFormField(
                                    controller: searchController,
                                    focusNode: myFocusNodeSearch,
                                    textInputAction: TextInputAction.search,
                                    decoration: InputDecoration(
                                      isDense: true,
                                      border: InputBorder.none,
                                      suffixIcon: IconButton(
                                        icon: searchController.text.isNotEmpty
                                            ? Icon(
                                                CupertinoIcons
                                                    .xmark_circle_fill,
                                                color: Colors.redAccent)
                                            : SizedBox(),
                                        onPressed: () {
                                          searchController.clear();
                                          GlobalVariables.searchProduct = [];
                                          initLoad = true;
                                          GlobalVariables
                                              .displayAllItemDescription = [];
                                          if (mounted) setState(() {});
                                        },
                                      ),
                                    ),
                                    onChanged: (value) {
                                      GlobalVariables.searchProduct = [];
                                      initLoad = true;
                                      GlobalVariables
                                          .displayAllItemDescription = [];
                                      value == ''
                                          ? GlobalVariables.displayAllItemDescription =
                                              GlobalVariables.allItemDescription
                                                  .where((description) =>
                                                      description['description']
                                                          .toString()
                                                          .toUpperCase()
                                                          .contains(value
                                                              .toString()
                                                              .toUpperCase()))
                                                  .toList()
                                                  .sublist(0, 10)
                                          : GlobalVariables.displayAllItemDescription =
                                              GlobalVariables.allItemDescription
                                                  .where((description) =>
                                                      description['description'].toString().toUpperCase().contains(value.toString().toUpperCase()))
                                                  .toList();

                                      if (mounted) setState(() {});
                                    },
                                    onEditingComplete: () {
                                      FocusScope.of(context)
                                          .requestFocus(FocusNode());
                                      print("search");
                                      GlobalVariables
                                          .displayAllItemDescription = [];
                                      GlobalVariables.searchProduct = [];
                                      offset = 0;
                                      initLoad = false;
                                      if (mounted) setState(() {});
                                      loadOffset();
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () {},
                    ),
                    Spacer(),
                  ],
                ),
              ),
              GlobalVariables.displayAllItemDescription.length > 0
                  ? Expanded(
                      child: Scrollbar(
                        child: ListView.separated(
                          separatorBuilder: (context, index) =>
                              Divider(color: Colors.black),
                          itemCount:
                              GlobalVariables.displayAllItemDescription.length,
                          itemBuilder: (context, index) {
                            var data =
                                GlobalVariables.displayAllItemDescription;
                            final query =
                                searchController.text.toString().toUpperCase();

                            return GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(12),
                                child: SubstringHighlight(
                                  text: data[index]['description']
                                      .toString()
                                      .toUpperCase(),
                                  term: query,
                                  textStyle: TextStyle(
                                    color: Colors.black,
                                    fontSize: ScreenUtil().setSp(15),
                                  ),
                                  textStyleHighlight: TextStyle(
                                      fontSize: ScreenUtil().setSp(15),
                                      color: brandingColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onTap: () {
                                searchController.text =
                                    data[index]['description'];

                                FocusScope.of(context)
                                    .requestFocus(FocusNode());
                                print("search");
                                GlobalVariables.displayAllItemDescription = [];
                                GlobalVariables.searchProduct = [];
                                offset = 0;
                                initLoad = false;
                                if (mounted) setState(() {});
                                loadOffset();
                              },
                            );
                          },
                        ),
                      ),
                    )
                  : SizedBox(),
              initLoad == false
                  ? GlobalVariables.searchProduct.length > 0
                      ? Expanded(
                          child: NotificationListener<
                              OverscrollIndicatorNotification>(
                            onNotification: (overscroll) {
                              overscroll.disallowIndicator();
                              return false;
                            },
                            child: Scrollbar(
                              child: GridView.builder(
                                controller: _controller,
                                padding: EdgeInsets.all(0),
                                itemCount:
                                    GlobalVariables.searchProduct.length + 1,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount:
                                            GlobalVariables.axisCount,
                                        mainAxisSpacing: 3.5,
                                        crossAxisSpacing: 3.5,
                                        childAspectRatio:
                                            MediaQuery.of(context).size.width /
                                                (MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    1.5)),
                                itemBuilder: (BuildContext context, int index) {
                                  if (index ==
                                      GlobalVariables.searchProduct.length) {
                                    if (offset <=
                                        GlobalVariables.searchProduct.length) {
                                      return Center(
                                          child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: CircularProgressIndicator(),
                                      ));
                                    } else if (offset >
                                        GlobalVariables.searchProduct.length) {
                                      return Container(
                                        color: Colors.white,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text("End of List",
                                                style: TextStyle(
                                                    color: brandingColor)),
                                          ],
                                        ),
                                      );
                                    }
                                  }

                                  return InkWell(
                                    onTap: () {
                                      var code = GlobalVariables
                                          .searchProduct[index]['itemcode'];
                                      GlobalVariables.productDetails = [];

                                      for (int i = 0;
                                          i <
                                              GlobalVariables
                                                  .searchProduct.length;
                                          i++) {
                                        if (GlobalVariables.searchProduct[i]
                                                ['itemcode'] ==
                                            code) {
                                          GlobalVariables.productDetails.add(
                                              GlobalVariables.searchProduct[i]
                                                  ['units']);
                                        }
                                      }
                                      print(GlobalVariables.productDetails);
                                      productDetails(
                                          context,
                                          true,
                                          GlobalVariables.searchProduct[index]
                                              ['item_path'],
                                          GlobalVariables.searchProduct[index]
                                              ['description'],
                                          double.parse(GlobalVariables
                                                  .searchProduct[index]
                                              ['list_price_wtax']),
                                          GlobalVariables.searchProduct[index]
                                              ['keywords'],
                                          GlobalVariables.searchProduct[index]
                                              ['product_family'],
                                          false);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: size.height / 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              width: double.infinity,
                                              color: Colors.white,
                                              child: CachedNetworkImage(
                                                imageUrl: ServerUrl.itmImgUrl +
                                                    GlobalVariables
                                                            .searchProduct[
                                                        index]['item_path'],
                                                placeholder: (context, url) =>
                                                    Center(
                                                        child:
                                                            CircularProgressIndicator()),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Icon(Icons.error,
                                                        color:
                                                            Colors.grey[200]),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: (size.height / 3) / 3,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Text(
                                                      GlobalVariables
                                                              .searchProduct[
                                                          index]['description'],
                                                      style: TextStyle(
                                                        fontSize: ScreenUtil()
                                                            .setSp(13),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 2),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 3.0,
                                                          right: 3.0),
                                                  child: Text(
                                                      GlobalVariables
                                                              .searchProduct[
                                                          index]['uom'],
                                                      style: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: ScreenUtil()
                                                            .setSp(13),
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(3.0),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                          NumberFormat.currency(
                                                                  locale: 'en',
                                                                  symbol: '₱ ')
                                                              .format(double.parse(
                                                                  GlobalVariables
                                                                              .searchProduct[
                                                                          index]
                                                                      [
                                                                      'list_price_wtax'])),
                                                          style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          13),
                                                              color:
                                                                  brandingColor),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1),
                                                      Spacer(),
                                                      Text(
                                                        "${NumberFormat.compact().format(int.parse(GlobalVariables.searchProduct[index]['sold']))} sold",
                                                        style: TextStyle(
                                                            color: int.parse(GlobalVariables
                                                                            .searchProduct[index]
                                                                        [
                                                                        'sold']) >
                                                                    0
                                                                ? Colors.grey
                                                                : Colors.white,
                                                            fontSize: 12),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      : loadingProducts()
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  Widget loadingProducts() {
    var size = MediaQuery.of(context).size;
    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: Scrollbar(
          child: GridView.builder(
            key: PageStorageKey(0),
            padding: EdgeInsets.all(0),
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: GlobalVariables.axisCount,
                mainAxisSpacing: 3.5,
                crossAxisSpacing: 3.5,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.5)),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                color: Colors.white,
                height: size.height / 3,
                child: Column(
                  children: [
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(1),
                      child: Center(
                        child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.black12)),
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  loadOffset() async {
    GlobalVariables.selectedCategoryName = 'ALL PRODUCTS';
    print(searchController.text);
    var p = await getSearchProductsOffset(context, searchController.text.trim(),
        GlobalVariables.selectedCategoryName, offset);
    List r = p;
    if (r.length > 0) {
      List offsetP = p;
      GlobalVariables.searchProduct.addAll(offsetP);
      offset = offset + 20;
      if (mounted) setState(() {});
    } else {
      if (offset <= GlobalVariables.searchProduct.length) {
        initLoad = true;
        offset = 0;
        GlobalVariables.searchProduct = [];
        if (mounted) setState(() {});
        customModal(
            context,
            Icon(CupertinoIcons.info_circle, size: 50, color: Colors.blue),
            Text("No result(s) found for ${searchController.text}.",
                textAlign: TextAlign.center),
            true,
            Icon(
              CupertinoIcons.checkmark_alt,
              size: 25,
              color: Colors.greenAccent,
            ),
            '',
            () {});
      }
    }
  }
}
