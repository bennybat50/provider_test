import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:providermodule/providermodule.dart';

class OrderDishTile extends StatelessWidget {
  Function onTap, onAccept, onReject, onLongPress;
  int dishLength, date, duration;
  String name, total, mealType, status, imgUrl;
  bool onlineImg, isDish;
  OrderDishTile(
      {Key key,
      this.onTap,
      this.onlineImg,
      this.total,
      this.dishLength,
      this.status,
      this.name,
      this.mealType,
      this.duration,
      this.date,
      this.imgUrl,
      this.isDish,
      this.onLongPress,
      this.onAccept,
      this.onReject})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    onlineImg ??= false;
    isDish ??= false;
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 6.0,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        child: ListTile(
          onLongPress: onLongPress,
          leading: Material(
            borderRadius: BorderRadius.circular(10),
            elevation: 5,
            color: Colors.black.withOpacity(0.6),
            child: InkWell(
              onTap: onTap,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 120,
                  width: 60,
                  child: GetImageProvider(
                    url: imgUrl,
                    placeHolder: PublicVar.defaultKitchenImage,
                  ),
                ),
              ),
            ),
          ),
          trailing: InkWell(
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                getTimeWidget(),
                Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text(
                    'x $dishLength',
                    style: TextStyle(
                        color: Colors.black54, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          title: InkWell(
            onTap: onTap,
            child: Text(
              name,
              style:
                  TextStyle(fontWeight: FontWeight.w600, color: Colors.black),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          subtitle: InkWell(
            onTap: onTap,
            child: Wrap(
              direction: Axis.vertical,
              children: <Widget>[
                Text('${convertDate(date, 'date')}',
                    style: TextStyle(fontSize: 12)),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: getOrderDishStatus(
                      status: status, fontSize: 10, isDish: isDish),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  getTimeWidget() {
    return Container(
      height: 20,
      width: 60,
      child: Row(
        children: <Widget>[
          Icon(
            Feather.clock,
            size: 14,
            color: getTimingColor(value: duration),
          ),
          SizedBox(
            width: 2,
          ),
          Flexible(
            fit: FlexFit.loose,
                      child: Text(
              '$duration min',
              style:
                  TextStyle(fontSize: 12, color: getTimingColor(value: duration)),
            ),
          ),
        ],
      ),
    );
  }
}

getTimingBg({child, value}) {
  print(value);
  if(value==null){
    value=0;
  }
  return ClipRRect(
    borderRadius: BorderRadius.circular(200),
    child: Container(
      height: 20,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      alignment: Alignment.center,
      color: getTimingColor(value: value),
      child: child,
    ),
  );
}

getTimingColor({int value}) {
  try{
    if (value > 40) {
    return Colors.green[800];
  } else if (value >= 30 && value <= 40) {
    return Colors.green;
  } else if (value >= 20 && value <= 30) {
    return Colors.green[400];
  } else if (value >= 15 && value <= 20) {
    return Colors.orangeAccent;
  } else if (value >= 10 && value <= 15) {
    return Colors.orange;
  } else if (value >= 5 && value <= 10) {
    return Colors.deepOrangeAccent;
  } else if (value >= 0 && value <= 5) {
    return Colors.red;
  } else if (value == 0) {
    return Colors.red;
  }
  }catch(e){
    return  Colors.grey;
  }
}

getOrderDishStatus({String status, double fontSize, bool isDish}) {
  if (isDish) {
    switch (status) {
      case "PENDING":
        return getStatusContainer(
            text: 'Pending..',
            bgColor: Colors.deepOrangeAccent,
            fontSize: fontSize);
      case "IN_PROGRESS":
        return getStatusContainer(
            text: 'Preparing..', bgColor: Colors.orangeAccent, fontSize: fontSize);
      case "FINISHED":
        return getStatusContainer(
            text: 'Ready!', bgColor: Colors.green, fontSize: fontSize);
      default:
        return SizedBox();
    }
  } else {
    switch (status) {
      case "PENDING":
        return getStatusContainer(
            text: 'Pending..',
            bgColor: Colors.deepOrangeAccent,
            fontSize: fontSize);
      case "REJECTED":
        return getStatusContainer(
            text: 'Rejected', bgColor: Colors.red, fontSize: fontSize);
      case "ACCEPTED":
        return getStatusContainer(
            text: 'Preparing..', bgColor: Colors.orange, fontSize: fontSize);
      case "IN_PROGRESS":
        return getStatusContainer(
            text: 'Preparing..', bgColor: Colors.orange, fontSize: fontSize);
      case "READY":
        return getStatusContainer(
            text: 'Ready!', bgColor: Colors.green, fontSize: fontSize);
      case "IN_TRANSIT":
        return getStatusContainer(
            text: 'In Transit', bgColor: Colors.blue, fontSize: fontSize);
      case "CONFIRMED":
        return getStatusContainer(
            text: 'Delivered', bgColor: Colors.black, fontSize: fontSize);
      case "DELIVERED":
        return getStatusContainer(
            text: 'Delivered', bgColor: Colors.black, fontSize: fontSize);
      default:
        return SizedBox();
    }
  }
}

getStatusContainer({text, bgColor, fontSize}) {
  fontSize ??= 10.0;
  return ClipRRect(
    borderRadius: BorderRadius.circular(2),
    child: Container(
      color: bgColor,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 5),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    ),
  );
}

labelStatusDisplay({
  text,
  textColor,
  bgColor,
  icon,
  double iconSize,
  textSize,
}) {
  return Container(
    height: 50,
    color: bgColor ?? Colors.transparent,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          text,
          style: TextStyle(
              color: textColor ?? Colors.white,
              fontSize: textSize ?? 14,
              fontWeight: FontWeight.w700),
        ),
        SizedBox(
          width: 10,
        ),
        Icon(
          icon,
          size: iconSize ?? 18,
          color: textColor ?? Colors.white,
        )
      ],
    ),
  );
}

showOrderActionSelectorSheet({context, scaffoldKey, status}) {
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
            key: scaffoldKey,
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10),
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            height: 4,
                            width: 100,
                            color: Colors.grey[300],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 14.0),
                        child: Text(
                          'Choose an action',
                          style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withOpacity(0.7)),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Ionicons.ios_eye,
                                size: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'View',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Ionicons.ios_videocam,
                                size: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Update from camera',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                Ionicons.ios_photos,
                                size: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text(
                                  'Update from gallery',
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700),
                                ),
                              )
                            ],
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[200],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w800),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      Container(
                        height: 1,
                        width: double.infinity,
                        color: Colors.grey[200],
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
      });
}

convertDate(timestamp, get) {
  var date = new DateTime.fromMillisecondsSinceEpoch(timestamp);
  var day = date.day,
      year = date.year,
      month = date.month,
      hour = date.hour,
      min = date.minute;
  switch (get) {
    case 'time':
      return '$hour:$min';
    case 'date':
      return '$day-${getMonth(month)}-$year';
  }
}

getMonth(data) {
  switch (data) {
    case 1:
      return 'January';
    case 2:
      return 'February';
    case 3:
      return 'March';
    case 4:
      return 'April';
    case 5:
      return 'May';
    case 6:
      return 'June';
    case 7:
      return 'July';
    case 8:
      return 'August';
    case 9:
      return 'September';
    case 10:
      return 'October';
    case 11:
      return 'November';
    case 12:
      return 'December';
  }
}
