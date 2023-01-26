import 'package:cached_network_image/cached_network_image.dart';
import 'package:edistribution/products/productsDetails.dart';
import 'package:edistribution/products/searchProducts.dart';
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
import 'package:page_transition/page_transition.dart';

class Products extends StatefulWidget {
  final String useFor;
  const Products({Key? key, required this.useFor}) : super(key: key);

  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();
  bool query = false;

  int offset = 0;
  var _controller = ScrollController();

  bool _showBackToTopButton = false;

  int? drawerSelectedCat;

  @override
  void initState() {
    super.initState();
    // Setup the listener.
    _controller = ScrollController()
      ..addListener(() {
        if (_controller.position.pixels ==
            _controller.position.maxScrollExtent) {
          loadOffset();
        }

        // _controller.position.maxScrollExtent * 0.85
        if (_controller.position.pixels >=
            (_controller.position.maxScrollExtent - 150)) {
          if (_showBackToTopButton == false) {
            _showBackToTopButton = true;
            if (mounted) setState(() {});
          }
        } else if (_controller.position.pixels <
            (_controller.position.maxScrollExtent - 150)) {
          if (_showBackToTopButton == true) {
            _showBackToTopButton = false;
            if (mounted) setState(() {});
          }
        }
      });
    check();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
          endDrawer: endDrawer(),
          appBar: AppBar(
            backgroundColor: brandingColor,
            titleSpacing: 0.0,
            title: Text(GlobalVariables.selectedCategoryName),
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                  icon: Icon(CupertinoIcons.search, color: Colors.white),
                  onPressed: () => Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: SearchProducts()))),
              IconButton(
                  icon:
                      Icon(CupertinoIcons.square_grid_2x2, color: Colors.white),
                  onPressed: () => _scaffoldkey.currentState!.openEndDrawer())
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
                GlobalVariables.product.length > 0
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
                              itemCount: GlobalVariables.product.length + 1,
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
                                if (index == GlobalVariables.product.length) {
                                  if (offset <=
                                      GlobalVariables.product.length) {
                                    return Center(
                                        child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: CircularProgressIndicator(),
                                    ));
                                  } else if (offset >
                                      GlobalVariables.product.length) {
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
                                    var code = GlobalVariables.product[index]
                                        ['itemcode'];
                                    GlobalVariables.productDetails = [];

                                    for (int i = 0;
                                        i < GlobalVariables.product.length;
                                        i++) {
                                      if (GlobalVariables.product[i]
                                              ['itemcode'] ==
                                          code) {
                                        GlobalVariables.productDetails.add(
                                            GlobalVariables.product[i]
                                                ['units']);
                                      }
                                    }
                                    print(GlobalVariables.productDetails);
                                    productDetails(
                                        context,
                                        true,
                                        GlobalVariables.product[index]
                                            ['item_path'],
                                        GlobalVariables.product[index]
                                            ['description'],
                                        double.parse(GlobalVariables
                                            .product[index]['list_price_wtax']),
                                        GlobalVariables.product[index]
                                            ['keywords'],
                                        GlobalVariables.product[index]
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
                                                  GlobalVariables.product[index]
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
                                                            .product[index]
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
                                                        .product[index]['uom'],
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
                                                                        .product[index][
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
                                                      "${NumberFormat.compact().format(int.parse(GlobalVariables.product[index]['sold']))} sold",
                                                      style: TextStyle(
                                                          color: int.parse(GlobalVariables
                                                                              .product[
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

  check() async {
    GlobalVariables.product = [];
    query = true;
    if (mounted) setState(() {});
    var con = await checkConnectedNetwork(context);
    if (mounted) setState(() {});
    if (con == 'OKAY') {
      // var cat = await getCategories(context, 0);

      var cat = await getCategories(context, 0);
      if (cat != null) {
        GlobalVariables.category = cat;
        // GlobalVariables.category
        //     .sort((a, b) => int.parse(a['id']).compareTo(int.parse(b['id'])));

        if (widget.useFor == 'Category')
          _scaffoldkey.currentState!.openEndDrawer();

        var p = await getProductsOffset(
            context, GlobalVariables.selectedCategoryName, offset);
        if (p != null) {
          GlobalVariables.product = p;
          offset = offset + 20;
        }
        query = false;
        if (mounted) setState(() {});
      }
    }
  }

  productsDrawerSelected(int index) async {
    GlobalVariables.product = [];
    GlobalVariables.selectedCategoryName =
        GlobalVariables.category[index]['category_name'];
    offset = 0;
    var p = await getProductsOffset(
        context, GlobalVariables.selectedCategoryName, offset);
    if (p != null) {
      GlobalVariables.product = p;
      offset = offset + 20;
      query = false;
      if (mounted) setState(() {});
    }
  }

  loadOffset() async {
    print(offset);
    var p = await getProductsOffset(
        context, GlobalVariables.selectedCategoryName, offset);
    if (p != null) {
      List offsetP = p;
      GlobalVariables.product.addAll(offsetP);
      offset = offset + 20;
      if (offset <= GlobalVariables.product.length) {
        _showBackToTopButton = false;
      }
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

  Widget endDrawer() {
    var size = MediaQuery.of(context).size;
    return Container(
      width: size.width / 2,
      child: SafeArea(
        child: Drawer(
          key: const PageStorageKey<String>('categorydrawerstate'),
          child: Column(
            children: [
              Container(
                color: brandingColor,
                height: size.height / 20,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: brandingColor,
                    child: Text('CATEGORY',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(15)),
                        textAlign: TextAlign.center),
                  ),
                ),
              ),
              Expanded(
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overscroll) {
                    overscroll.disallowIndicator();
                    return false;
                  },
                  child: Scrollbar(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                      itemCount: GlobalVariables.category.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            drawerSelectedCat = index;
                            query = true;
                            GlobalVariables.product = [];
                            if (mounted) setState(() {});
                            Navigator.pop(context);
                            productsDrawerSelected(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 3.0, bottom: 3.0, left: 8.0, right: 8.0),
                            child: Container(
                                alignment: Alignment.centerLeft,
                                height: size.height / 20,
                                child: Text(
                                    GlobalVariables.category[index]
                                        ['category_name'],
                                    style: TextStyle(
                                        color: drawerSelectedCat == index
                                            ? brandingColor
                                            : Colors.blueGrey[900],
                                        fontSize: ScreenUtil().setSp(14)),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
