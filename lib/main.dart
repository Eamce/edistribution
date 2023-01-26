import 'dart:async';
import 'package:edistribution/router/routeConstant.dart';
import 'package:edistribution/router/router.dart';
import 'package:edistribution/services/api.dart';
import 'package:edistribution/services/checkConnectedNetwork.dart';
import 'package:edistribution/values/branding_color.dart';
import 'package:edistribution/values/global_variables.dart';
import 'package:edistribution/values/images.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:root_check/root_check.dart';

void main() {
  runApp(Distribution());
}

class Distribution extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return ScreenUtilInit(
      builder: (BuildContext context, child) => MaterialApp(
        title: 'My NETgosyo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: brandingColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.black.withOpacity(0)),
        ),
        onGenerateRoute: Routers.onGenerateRoute,
        home: Splash(),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  bool? isRootedDevice = false;

  @override
  void initState() {
    super.initState();
    initPlatformStateCheckRooted();
    Timer(Duration(seconds: 5), () {
      checkFirstSeen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: brandingColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Image.asset(
                  Images.logo,
                  width: 85,
                ),
              ),
            ),
            Container(
                child: Text("Loading resources",
                    style: TextStyle(color: Colors.white))),
            Container(
              width: 115,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> initPlatformStateCheckRooted() async {
    bool? isRooted = await RootCheck.isRooted;
    if (!mounted) return;
    isRootedDevice = isRooted;
    setState(() {});
  }

  Future checkFirstSeen() async {
    if (isRootedDevice == false) {
      var con = await checkConnectedNetwork(context);
      // print(con);
      if (con == 'OKAY') {
        var cutofftime = await getCutOffTime(context);
        GlobalVariables.cutOffTime = DateFormat("hh:mm a").format(
            DateTime.parse("0000-00-00 ${cutofftime[0]['cut_off_time']}"));
        var min = await getMinOrder(context);
        GlobalVariables.minOrderLimit = double.parse(min['min_order_amt']);
        var contact = await getContacts(context);
        GlobalVariables.contacts = contact;
        var custServiceUser = await getCustomerServiceUsers(context);
        GlobalVariables.customerServiceUsers = custServiceUser;
        var allItemDesc = await getAllItemDesc(context);
        GlobalVariables.allItemDescription = allItemDesc;
        var trg = await checkTrigVar(context);
        List ltrg = trg;
        ltrg.forEach((element) {
          if (element["tvar"] == "UPDTE") {
            GlobalVariables.trigVarUPDTE = element["tdesc"];
            GlobalVariables.updteChangeLog = element["changelog"];
          }
        });
        Navigator.pushNamed(context, menuRoute);
      }
    } else {
      Navigator.pushNamed(context, trustFallRoute);
    }
  }
}
