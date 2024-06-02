// ignore_for_file: unused_local_variable

import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/language_model.dart';
import '../provider/dropdown_provider.dart';
import '../utils/color.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';

class MyDropDown extends StatelessWidget {
  const MyDropDown({super.key});

  @override
  Widget build(final BuildContext context) {
    String selectedValue = appData.read(kKeyLanguageName);
    int selectedId = appData.read(kKeyLanguageId);
    return Consumer<LanguageProvider>(
      builder: (context, languageProvider, child) {
        if (languageProvider.isLoading) {
          return const SizedBox.shrink();
        } else if (languageProvider.errorMessage != null) {
          return Text('Error: ${languageProvider.errorMessage}');
        } else if (languageProvider.languages == null ||
            languageProvider.languages!.isEmpty) {
          return const Text('No data found');
        } else {
          return DropdownButton<LanguageData>(
            isExpanded: true,
            underline: Container(),
            hint: Text(selectedValue, style: mediumTS(homeTabTextColor)),
            icon: Image.asset(
              'assets/icons/image.png',
              width: Utils.scrHeight * .03,
            ),
            value: languageProvider.selectedLanguage,
            onChanged: (LanguageData? newValue) {
              languageProvider.setSelectedLanguage(newValue);
              appData.write(kKeyLanguageCode, newValue!.code);
              appData.write(kKeyLanguageName, newValue.name);
              appData.write(kKeyLanguageId, newValue.id);
            },
            items: languageProvider.languages!
                .map<DropdownMenuItem<LanguageData>>((LanguageData language) {
              return DropdownMenuItem<LanguageData>(
                value: language,
                child: Text(language.name!, style: mediumTS(homeTabTextColor)),
              );
            }).toList(),
          );
        }
      },
    );
  }
}





// import 'package:flutter/material.dart';
// import '../data/news_data.dart';
// import '../model/language_model.dart';
// import '../utils/color.dart';
// import '../utils/styles.dart';
// import '../utils/utils.dart';

// class MyDropDown extends StatefulWidget {
//   const MyDropDown({super.key});

//   @override
//   _MyDropDownState createState() => _MyDropDownState();
// }

// class _MyDropDownState extends State<MyDropDown> {
//   LanguageData? selectedLanguage;

//   @override
//   Widget build(final BuildContext context) {
//     return FutureBuilder<LanguageModel>(
//       future: NewsData.getAllLanguage(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const SizedBox.shrink();
//         } else if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         } else if (!snapshot.hasData || snapshot.data == null) {
//           return const Text('No data found');
//         } else {
//           final List<LanguageData> languages = snapshot.data!.data!;

//           return Padding(
//             padding: EdgeInsets.all(Utils.scrHeight * .012),
//             child: DropdownButton<LanguageData>(
//               isExpanded: true,
//               underline: Container(),
//               hint: Text("Select Language", style: mediumTS(homeTabTextColor)),
//               icon: Image.asset(
//                 'assets/icons/image.png',
//                 width: Utils.scrHeight * .03,
//               ),
//               value: selectedLanguage,
//               onChanged: (LanguageData? newValue) {
//                 setState(() {
//                   selectedLanguage = newValue;
//                 });
//               },
//               items: languages
//                   .map<DropdownMenuItem<LanguageData>>((LanguageData language) {
//                 return DropdownMenuItem<LanguageData>(
//                   value: language,
//                   child:
//                       Text(language.code!, style: mediumTS(homeTabTextColor)),
//                 );
//               }).toList(),
//             ),
//           );
//         }
//       },
//     );
//   }
// }

