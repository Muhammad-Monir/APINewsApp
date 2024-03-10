import 'package:flutter/material.dart';

import 'custom_vertical_flip_page_turn.dart';

class CustomFlipWidget extends StatefulWidget {
  final List<Widget> pages;
  const CustomFlipWidget({super.key, required this.pages});

  @override
  State<CustomFlipWidget> createState() => _CustomFlipWidgetState();
}

class _CustomFlipWidgetState extends State<CustomFlipWidget> {

  PageController controller = PageController();
  int page = 0;
  CustomVerticalFlipPageTurnController turnController= CustomVerticalFlipPageTurnController();
  @override
  void initState() {
    // TODO: implement initState
    controller.addListener(() {
      //log('viewport- ${controller.viewportFraction} | page-${controller.page}');
      //log('page- ${controller.page} | offset-${controller.offset}');
      turnController.animCustom( controller.page??0 ,(controller.page??0).toInt());

    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            color: Colors.yellow,
            child: Padding(
              padding: EdgeInsets.all(0),
              child: LayoutBuilder(builder: (context, constraints) {
                return CustomVerticalFlipPageTurn(
                    children: widget.pages.map((e) => e).toList(),
                cellSize: Size(constraints.maxWidth, constraints.maxHeight),
                controller: turnController,
                );
              }),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 0,
            child: PageView(
              controller: controller,
              scrollDirection: Axis.vertical,
              onPageChanged: (index){
                page =index;
              },
              children: widget.pages.map((e) => Container(color: Colors.transparent,)).toList(),
            ),
          ),


        ],
      ),
    );
  }
}
