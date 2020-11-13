import 'package:flutter/material.dart';

class PhotoInput extends StatelessWidget {
  final String photoPath;
  final VoidCallback showCameraDialog;
  final VoidCallback deletePhoto;

  PhotoInput(
      {@required this.photoPath,
      @required this.showCameraDialog,
      @required this.deletePhoto});

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerRight,
        constraints: BoxConstraints(minHeight: 48),
        child: photoPath != null
            ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                Text('1 photo',
                    style:
                        TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
                IconButton(icon: Icon(Icons.delete), onPressed: deletePhoto)
              ])
            : IconButton(
                icon: Icon(Icons.camera_alt), onPressed: showCameraDialog));
  }
}
