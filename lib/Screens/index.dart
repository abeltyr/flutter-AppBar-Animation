import "package:flutter/material.dart";

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  double imageHeight = 240;
  double idealImageHeight = 240;
  double maxImageHeight = 280;
  double scrollStart = 0;
  bool disappear = false;
  double firstLayerHeight = 400;
  double idealFirstLayerHeight = 400;
  double maxFirstLayerHeight = 450;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFF191919),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [
                    firstLayerHeight > 120 ? 0.5 : 1,
                    1,
                  ],
                  colors: [
                    Color(0xFF674843),
                    Color(0xFF191919),
                  ],
                ),
              ),
              height: firstLayerHeight,
              width: width,
              child: SafeArea(
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                      child: !disappear
                          ? Opacity(
                              opacity: imageHeight / idealImageHeight < 1
                                  ? imageHeight / idealImageHeight
                                  : 1,
                              child: Image.asset(
                                "assets/images/view.png",
                                cacheHeight: 720,
                                cacheWidth: 720,
                                height: imageHeight,
                                fit: BoxFit.contain,
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
              ),
            ),
            SafeArea(
              child: Container(
                margin: EdgeInsets.only(
                    top:
                        firstLayerHeight > 130 ? firstLayerHeight - 130 : 52.5),
                height: height -
                    (firstLayerHeight > 130 ? firstLayerHeight - 130 : 52.5),
                width: width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text("data")],
                ),
              ),
            ),
            Container(
              height: height,
              width: width,
              child: GestureDetector(
                onVerticalDragStart: (DragStartDetails data) {
                  scrollStart = data.globalPosition.dy;
                },
                onVerticalDragUpdate: (DragUpdateDetails data) {
                  // setup the upward motion action
                  if (scrollStart > data.globalPosition.dy) {
                    setState(() {
                      disappear = imageHeight < 140;

                      if (firstLayerHeight > 120)
                        firstLayerHeight = firstLayerHeight -
                            50 *
                                ((scrollStart - data.globalPosition.dy) /
                                    height);
                      if (imageHeight > 140)
                        imageHeight = imageHeight -
                            50 *
                                ((scrollStart - data.globalPosition.dy) /
                                    height);
                    });
                  }
                  // setup the downward motion action
                  else if (scrollStart < data.globalPosition.dy) {
                    print(firstLayerHeight);
                    print(maxFirstLayerHeight);
                    setState(() {
                      if (firstLayerHeight < maxFirstLayerHeight)
                        firstLayerHeight = firstLayerHeight +
                            40 *
                                ((data.globalPosition.dy - scrollStart) /
                                    height);

                      if (firstLayerHeight > imageHeight + 100 &&
                          imageHeight < 300) {
                        disappear = !(imageHeight > 125);
                        imageHeight = imageHeight +
                            40 *
                                ((data.globalPosition.dy - scrollStart) /
                                    height);
                      }
                    });
                  }
                },
                onVerticalDragEnd: (DragEndDetails data) {
                  setState(() {
                    imageHeight = imageHeight > idealImageHeight
                        ? idealImageHeight
                        : imageHeight;
                    firstLayerHeight = firstLayerHeight > idealFirstLayerHeight
                        ? idealFirstLayerHeight
                        : firstLayerHeight;
                  });
                },
              ),
            ),
          ],
        ));
  }
}
