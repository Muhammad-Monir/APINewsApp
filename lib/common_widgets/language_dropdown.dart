// ignore_for_file: unused_local_variable

import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../model/language_model.dart';
import '../provider/language_provider.dart';
import '../utils/color.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';

class LanguageDropDown extends StatefulWidget {
  const LanguageDropDown({
    super.key,
  });

  @override
  State<LanguageDropDown> createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.scrHeight * .06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Utils.scrHeight * .012),
          border: Border.all(color: Colors.grey)),
      child: Consumer<LanguageProvider>(builder: (context, provider, child) {
        return !provider.isLoading
            ? DropdownButtonHideUnderline(
                child: DropdownButton2<LanguageData>(
                    isExpanded: true,
                    hint: Text(
                      'Select Your Language',
                      style: regularTS(appBarColor, fontSize: 14.sp),
                    ),
                    // DropDownItem Showing
                    items: provider.languages?.map((LanguageData laguage) {
                      return DropdownMenuItem<LanguageData>(
                        value: laguage,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: Utils.scrHeight * .008),
                          child: Text(
                            laguage.name ?? '',
                            style: mediumTS(appTextColor),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }).toList(),
                    value: provider.languages!.first,
                    onChanged: (LanguageData? newValue) {
                      provider.setSelectedLanguage(newValue);
                      appData.write(kKeyLanguageCode, newValue!.code);
                      appData.write(kKeyLanguageName, newValue.name);
                      appData.write(kKeyLanguageId, newValue.id);
                    },

                    //DropDown Button Style
                    buttonStyleData: ButtonStyleData(
                      padding: EdgeInsets.symmetric(
                          horizontal: Utils.scrHeight * .016),
                      height: Utils.scrHeight * .040,
                      // width: Utils.scrHeight * .040,
                    ),
                    dropdownStyleData: DropdownStyleData(
                      direction: DropdownDirection.left,
                      maxHeight: Utils.scrHeight * .5,
                      width: Utils.scrHeight * .350,
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(Utils.scrHeight * .015),
                      ),
                    ),
                    menuItemStyleData: MenuItemStyleData(
                      padding: EdgeInsets.symmetric(
                          horizontal: Utils.scrHeight * .008),
                    ),
                    iconStyleData: const IconStyleData(
                      openMenuIcon: Icon(Icons.arrow_drop_up),
                    ),
                    dropdownSearchData: DropdownSearchData(
                      searchController: textEditingController,
                      searchInnerWidgetHeight: 50,
                      searchInnerWidget: Container(
                        height: 50,
                        padding: const EdgeInsets.only(
                          top: 8,
                          bottom: 4,
                          right: 8,
                          left: 8,
                        ),
                        child: TextFormField(
                          expands: true,
                          maxLines: null,
                          controller: textEditingController,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 8,
                            ),
                            hintText: 'Search for an item...',
                            hintStyle: TextStyle(fontSize: 12.sp),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      searchMatchFn: (item, searchValue) {
                        return item.value!.name!
                            .toLowerCase()
                            .contains(searchValue.toLowerCase());
                      },
                    ),
                    //This to clear the search value when you close the menu
                    onMenuStateChange: (isOpen) {
                      if (!isOpen) {
                        textEditingController.clear();
                      }
                    }),
              )
            : const SizedBox(
                width: double.infinity,
                child: Center(child: CircularProgressIndicator()));
      }),
    );
  }
}

// class LanguageDropDown extends StatelessWidget {
//   const LanguageDropDown({super.key});

//   @override
//   Widget build(final BuildContext context) {
//     // String selectedValue = appData.read(kKeyLanguageName);
//     // int selectedId = appData.read(kKeyLanguageId);
//     // String? selectedValue;
//     // int? selectedId;
//     return Consumer<LanguageProvider>(
//       builder: (context, languageProvider, child) {
//         if (languageProvider.isLoading) {
//           return const SizedBox.shrink();
//         } else if (languageProvider.errorMessage != null) {
//           return Text('Error: ${languageProvider.errorMessage}');
//         } else if (languageProvider.languages == null ||
//             languageProvider.languages!.isEmpty) {
//           return const Text('No data found');
//         } else {
//           return DropdownButton<LanguageData>(
//             isExpanded: true,
//             underline: Container(),
//             hint:
//                 Text('Select Your Laguage', style: mediumTS(homeTabTextColor)),
//             icon: Image.asset(
//               'assets/icons/image.png',
//               width: Utils.scrHeight * .03,
//             ),
//             value: languageProvider.selectedLanguage,
//             onChanged: (LanguageData? newValue) {
//               languageProvider.setSelectedLanguage(newValue);
//               appData.write(kKeyLanguageCode, newValue!.code);
//               appData.write(kKeyLanguageName, newValue.name);
//               appData.write(kKeyLanguageId, newValue.id);
//             },
//             items: languageProvider.languages!
//                 .map<DropdownMenuItem<LanguageData>>((LanguageData language) {
//               return DropdownMenuItem<LanguageData>(
//                 value: language,
//                 child: Text(language.name!, style: mediumTS(homeTabTextColor)),
//               );
//             }).toList(),
//           );
//         }
//       },
//     );
//   }
// }





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

