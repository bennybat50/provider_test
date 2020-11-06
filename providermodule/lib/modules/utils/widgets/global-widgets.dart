import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:providermodule/modules/models/PublicVar.dart';

class BackgroundText extends StatelessWidget {
  final text, fontSize;
  const BackgroundText({Key key, this.text, this.fontSize}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        color: Colors.white,
        shadows: [
          Shadow(
            blurRadius: 1.0,
            color: Colors.black45,
            offset: Offset(1.0, 1.0),
          ),
        ],
      ),
    );
  }
}

class CircleImage extends StatelessWidget {
  final String url, source;
  final double size;
  const CircleImage({Key key, this.size, this.url, this.source})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(size + 10.0),
        child: Container(
          height: size,
          width: size,
          child: getSource(),
        ));
  }

  getSource() {
    switch (source) {
      case 'online':
        return CachedNetworkImage(
          imageUrl: url,
          fit: BoxFit.cover,
        );
      case 'asset':
        return Image.asset(
          url,
          fit: BoxFit.cover,
        );
      case 'file':
        return FileImage(File(url));
    }
  }
}

FormDecorator({helper, hint, icon,color}) {
  return InputDecoration(
    border: InputBorder.none,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(12.0)),
      borderSide: BorderSide(color: Colors.grey[100], width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Color(PublicVar.primaryColor)),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: Colors.redAccent),
    ),
    fillColor: color??Colors.grey[100],
    filled: true,
    helperText: helper,
    icon: icon ?? null,
    hintStyle: TextStyle(color: Colors.black45),
    hintText: hint,
  );
}

class ButtonWidget extends StatelessWidget {
  final width,
      height,
      text,
      bgColor,
      txColor,
      radius,
      child,
      onPress,
      textIcon,
      fontSize,
      icon,
      iconColor,
      iconSize;
  bool loading, addIconBG;
  ButtonWidget({
    Key key,
    this.width,
    this.height,
    this.text,
    this.bgColor,
    this.txColor,
    this.radius,
    this.child,
    this.onPress,
    this.loading,
    this.textIcon,
    this.fontSize,
    this.addIconBG,
    this.icon,
    this.iconColor,
    this.iconSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    if (addIconBG == null) {
      addIconBG = true;
    }
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(),
      child: child ??
          Material(
            color: bgColor,
            elevation: 0.5,
            shadowColor: Colors.grey[100],
            borderOnForeground: false,
            borderRadius: BorderRadius.circular(radius ?? 8),
            child: InkWell(
              onTap: onPress,
              splashColor: Colors.grey[200],
              borderRadius: BorderRadius.circular(radius ?? 8),
              child: icon == null
                  ? Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                      child: Center(
                        child: loading ?? false
                            ? ShowProcessingIndicator()
                            : Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(),
                                  Flexible(
                                      fit: FlexFit.loose,
                                      child: Text(
                                        text,
                                        style: TextStyle(
                                            color: txColor,
                                            fontSize: fontSize ?? 16,
                                            fontWeight: FontWeight.w600),
                                      )),
                                  textIcon != null
                                      ? ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              radius ?? 40),
                                          child: Container(
                                              height: 20,
                                              width: 20,
                                              color: addIconBG
                                                  ? Colors.white
                                                  : Colors.transparent,
                                              alignment: Alignment.center,
                                              child: Icon(
                                                textIcon,
                                                color: addIconBG
                                                    ? bgColor
                                                    : txColor,
                                                size: 16,
                                              )))
                                      : SizedBox()
                                ],
                              ),
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(radius ?? 40),
                      child: Container(
                          height: height,
                          width: width,
                          color: bgColor,
                          child: Icon(
                            icon,
                            color: iconColor,
                            size: iconSize,
                          ))),
            ),
          ),
    );
  }
}

class DisplayMessage extends StatelessWidget {
  final String asset, message, btnText;
  final Function onPress;
  final double btnWidth;
  const DisplayMessage(
      {Key key,
      this.asset,
      this.message,
      this.btnText,
      this.onPress,
      this.btnWidth})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          asset == null
              ? SizedBox()
              : Image.asset(
                  asset,
                  height: 80,
                ),
          btnText == null
              ? SizedBox()
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600),
                  ),
                ),
          message == null
              ? SizedBox()
              : ButtonWidget(
                  onPress: onPress,
                  width: btnWidth ?? 120.0,
                  height: 35.0,
                  radius: 20.0,
                  fontSize: 15.0,
                  txColor: Colors.white,
                  bgColor: Color(PublicVar.primaryColor).withOpacity(0.7),
                  text: btnText,
                )
        ],
      ),
    );
  }
}

class loadingProcess extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Container(
              width: 50.0,
              height: 50.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ShowProcessingIndicator(),
            ),
          ),
        ],
      ),
    );
  }
}

class ShowProcessingIndicator extends StatelessWidget {
  final double size;
  const ShowProcessingIndicator({Key key, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size ?? 20,
      width: size ?? 20,
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey[100],
        strokeWidth: 1.5,
      ),
    );
  }
}

class BackBtn extends StatelessWidget {
  final onTap, titleDark, icon, iconSize;
  const BackBtn({Key key, this.onTap, this.titleDark, this.icon, this.iconSize})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Padding(
            padding: EdgeInsets.all(14),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: titleDark ? Colors.white : Colors.black,
              child: Icon(
                icon,
                color: titleDark ? Colors.black : Colors.white,
                size: iconSize ?? 25,
              ),
            )));
  }
}

class GetImageProvider extends StatelessWidget {
  final url, placeHolder, height;
  const GetImageProvider({Key key, this.url, this.placeHolder, this.height})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      width: double.infinity,
      height: height,
      imageUrl: url?? "",
      placeholder: (context, url) => Image.asset(
        placeHolder,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      errorWidget: (context, url, error) => Image.asset(
        placeHolder,
        fit: BoxFit.cover,
        width: double.infinity,
      ),
      fit: BoxFit.cover,
    );
  }
}

class ShowPageLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(10.0),
            child: ShowProcessingIndicator(
              size: 30,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text('One moment please...')
        ],
      ),
    );
  }
}

//
