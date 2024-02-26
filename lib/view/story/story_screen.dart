import 'package:am_innn/route/routes_name.dart';
import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:am_innn/view/story/widgets/share_widgets.dart';
import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  const StoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F5F3),
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pushReplacementNamed(context, RoutesName.home);
        },
          icon: const Icon(Icons.arrow_back,color: Colors.black,),
        ),
        backgroundColor: const Color(0xffF6F5F3),
          title: Text('Back', style: mediumTS(appBarColor, fontSize: 20))),

      // Share Icon Part
      floatingActionButton: Padding(
        padding: EdgeInsets.only(bottom: Utils.scrHeight * .1),
        child: FloatingActionButton(
          shape: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(Utils.scrHeight * .1),
          ),
          onPressed: () {
            getPopUp(
                context,
                    (p0) => ShareWidget(onExit: () {
                  Navigator.pop(p0);
                }));
          },
          child: Container(
            child: Utils.showSvgPicture('share'),

          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Utils.showImage('story')],
      ),
    );
  }

  void getPopUp(
      BuildContext context,
      Widget Function(BuildContext) childBuilder,
      ) {
    showDialog(
        context: context,
        barrierDismissible: true, // Prevent dismissal by tapping outside
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent, // Optional customization
            // insetPadding: EdgeInsets.only(bottom: Utils.scrHeight * .08),
            child: childBuilder(context),
          );
        });
  }
}
