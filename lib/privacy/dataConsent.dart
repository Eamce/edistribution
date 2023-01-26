import 'package:edistribution/auth/signup/signup1Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class DataConsent extends StatelessWidget {
  const DataConsent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleSpacing: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title:
            Text("Data Consent", style: TextStyle(color: Colors.blueGrey[900])),
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "I hereby grant my express, unconditional, voluntary and informed consent to ALTURAS GROUP OF COMPANIES, its respective subsidiaries, affiliates, associated companies, and jointly controlled entities, its partners, and service providers – to collect, process, and store any personal data I may provide. Further, I acknowledge that the collection and processing of my data are necessary for the purposes outlined in the Privacy Notice. I am fully aware that AGC allows me to exercise my rights as a data subject, and requests are subject to evaluation and approval.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        width: size.width / 3,
                        height: size.height / 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Spacer(),
                            Icon(
                              CupertinoIcons.xmark,
                              size: 25,
                              color: Colors.redAccent,
                            ),
                            Text("Disagree"),
                            Spacer(),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pop();
                      },
                    ),
                    InkWell(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      child: Container(
                        width: size.width / 3,
                        height: size.height / 20,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Spacer(),
                            Icon(
                              CupertinoIcons.checkmark_alt,
                              size: 25,
                              color: Colors.greenAccent,
                            ),
                            Text("I Agree"),
                            Spacer(),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            PageTransition(
                                type: PageTransitionType.rightToLeft,
                                child: Singup1Screen()));
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
