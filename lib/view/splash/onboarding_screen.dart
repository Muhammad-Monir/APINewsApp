import 'dart:developer';

import 'package:am_innnn/common_widgets/country_dropdown.dart';
import 'package:am_innnn/common_widgets/language_dropdown.dart';
import 'package:am_innnn/data/user_data.dart';
import 'package:am_innnn/provider/country_provider.dart';
import 'package:am_innnn/provider/language_provider.dart';
import 'package:am_innnn/provider/news_provider.dart';
import 'package:am_innnn/provider/story_provider.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:am_innnn/utils/toast_util.dart';
import 'package:am_innnn/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../common_widgets/action_button.dart';
import '../../route/routes_name.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  void initState() {
    initialSetData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bool isFirstTime = appData.read(kKeyIsFirstTime);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF4F9F9),
        automaticallyImplyLeading: isFirstTime ? false : true,
      ),
      backgroundColor: const Color(0xFFF4F9F9),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Utils.scrHeight * .056),
              Center(child: Image.asset('assets/images/map.png')),
              SizedBox(height: Utils.scrHeight * .023),
              const Text(
                'Which Country and Language You',
              ),
              const Text(
                'Prefer to News in?',
              ),
              SizedBox(height: Utils.scrHeight * .028),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: CountryDropDown(),
              ),
              SizedBox(height: Utils.scrHeight * .016),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.0),
                child: LanguageDropDown(),
              ),
              SizedBox(height: Utils.scrHeight * .033),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28.0),
                child: ActionButton(
                  buttonName: 'Next',
                  buttonColor: Colors.blue,
                  onTap: () {
                    final selectedCountry =
                        Provider.of<CountryProvider>(context, listen: false)
                            .selectedCountry;
                    final selectedLanguage =
                        Provider.of<LanguageProvider>(context, listen: false)
                            .selectedLanguage;

                    if (selectedCountry == null || selectedLanguage == null) {
                      log('not selected');
                      ToastUtil.showShortToast('Select Country & Laguage');
                    } else {
                      log('selected');
                      appData.write(kKeyIsFirstTime, false);
                      if (appData.read(kKeyIsLoggedIn)) {
                        UserData.addCountryLanguage(
                                selectedCountry.id!, selectedLanguage.id!)
                            .then((value) {
                          navigateToHome(context);
                        });
                      } else {
                        navigateToHome(context);
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToHome(BuildContext context) {
    if (Provider.of<NewsProvider>(context, listen: false).newes.isNotEmpty) {
      clearAllData(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.home,
        (route) => false,
      );
    } else {
      clearAllData(context);
      Navigator.pushNamedAndRemoveUntil(
        context,
        RoutesName.home,
        (route) => false,
      );
    }
  }

  void clearAllData(BuildContext context) {
    Provider.of<NewsProvider>(context, listen: false).clearList();
    // Provider.of<BookmarkProvider>(context, listen: false).clearList();
    Provider.of<StoryProvider>(context, listen: false).clearList();
  }

  void initialSetData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LanguageProvider>(context, listen: false)
          .initializeSelectedLanguage();
      Provider.of<CountryProvider>(context, listen: false)
          .initializeSelectedCountry();
    });
  }
}
