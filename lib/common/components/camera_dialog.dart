import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class CameraDialog extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _CameraDialogState();
}

class _CameraDialogState extends State<CameraDialog> {
  CameraController _controller;
  Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();

    _initializeControllerFuture = _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(firstCamera, ResolutionPreset.medium,
        enableAudio: false);

    return _controller.initialize();
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture(BuildContext context) async {
    try {
      await _initializeControllerFuture;

      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}.png',
      );

      await _controller.takePicture(path);
      Navigator.of(context).pop(path);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: FutureBuilder<void>(
      future: _initializeControllerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done)
          return Center(child: CircularProgressIndicator());

        return AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: Stack(children: [
              CameraPreview(_controller),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Container(
                                color: Colors.black54,
                                child: IconButton(
                                    iconSize: 64,
                                    icon: Icon(
                                      Icons.camera,
                                      color: Colors.white70,
                                    ),
                                    onPressed: () => _takePicture(context))))
                      ]))
            ]));
      },
    ));
  }
}
