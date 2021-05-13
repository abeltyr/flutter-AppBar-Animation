import "package:flutter/material.dart";

class IndexScreen extends StatefulWidget {
  @override
  _IndexScreenState createState() => _IndexScreenState();
}

class _IndexScreenState extends State<IndexScreen> {
  double scrollStart = 0;
  double firstLayerHeight = 400;
  double idealFirstLayerHeight = 400;
  double maxFirstLayerHeight = 450;
  bool showtitle = false;
  bool otherScroll = false;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Color(0xFF191919),
        body: Stack(
          children: [
            Container(
              height: firstLayerHeight,
              width: width,
              child: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [
                            firstLayerHeight > 150 ? 0.5 : 1,
                            1,
                          ],
                          colors: [
                            Color(0xFF674843),
                            Color(0xFF191919),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(
                          top: 20, bottom: firstLayerHeight > 150 ? 50 : 15),
                      child: Stack(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 20),
                            alignment: Alignment.topLeft,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          Container(
                              alignment: Alignment.topCenter,
                              child: firstLayerHeight > 260
                                  ? Opacity(
                                      opacity: firstLayerHeight / 240 < 1
                                          ? firstLayerHeight / 240
                                          : 1,
                                      child: Image.asset(
                                        "assets/images/view.png",
                                        cacheHeight: 720,
                                        cacheWidth: 720,
                                        fit: BoxFit.contain,
                                      ),
                                    )
                                  : Text(
                                      "Data",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    )),
                        ],
                      ),
                    ),
                  ],
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
                      if (firstLayerHeight > 135)
                        firstLayerHeight = firstLayerHeight -
                            50 *
                                ((scrollStart - data.globalPosition.dy) /
                                    height);

                      otherScroll = firstLayerHeight <= 136;
                    });
                  }
                  // setup the downward motion action
                  else if (scrollStart < data.globalPosition.dy) {
                    setState(() {
                      if (firstLayerHeight < maxFirstLayerHeight)
                        firstLayerHeight = firstLayerHeight +
                            40 *
                                ((data.globalPosition.dy - scrollStart) /
                                    height);
                    });
                  }
                },
                onVerticalDragEnd: (DragEndDetails data) {
                  setState(() {
                    firstLayerHeight = firstLayerHeight > idealFirstLayerHeight
                        ? idealFirstLayerHeight
                        : firstLayerHeight;
                  });
                },
                child: SafeArea(
                  child: Container(
                    height: height,
                    padding: EdgeInsets.only(
                        top: firstLayerHeight > 55
                            ? firstLayerHeight - 55
                            : 52.5),
                    width: width,
                    child: NotificationListener<ScrollEndNotification>(
                      onNotification: (scrollEnd) {
                        var metrics = scrollEnd.metrics;
                        if (metrics.atEdge) {
                          if (metrics.pixels == 0) {
                            // print('At top');
                            setState(() {
                              otherScroll = false;
                            });
                          }
                          // print('At bottom');
                        }
                        return true;
                      },
                      child: ListView(
                        physics: otherScroll
                            ? AlwaysScrollableScrollPhysics()
                            : NeverScrollableScrollPhysics(),
                        children: [
                          Text(
                            "Data",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            height: 400,
                            width: width,
                          ),
                          Text(
                            "Data",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Container(
                            height: 400,
                            width: width,
                          ),
                          Text(
                            "Data",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
