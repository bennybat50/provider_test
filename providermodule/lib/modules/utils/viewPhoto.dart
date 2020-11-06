import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:photo_view/photo_view.dart';
import 'package:providermodule/providermodule.dart';

class ViewPhotos extends StatefulWidget {
  final url, singleImg, defaultImage, title;
  bool single, online;
  List imgList;
  ViewPhotos(
      {Key key,
      this.url,
      this.single,
      this.online,
      this.imgList,
      this.singleImg,
      this.defaultImage,
      this.title})
      : super(key: key);
  @override
  _ViewPhotosState createState() => _ViewPhotosState();
}

class _ViewPhotosState extends State<ViewPhotos> {
  PageController pageController;

  @override
  void initState() {
    pageController = new PageController(
        initialPage: 0, keepPage: true, viewportFraction: 1.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.black,
        title: Text(
          '${widget.title ?? ""}',
          style: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: Icon(
            Ionicons.ios_close,
            color: Colors.white,
            size: 45,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: widget.single ? singleView() : multiView(),
    );
  }

  singleView() {
    return Center(
      child: PhotoView(
        loadFailedChild: Image.asset(widget.defaultImage),
        imageProvider: widget.online
            ? CachedNetworkImageProvider(widget.singleImg)
            : AssetImage(widget.singleImg),
      ),
    );
  }

  multiView() {
    return PageView.builder(
        controller: pageController,
        physics: AlwaysScrollableScrollPhysics(),
        itemCount: widget.imgList.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(color: Colors.black),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                        tag: widget.imgList[index],
                        child: InkWell(
                          child: PhotoView(
                            loadFailedChild: Image.asset(widget.defaultImage),
                            imageProvider: widget.online
                                ? CachedNetworkImageProvider(
                                    widget.imgList[index])
                                : AssetImage(widget.imgList[index]),
                          ),
                        )),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Wrap(
                      children: List.generate(widget.imgList.length, (i) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 18.0, horizontal: 10),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30),
                              child: Container(
                                height: 8,
                                width: 8,
                                color: index == i
                                    ? Color(PublicVar.primaryColor)
                                    : Colors.white,
                              )),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
