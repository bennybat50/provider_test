import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flexible_toast/flutter_flexible_toast.dart';
import 'package:providermodule/providermodule.dart';

import 'widgets/global-widgets.dart';

class AppActions {
  showSuccessToast({String text}) {
    FlutterFlexibleToast.showToast(
        message: text,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        fontSize: 16,
        radius: 20,
        elevation: 0,
        textColor: Colors.white);
  }

  showErrorToast({String text}) {
    FlutterFlexibleToast.showToast(
        message: text,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.red,
        fontSize: 16,
        radius: 20,
        elevation: 0,
        textColor: Colors.white);
  }

  showLoadingToast({String text}) {
    FlutterFlexibleToast.showToast(
        message: text,
        toastLength: Toast.LENGTH_LONG,
        backgroundColor: Colors.black,
        icon: ICON.LOADING,
        fontSize: 16,
        imageSize: 20,
        radius: 20,
        elevation: 0,
        textColor: Colors.white);
  }

  Future<bool> checkInternetConnection({url}) async {
    bool internet;
    try {
      final result = await InternetAddress.lookup(url ?? 'google.com')
          .timeout(Duration(seconds: 10));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        internet = true;
      }
    } on SocketException catch (e) {
      internet = false;
    }
    return internet;
  }

  showDeleteSheet({context, scaffold, text, accept, deny}) {
    showModalBottomSheet(
        context: context,
        isDismissible: false,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return Scaffold(
              key: scaffold,
              backgroundColor: Colors.transparent,
              resizeToAvoidBottomInset: true,
              body: Padding(
                padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
                child: ListView(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 14.0, bottom: 10),
                          child: Text(
                            text,
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.w800),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: ButtonWidget(
                                onPress: deny,
                                width: 100.0,
                                height: 35.0,
                                txColor: Colors.white,
                                bgColor: Colors.redAccent,
                                text: 'Cancel',
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 10),
                              child: ButtonWidget(
                                onPress: accept,
                                width: 100.0,
                                height: 35.0,
                                txColor: Colors.white,
                                bgColor: Color(PublicVar.primaryColor),
                                text: 'Save',
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

 showAppDialog(context,{Function okAction,cancleAction,String title, descp, cancleText,okText,bool singlAction, danger}) {
    if(singlAction==null){
      singlAction=false;
    }
    if(danger==null){
      danger=false;
    }
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return StatefulBuilder(
            builder: (BuildContext context, setState) {
              return Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 50,
                     height: MediaQuery.of(context).size.height * 0.50,
                    child: Center(
                        child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 38.0),
                      child: Container(
                        width: double.infinity,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                        decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.95),
                            borderRadius: BorderRadius.circular(20)),
                        child: SingleChildScrollView(
                                                  child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                              height: 4,
                            ),
                            Text(title??"",
                            textAlign: TextAlign.center, 
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding:  EdgeInsets.symmetric(horizontal:10.0),
                              child: Text("${descp??""}",textAlign: TextAlign.center, style: TextStyle(fontSize: 17,color: Colors.black87.withOpacity(0.8)),),
                            ),
                            SizedBox(
                              height: 1,
                            ),
                            Divider(),
                            singlAction? FlatButton(
                                  onPressed: okAction??()=>Navigator.pop(context),
                                  child: Text(
                                    okText??"",
                                    style: TextStyle(
                                        color: danger?Colors.redAccent: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ): Row(
                              mainAxisAlignment:MainAxisAlignment.spaceAround,
                              children: <Widget>[
                              FlatButton(
                                  onPressed: cancleAction??()=>Navigator.pop(context),
                                  child: Text(
                                    cancleText??"",
                                    style: TextStyle(
                                        color:danger?Colors.black: Colors.redAccent,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                FlatButton(
                                  onPressed: okAction??()=>Navigator.pop(context),
                                  child: Text(
                                    okText??"",
                                    style: TextStyle(
                                        color: danger?Colors.redAccent: Colors.black,
                                        fontSize: 17,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ],
                            )
                          ]),
                        ),
                      ),
                    )),
                  ),
                ),
              );
            },
          );
        });
  }
}
