import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:providermodule/modules/models/PublicVar.dart';
import 'package:providermodule/providermodule.dart';

class BottomAction extends StatefulWidget {
  final price, text, onTap, color;
  final bool loading;
  const BottomAction(
      {Key key, this.price, this.text, this.onTap, this.color, this.loading})
      : super(key: key);

  @override
  _BottomActionState createState() => _BottomActionState();
}

class _BottomActionState extends State<BottomAction> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color ?? Color(PublicVar.primaryColor),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.0, vertical: 16),
        child: widget.loading ?? false
            ? Wrap(
                alignment: WrapAlignment.center,
                children: <Widget>[ShowProcessingIndicator()],
              )
            : InkWell(
                onTap: widget.onTap,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Flexible(
                      fit: FlexFit.loose,
                      child: InkWell(
                        onTap: widget.onTap,
                        child: Text(
                          widget.text,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      flex: 0,
                      child: Text(
                        "${widget.price}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }


  
}
