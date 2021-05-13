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
  ScrollController _controller;
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    super.initState();
  }

  _scrollListener() {
    if (_controller.offset < 0) {
      print(_controller.offset);
      setState(() {
        otherScroll = false;
        double offSetData = 0;
        if (_controller.offset < 0) offSetData = _controller.offset * -1;
        print(offSetData / 10);
        firstLayerHeight = 150 + 30 * (offSetData / 10);
      });
    }
  }

  // _moveUp() {
  //   // _controller.jumpTo(pixelsToMove);
  //   _controller.animateTo(
  //       _controller.offset - MediaQuery.of(context).size.height,
  //       curve: Curves.linear,
  //       duration: Duration(milliseconds: 500));
  // }

  // _moveDown() {
  //   _controller.animateTo(
  //       _controller.offset + MediaQuery.of(context).size.height,
  //       curve: Curves.linear,
  //       duration: Duration(milliseconds: 500));
  // }

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
                    child: SafeArea(
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
                  ),
                ],
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
                    child: ListView(
                      physics: otherScroll
                          ? BouncingScrollPhysics()
                          : NeverScrollableScrollPhysics(),
                      controller: _controller,
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
          ],
        ));
  }
}
