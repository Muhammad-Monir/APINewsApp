import 'package:am_innn/common_widgets/action_button.dart';
import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:am_innn/view/feedback/widgets/custom_welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _feedbackController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Feedback', style: mediumTS(appBarColor, fontSize: 24))),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .024,
            vertical: Utils.scrHeight * .024),
        children: [
          Text('How did we do', style: regularTS(feedbackColor, fontSize: 16)),
          SizedBox(height: Utils.scrHeight * .02),

          // Rating Bar Part
          _buildRatingBar(),
          SizedBox(height: Utils.scrHeight * .04),

          // Feedback Part
          _buildFeedbackPart(),

          // Feedback Button
          ActionButton(
            onTap: () {
              getPopUp(
                  context,
                  (p0) => const CustomWelcomeScreen(
                        title: 'Thank you!',
                        description:
                            'By making your voice heard, you help us improve\n"API News App"',
                      ));
            },
            buttonColor: appThemeColor,
            buttonName: 'Send Feedback',
          ),
        ],
      ),
    );
  }

  Column _buildFeedbackPart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Care to share more about it?',
            style: regularTS(feedbackColor, fontSize: 16)),
        SizedBox(height: Utils.scrHeight * .01),
        TextField(
            controller: _feedbackController,
            maxLines: 8,
            decoration: _buildInputDecoration()),
        SizedBox(height: Utils.scrHeight * .05)
      ],
    );
  }

  Row _buildRatingBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //   RatingBar(
        //   initialRating: 3,
        //   direction: Axis.horizontal,
        //   allowHalfRating: true,
        //   itemCount: 5,
        //   ratingWidget: RatingWidget(
        //     full: _image('assets/heart.png'),
        //     half: _image('assets/heart_half.png'),
        //     empty: _image('assets/heart_border.png'),
        //   ),
        //   itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        //   onRatingUpdate: (rating) {
        //     print(rating);
        //   },
        // ),
        RatingBar.builder(
          onRatingUpdate: (rating) {
            print(rating);
          },
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(
                  right: Utils.scrHeight * .02, left: Utils.scrHeight * .02),
              child: Icon(
                Icons.star,
                color: appThemeColor,
                size: Utils.scrHeight * .08,
              ),
            );
          },
          glow: false,
          itemSize: Utils.scrHeight * 0.08,
          allowHalfRating: true,
          // minRating: 1.5,
          itemCount: 5,
        ),
      ],
    );
  }

  @override
  void dispose() {
    _feedbackController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration() {
    return InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            vertical: Utils.scrHeight * .02, horizontal: Utils.scrHeight * .02),
        hintText: 'Your feedback here',
        hintStyle: regularTS(formHintColor, fontSize: 14),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Utils.scrHeight * .016),
            borderSide: BorderSide(
                color: const Color(0x20549333), width: Utils.scrHeight * .001)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(Utils.scrHeight * .016),
            borderSide: BorderSide(
                color: const Color(0x20549333),
                width: Utils.scrHeight * .001)));
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
