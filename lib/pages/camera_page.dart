import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_font_icons/flutter_font_icons.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({ Key? key }) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late List<CameraDescription> _cameras;
  late CameraController _controller;
  bool _isReady = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _setUpCamera();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setUpCamera() async {
    try {
      // initialize cameras.
      _cameras = await availableCameras();
      // initialize camera controllers.
      // Current bug for high / medium with samsung devices.
      _controller = CameraController(
        _cameras[0],
        ResolutionPreset.max,
      );

      await _controller.initialize();
    } on CameraException catch (_) {
      // do something on error.
    }
    if (!mounted) return;
    setState(() {
      _isReady = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      floatingActionButton: getFooter(),
      body: getBody(),
    );
  }

  Widget cameraPreview() {
    return 
    AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: CameraPreview(_controller));
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;
    if (_isReady == false ||
        !_controller.value.isInitialized) {
      return Container(
        decoration: const BoxDecoration(color: Colors.white),
        width: size.width,
        height: size.height,
        child: const Center(
            child: SizedBox(
                width: 25,
                height: 25,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ))),
      );
    }

    return SizedBox(
      width: size.width,
      height: size.height,
      child: ClipRRect(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          child: cameraPreview()),
    );
  }

  Widget getFooter() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3)),
                    child: const Icon(
                      Entypo.user,
                      color: Colors.yellow,
                      size: 23,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3)),
                    child: const Icon(
                      Feather.search,
                      color: Colors.white,
                      size: 23,
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.3)),
                    child: const Icon(
                      Feather.user_plus,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.black.withOpacity(0.3)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: const [
                          Icon(
                            SimpleLineIcons.refresh,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Icon(
                            Entypo.flash,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Icon(
                            MaterialCommunityIcons.play_box_outline,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Icon(
                            Entypo.beamed_note,
                            color: Colors.white,
                            size: 25,
                          ),
                          SizedBox(
                            height: 18,
                          ),
                          Icon(
                            Ionicons.ios_arrow_down,
                            color: Colors.white,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const IconButton(
                onPressed: null,
                icon: Icon(
                  MaterialCommunityIcons.cards_playing_outline,
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(width: 7, color: Colors.white)),
              ),
              const SizedBox(
                width: 15,
              ),
              const IconButton(
                onPressed: null,
                icon: Icon(
                  Entypo.emoji_happy,
                  color: Colors.white,
                  size: 28,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}