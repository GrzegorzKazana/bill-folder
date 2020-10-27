import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget> footer;

  CustomDialog({this.title, this.child, this.footer = const []});

  @override
  Widget build(BuildContext context) {
    return Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
            constraints: BoxConstraints(
                minHeight: 200, maxHeight: 500, minWidth: 200, maxWidth: 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (title != null)
                  Container(
                      padding: EdgeInsets.only(top: 12),
                      margin: EdgeInsets.all(4),
                      child: Text(title, style: TextStyle(fontSize: 24))),
                if (child != null)
                  IntrinsicHeight(
                      child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          constraints: BoxConstraints(
                              minHeight: 200,
                              maxHeight: 400,
                              minWidth: 200,
                              maxWidth: 400),
                          child: SingleChildScrollView(child: child))),
                if (footer.length > 0)
                  Padding(
                      padding: EdgeInsets.only(top: 12, left: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: footer,
                      ))
              ],
            )));
  }
}
