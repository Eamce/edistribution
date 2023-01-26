import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
import 'package:edistribution/home/homePopNotif.dart';
// import 'package:edistribution/home/homeShowSliderImg.dart';
import 'package:edistribution/products/products.dart';
import 'package:edistribution/products/productsDetails.dart';
import 'package:edistribution/products/searchProducts.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/images.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:edistribution/widget/customUpdateModal.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:page_transition/page_transition.dart';
import 'package:edistribution/extensions/myExtensionString.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _selectedCat = 'ALL PRODUCTS';

  @override
  void initState() {
    super.initState();

    if (GlobalVariables.menu0loaded == false) {
      _getAppVersion();
      check();
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
    var safePadding = MediaQuery.of(context).padding.top;
    GlobalVariables.homescreenContext = context;
    return Container(
      child: Column(
        children: [
          Container(height: safePadding, color: brandingColor),
          Container(
            color: brandingColor,
            // color: Colors.white,
            alignment: Alignment.center,
            height: appBarSize,
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                  child: Center(
                    child: Image.asset(
                      Images.logo,
                      width: 30,
                    ),
                  ),
                ),
                InkWell(
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
                    child: Container(
                      width: size.width - 60,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          // color: Colors.grey[200],
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Row(
                        children: [
                          Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(CupertinoIcons.search,
                                  color: Colors.grey)),
                          Text("Search here...",
                              style: TextStyle(color: Colors.grey))
                        ],
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: SearchProducts()));
                  },
                ),
              ],
            ),
          ),
          // Container(
          //   height: appBarSize + 20,
          //   width: size.width,
          //   child: CarouselSlider(
          //       items: sliderList
          //           .map((items) => Container(
          //                 child: Center(
          //                   child: GestureDetector(
          //                     child: Image.network(
          //                       items,
          //                       fit: BoxFit.cover,
          //                       width: size.width,
          //                     ),
          //                     onTap: () {
          //                       showDialog(
          //                           barrierDismissible: true,
          //                           context: context,
          //                           builder: (context) =>
          //                               ShowSliderImage(items));
          //                     },
          //                   ),
          //                 ),
          //               ))
          //           .toList(),
          //       options: CarouselOptions(
          //         height: appBarSize + 30,
          //         aspectRatio: 2.0,
          //         // viewportFraction: 0.8,
          //         // initialPage: 0,
          //         enableInfiniteScroll: true,
          //         // reverse: false,
          //         autoPlay: true,
          //         autoPlayInterval: Duration(seconds: 3),
          //         autoPlayAnimationDuration: Duration(milliseconds: 800),
          //         autoPlayCurve: Curves.fastOutSlowIn,
          //         enlargeCenterPage: true,
          //         scrollDirection: Axis.horizontal,
          //       )),
          // ),
          Container(
            color: Colors.greenAccent[100],
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: RichText(
                textAlign: TextAlign.justify,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text:
                          "Dear valued customers, please be advised that your actual bill may vary due to stocks availability and price changes. Cut-off of orders for tomorrow's delivery(",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "${GlobalVariables.cutOffTime}",
                      style: TextStyle(
                        color: brandingColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: "). Thank you.",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          GlobalVariables.category10.length > 0
              ? Container(
                  height: appBarSize + 60,
                  width: size.width,
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: GlobalVariables.category10.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () async {
                            if (index != 9) {
                              GlobalVariables.selectedCategoryIndex = index;
                              if (mounted) setState(() {});
                              GlobalVariables.selectedCategoryName =
                                  GlobalVariables.category10[index]
                                      ['category_name'];
                              _selectedCat = GlobalVariables.category10[index]
                                  ['category_name'];
                              GlobalVariables.product50 = [];
                              var p = await getProducts(context,
                                  GlobalVariables.selectedCategoryName, 50);
                              if (p != null) {
                                GlobalVariables.product50 = p;
                                if (mounted) setState(() {});
                              }
                            } else {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.rightToLeft,
                                      child: Products(
                                        useFor: 'Category',
                                      )));
                            }
                          },
                          child: Padding(
                            padding: index != 9
                                ? const EdgeInsets.only(
                                    left: 3, top: 3, bottom: 3)
                                : const EdgeInsets.only(
                                    left: 3, right: 3, top: 3, bottom: 3),
                            child: Container(
                              width: appBarSize + 25,
                              decoration: BoxDecoration(
                                color: GlobalVariables.selectedCategoryIndex ==
                                        index
                                    ? Colors.deepOrange[100]
                                    : Colors.white,
                                border: Border.all(
                                  color:
                                      GlobalVariables.selectedCategoryIndex ==
                                              index
                                          ? brandingColor
                                          : Colors.transparent,
                                ),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Container(
                                    width: appBarSize - 5,
                                    height: appBarSize - 5,
                                    decoration: new BoxDecoration(
                                      color: GlobalVariables.catColor[index],
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                        index != 9
                                            ? CupertinoIcons.doc_richtext
                                            : CupertinoIcons.bars,
                                        color: Colors.white),
                                  ),
                                  Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.all(1),
                                    child: Text(
                                        index != 9
                                            ? GlobalVariables.category10[index]
                                                ['category_name']
                                            : "\nSEE MORE\n",
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(9)),
                                        textAlign: TextAlign.center,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2),
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              : loadingCategory(),
          GlobalVariables.product50.length > 0
              ? Expanded(
                  child: NotificationListener<OverscrollIndicatorNotification>(
                    onNotification: (overscroll) {
                      overscroll.disallowIndicator();
                      return false;
                    },
                    child: Scrollbar(
                      child: GridView.builder(
                        padding: EdgeInsets.all(0),
                        itemCount: GlobalVariables.product50.length == 50
                            ? GlobalVariables.product50.length
                            : GlobalVariables.product50.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: GlobalVariables.axisCount,
                            mainAxisSpacing: 3.5,
                            crossAxisSpacing: 3.5,
                            childAspectRatio:
                                MediaQuery.of(context).size.width /
                                    (MediaQuery.of(context).size.height / 1.5)),
                        itemBuilder: (BuildContext context, int index) {
                          if (index == GlobalVariables.product50.length) {
                            return Container(
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("End of List",
                                      style: TextStyle(color: brandingColor)),
                                ],
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () {
                              var code =
                                  GlobalVariables.product50[index]['itemcode'];
                              GlobalVariables.productDetails = [];

                              for (int i = 0;
                                  i < GlobalVariables.product50.length;
                                  i++) {
                                if (GlobalVariables.product50[i]['itemcode'] ==
                                    code) {
                                  GlobalVariables.productDetails.add(
                                      GlobalVariables.product50[i]['units']);
                                }
                              }

                              productDetails(
                                  context,
                                  true,
                                  GlobalVariables.product50[index]['item_path'],
                                  GlobalVariables.product50[index]
                                      ['description'],
                                  double.parse(GlobalVariables.product50[index]
                                      ['list_price_wtax']),
                                  GlobalVariables.product50[index]['keywords'],
                                  GlobalVariables.product50[index]
                                      ['product_family'],
                                  false);
                            },
                            child: GlobalVariables.product50.length == 50
                                ? Container(
                                    color: Colors.white,
                                    height: size.height / 3,
                                    child: index != 49
                                        ? Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  width: double.infinity,
                                                  color: Colors.white,
                                                  child: CachedNetworkImage(
                                                    imageUrl: ServerUrl
                                                            .itmImgUrl +
                                                        GlobalVariables
                                                                .product50[
                                                            index]['item_path'],
                                                    placeholder: (context,
                                                            url) =>
                                                        Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error,
                                                                color: Colors
                                                                    .grey[200]),
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
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Text(
                                                          GlobalVariables
                                                                  .product50[index]
                                                              ['description'],
                                                          style: TextStyle(
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          13)),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 2),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 3.0,
                                                              right: 3.0),
                                                      child: Text(
                                                          GlobalVariables
                                                                  .product50[
                                                              index]['uom'],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey,
                                                              fontSize:
                                                                  ScreenUtil()
                                                                      .setSp(
                                                                          13)),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          maxLines: 1),
                                                    ),
                                                    Spacer(),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              3.0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                              // NumberFormat.currency(
                                                              //         locale:
                                                              //             'en',
                                                              //         symbol:
                                                              //             '₱ ')
                                                              //     .format(double.parse(
                                                              //         GlobalVariables
                                                              //                 .product50[index]
                                                              //             [
                                                              //             'list_price_wtax'])),
                                                              '${GlobalVariables.product50[index]['list_price_wtax'].toString().toCurrencyFormat}',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      ScreenUtil()
                                                                          .setSp(
                                                                              13),
                                                                  color:
                                                                      brandingColor),
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              maxLines: 1),
                                                          Spacer(),
                                                          Text(
                                                            "${NumberFormat.compact().format(int.parse(GlobalVariables.product50[index]['sold']))} sold",
                                                            style: TextStyle(
                                                                color: int.parse(GlobalVariables.product50[index]
                                                                            [
                                                                            'sold']) >
                                                                        0
                                                                    ? Colors
                                                                        .grey
                                                                    : Colors
                                                                        .white,
                                                                fontSize: 12),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          )
                                        : InkWell(
                                            child: Container(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text("See More",
                                                      style: TextStyle(
                                                          color:
                                                              brandingColor)),
                                                  Icon(
                                                      CupertinoIcons
                                                          .chevron_right_2,
                                                      color: brandingColor)
                                                ],
                                              ),
                                            ),
                                            onTap: () {
                                              GlobalVariables
                                                      .selectedCategoryName =
                                                  _selectedCat;
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .rightToLeft,
                                                      child: Products(
                                                        useFor: 'Products',
                                                      )));
                                            },
                                          ),
                                  )
                                : Container(
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
                                                          .product50[index]
                                                      ['item_path'],
                                              placeholder: (context, url) => Center(
                                                  child:
                                                      CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) => Icon(
                                                      Icons.error,
                                                      color: Colors.grey[200]),
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
                                                            .product50[index]
                                                        ['description'],
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil()
                                                          .setSp(13),
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 2),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 3.0, right: 3.0),
                                                child: Text(
                                                    GlobalVariables
                                                            .product50[index]
                                                        ['uom'],
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
                                                        '${GlobalVariables.product50[index]['list_price_wtax'].toString().toCurrencyFormat}',
                                                        style: TextStyle(
                                                            fontSize:
                                                                ScreenUtil()
                                                                    .setSp(13),
                                                            color:
                                                                brandingColor),
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1),
                                                    Spacer(),
                                                    Text(
                                                      "${NumberFormat.compact().format(int.parse(GlobalVariables.product50[index]['sold']))} sold",
                                                      style: TextStyle(
                                                          color: int.parse(GlobalVariables
                                                                              .product50[
                                                                          index]
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
              : loadingProducts(),
        ],
      ),
    );
  }

  check() async {
    var con = await checkConnectedNetwork(context);
    if (mounted) setState(() {});
    if (con == 'OKAY') {
      // var cat = await getCategories(context, 10);
      var cat = await getCategories(context, 10);
      if (cat != null) {
        GlobalVariables.category10 = cat;
        // GlobalVariables.category10
        //     .sort((a, b) => int.parse(a['id']).compareTo(int.parse(b['id'])));
        GlobalVariables.selectedCategoryName =
            GlobalVariables.category10[0]['category_name'];
        GlobalVariables.selectedCategoryIndex = 0;

        var min = await getMinOrder(context);
        GlobalVariables.minOrderLimit = double.parse(min['min_order_amt']);

        var contact = await getContacts(context);
        GlobalVariables.contacts = contact;

        var trg = await checkTrigVar(context);
        List ltrg = trg;
        ltrg.forEach((element) {
          if (element["tvar"] == "UPDTE") {
            GlobalVariables.trigVarUPDTE = element["tdesc"];
          }
        });

        var p = await getProducts(
            context, GlobalVariables.selectedCategoryName, 50);
        if (p != null) {
          GlobalVariables.product50 = p;
        }
        GlobalVariables.menu0loaded = true;
        if (mounted) setState(() {});

        if (GlobalVariables.appVersion != GlobalVariables.trigVarUPDTE) {
          customUpdateModal(context, Uri.parse(ServerUrl.apkLink));
        } else {
          print(GlobalVariables.appVersion);
          print(GlobalVariables.trigVarUPDTE);
          showPop();
        }
      }
    }
  }

  Widget loadingCategory() {
    var size = MediaQuery.of(context).size;
    var appBarSize = AppBar().preferredSize.height;
    return Container(
      height: appBarSize + 60,
      width: size.width,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Padding(
              padding: index != 9
                  ? const EdgeInsets.only(left: 3, top: 3, bottom: 3)
                  : const EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 3),
              child: Container(
                width: appBarSize + 25,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
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
              ),
            );
          },
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

  _getAppVersion() async {
    try {
      PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
        GlobalVariables.appVersion = packageInfo.version;
      });
    } on PlatformException {
      GlobalVariables.appVersion = "";
    }
  }

  showPop() async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) => ShowNotification());
  }
}
