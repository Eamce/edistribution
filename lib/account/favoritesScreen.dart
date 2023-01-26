import 'package:cached_network_image/cached_network_image.dart';
import 'package:edistribution/products/productsDetails.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool query = false;
  int offset = 0;
  var _controller = ScrollController();
  bool _showBackToTopButton = false;

  @override
  void initState() {
    super.initState();
    check();
  }

  Sessiontimer sessionTimer = Sessiontimer();
  void handleUserInteraction([_]) {
    if (GlobalVariables.logcustomerCode.isNotEmpty) {
      sessionTimer.initializeTimer(context);
    }
  }

  void _scrollToTop() {
    _controller.animateTo(0,
        duration: Duration(seconds: 3), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: handleUserInteraction,
      onPanDown: handleUserInteraction,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          key: _scaffoldkey,
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0.0,
            title: Text('Favourites', style: TextStyle(color: Colors.black)),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  query = false;
                  offset = 0;
                  _showBackToTopButton = false;
                  check();
                },
                icon: Icon(
                  CupertinoIcons.arrow_2_circlepath,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          floatingActionButton: _showBackToTopButton == false
              ? null
              : FloatingActionButton(
                  onPressed: _scrollToTop,
                  child: Icon(Icons.arrow_upward),
                ),
          body: SafeArea(
            child: Column(
              children: [
                !query
                    ? GlobalVariables.productFavorites.length > 0
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
                                      GlobalVariables.productFavorites.length +
                                          1,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount:
                                              GlobalVariables.axisCount,
                                          mainAxisSpacing: 3.5,
                                          crossAxisSpacing: 3.5,
                                          childAspectRatio:
                                              MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  (MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      1.5)),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index ==
                                        GlobalVariables
                                            .productFavorites.length) {
                                      if (offset <=
                                          GlobalVariables
                                              .productFavorites.length) {
                                        return Center(
                                            child: Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: CircularProgressIndicator(),
                                        ));
                                      } else if (offset >
                                          GlobalVariables
                                              .productFavorites.length) {
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
                                                .productFavorites[index]
                                            ['itemcode'];
                                        GlobalVariables.productDetails = [];

                                        for (int i = 0;
                                            i <
                                                GlobalVariables
                                                    .productFavorites.length;
                                            i++) {
                                          if (GlobalVariables
                                                      .productFavorites[i]
                                                  ['itemcode'] ==
                                              code) {
                                            GlobalVariables.productDetails.add(
                                                GlobalVariables
                                                        .productFavorites[i]
                                                    ['units']);
                                          }
                                        }
                                        print(GlobalVariables.productDetails);
                                        print(GlobalVariables
                                                .productFavorites[index]
                                            ['item_path']);

                                        productDetails(
                                            context,
                                            true,
                                            GlobalVariables
                                                    .productFavorites[index]
                                                ['item_path'],
                                            GlobalVariables
                                                    .productFavorites[index]
                                                ['description'],
                                            double.parse(GlobalVariables
                                                    .productFavorites[index]
                                                ['list_price_wtax']),
                                            GlobalVariables
                                                    .productFavorites[index]
                                                ['keywords'],
                                            GlobalVariables
                                                    .productFavorites[index]
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
                                                  imageUrl: ServerUrl
                                                          .itmImgUrl +
                                                      GlobalVariables
                                                              .productFavorites[
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
                                                        const EdgeInsets.all(
                                                            3.0),
                                                    child: Text(
                                                        GlobalVariables
                                                                    .productFavorites[
                                                                index]
                                                            ['description'],
                                                        style: TextStyle(
                                                          fontSize: ScreenUtil()
                                                              .setSp(13),
                                                        ),
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
                                                                .productFavorites[
                                                            index]['uom'],
                                                        style: TextStyle(
                                                          color: Colors.grey,
                                                          fontSize: ScreenUtil()
                                                              .setSp(13),
                                                        ),
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
                                                            NumberFormat
                                                                    .currency(
                                                                        locale:
                                                                            'en',
                                                                        symbol:
                                                                            '₱ ')
                                                                .format(double.parse(
                                                                    GlobalVariables.productFavorites[
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
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 1),
                                                        Spacer(),
                                                        Text(
                                                          "${NumberFormat.compact().format(int.parse(GlobalVariables.productFavorites[index]['sold']))} sold",
                                                          style: TextStyle(
                                                              color: int.parse(GlobalVariables
                                                                              .productFavorites[index]
                                                                          [
                                                                          'sold']) >
                                                                      0
                                                                  ? Colors.grey
                                                                  : Colors
                                                                      .white,
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
                        : nothing()
                    : loadingProducts(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget nothing() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CupertinoIcons.list_bullet_below_rectangle),
          Center(child: Text("Empty")),
        ],
      ),
    );
  }

  check() async {
    GlobalVariables.productFavorites = [];
    query = true;
    if (mounted) setState(() {});
    var con = await checkConnectedNetwork(context);
    if (mounted) setState(() {});
    if (con == 'OKAY') {
      var fav = await getFavoritesProductsOffset(context, offset);
      if (fav != null) {
        GlobalVariables.productFavorites = fav;
        offset = offset + 20;
      }
      query = false;
      if (mounted) setState(() {});
    }
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
}
