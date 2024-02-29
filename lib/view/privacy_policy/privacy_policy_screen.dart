
import 'package:am_innnn/view/privacy_policy/widgets/custom_rich_text.dart';
import 'package:flutter/material.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Privacy & Policy',
              style: mediumTS(appBarColor, fontSize: 20))),
      body: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .024,
            vertical: Utils.scrHeight * .016),
        children: [
          const CustomRichText(
              title: 'Data Collection: ',
              subtitle:
                  'Details on what types of data are collected from users, which may include personal information such as name, email address, location, and device information.'),
          SizedBox(height: Utils.scrHeight * .012),
          const CustomRichText(
              title: 'Purpose of Data Collection: ',
              subtitle:
                  'Explanation of why the app collects user data, such as to personalize content, improve user experience, or for advertising purposes.'),
          SizedBox(height: Utils.scrHeight * .012),
          const CustomRichText(
              title: 'Third-party Sharing: ',
              subtitle:
                  'Disclosure of whether user data is shared with third-party services or advertisers, and if so, how it is used by these parties.'),
          SizedBox(height: Utils.scrHeight * .012),
          const CustomRichText(
              title: 'Data Security: ',
              subtitle:
                  'Assurance of measures taken to safeguard user data from unauthorized access, such as encryption and secure storage practices.'),
          SizedBox(height: Utils.scrHeight * .012),
          const CustomRichText(
              title: 'User Rights: ',
              subtitle:
                  'Explanation of user rights regarding their data, including the ability to access, modify, or delete their information.'),
          SizedBox(height: Utils.scrHeight * .012),
          const CustomRichText(
              title: 'Opt-Out Options: ',
              subtitle:
                  'Information on how users can opt out of certain data collection or sharing practices, such as through app settings or contacting the app developer.'),
          SizedBox(height: Utils.scrHeight * .012),
          const CustomRichText(
              title: 'Updates to Policy: ',
              subtitle:
                  'Notification of how users will be informed of any changes to the privacy policy, and their consent to these changes.'),
          SizedBox(height: Utils.scrHeight * .012),
          const CustomRichText(
              title: 'Legal Compliance: ',
              subtitle:
                  'Assurance that the app complies with relevant privacy laws and regulations, such as GDPR or CCPA.'),
          SizedBox(height: Utils.scrHeight * .024),
          Text(
              'Overall, the privacy policy serves to inform users about their privacy rights and how their data is handled within the news portal mobile app, promoting transparency and trust between the app provider and its users.',
              style: regularTS(homeTabTextColor, fontSize: 14)),
          SizedBox(height: Utils.scrHeight * .1),
        ],
      ),
    );
  }
}
