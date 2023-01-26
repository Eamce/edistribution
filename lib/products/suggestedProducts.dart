import 'package:cached_network_image/cached_network_image.dart';
import 'package:edistribution/products/productsDetails.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/utility/sessionTimer.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/server_url.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SuggestedProducts extends StatefulWidget {
  final String itemcode;
  final String family;
  final String keyword;
  const SuggestedProducts(
      {Key? key,
      required this.itemcode,
      required this.family,
      required this.keyword})
      : super(key: key);

  @override
  _SuggestedProductsState createState() => _SuggestedProductsState();
}

class _SuggestedProductsState extends State<SuggestedProducts> {
  int offset = 0;
  var _controller = ScrollController();
  bool query = false;

  @override
  void initState() {
    super.initState();
    GlobalVariables.productSimilar = [];
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          loadOffset();
        }
      });
    check();
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
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: handleUserInteraction,
      onPanDown: handleUserInteraction,
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 0.0,
            title: Text(
              "Similar Products",
              style: TextStyle(color: Colors.black),
            ),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: SafeArea(
            child: Column(
              children: [
                GlobalVariables.productSimilar.length > 0
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
                                  GlobalVariables.productSimilar.length + 1,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: GlobalVariables.axisCount,
                                      mainAxisSpacing: 3.5,
                                      crossAxisSpacing: 3.5,
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.5)),
                              itemBuilder: (BuildContext context, int index) {
                                if (index ==
                                    GlobalVariables.productSimilar.length) {
                                  if (offset <=
                                      GlobalVariables.productSimilar.length) {
                                    return Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: CircularProgressIndicator(),
                                    ));
                                  } else if (offset >
                                      GlobalVariables.productSimilar.length) {
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
                                        .productSimilar[index]['itemcode'];
                                    GlobalVariables.productDetails = [];

                                    for (int i = 0;
                                        i <
                                            GlobalVariables
                                                .productSimilar.length;
                                        i++) {
                                      if (GlobalVariables.productSimilar[i]
                                              ['itemcode'] ==
                                          code) {
                                        GlobalVariables.productDetails.add(
                                            GlobalVariables.productSimilar[i]
                                                ['units']);
                                      }
                                    }
                                    productDetails(
                                        context,
                                        true,
                                        GlobalVariables.productSimilar[index]
                                            ['item_path'],
                                        GlobalVariables.productSimilar[index]
                                            ['description'],
                                        double.parse(GlobalVariables
                                                .productSimilar[index]
                                            ['list_price_wtax']),
                                        GlobalVariables.productSimilar[index]
                                            ['keywords'],
                                        GlobalVariables.productSimilar[index]
                                            ['product_family'],
                                        true);
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
                                                          .productSimilar[index]
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
                                                            .productSimilar[
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
                                                padding: const EdgeInsets.only(
                                                    left: 3.0, right: 3.0),
                                                child: Text(
                                                    GlobalVariables
                                                            .productSimilar[
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
                                                                        .productSimilar[index][
                                                                    'list_price_wtax'])),
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
                                                      "${NumberFormat.compact().format(int.parse(GlobalVariables.productSimilar[index]['sold']))} sold",
                                                      style: TextStyle(
                                                          color: int.parse(GlobalVariables
                                                                              .productSimilar[
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
          ),
        ),
      ),
    );
  }

  loadOffset() async {
    var p = await getSimilarProducts(
        context, widget.itemcode, widget.family, widget.keyword, offset);
    if (p != null) {
      List offsetP = p;
      GlobalVariables.productSimilar.addAll(offsetP);
      offset = offset + 20;
      if (mounted) setState(() {});
    }
  }

  check() async {
    GlobalVariables.productSimilar = [];
    query = true;
    if (mounted) setState(() {});
    var con = await checkConnectedNetwork(context);
    if (mounted) setState(() {});
    if (con == 'OKAY') {
      var p = await getSimilarProducts(
          context, widget.itemcode, widget.family, widget.keyword, offset);
      if (p != null) {
        GlobalVariables.productSimilar = p;
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
