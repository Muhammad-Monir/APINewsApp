// ignore_for_file: unused_local_variable
import 'package:am_innnn/model/country_model.dart';
import 'package:am_innnn/provider/country_provider.dart';
import 'package:am_innnn/utils/app_constants.dart';
import 'package:am_innnn/utils/di.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/color.dart';
import '../utils/styles.dart';
import '../utils/utils.dart';

class CountryDropDown extends StatelessWidget {
  const CountryDropDown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.scrHeight * .06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Utils.scrHeight * .012),
          border: Border.all(color: Colors.grey)),
      child: Consumer<CountryProvider>(builder: (context, provider, child) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<CountryData>(
            isExpanded: true,
            hint: Text(
              'Select Your Country',
              style: regularTS(appBarColor, fontSize: 14),
            ),
            // DropDownItem Showing
            items: provider.countries?.map((CountryData country) {
              return DropdownMenuItem<CountryData>(
                value: country,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Utils.scrHeight * .008),
                  child: Text(
                    country.name!,
                    style: mediumTS(appTextColor),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
            value: provider.selectedCountry,
            onChanged: (CountryData? newValue) {
              provider.setSelectedCountry(newValue);
              appData.writeIfNull(kKeyCountryCode, newValue!.code);
              appData.writeIfNull(kKeyCountryName, newValue.name);
              appData.writeIfNull(kKeyCountryId, newValue.id);
            },

            //DropDown Button Style
            buttonStyleData: ButtonStyleData(
              padding: EdgeInsets.symmetric(horizontal: Utils.scrHeight * .016),
              height: Utils.scrHeight * .040,
              // width: Utils.scrHeight * .040,
            ),
            dropdownStyleData: DropdownStyleData(
              direction: DropdownDirection.left,
              maxHeight: Utils.scrHeight * .5,
              width: Utils.scrHeight * .350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Utils.scrHeight * .015),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
              padding: EdgeInsets.symmetric(horizontal: Utils.scrHeight * .008),
            ),
            iconStyleData: const IconStyleData(
              openMenuIcon: Icon(Icons.arrow_drop_up),
            ),
          ),
        );
      }),
    );
  }
}


// class CountryDropDown extends StatelessWidget {
//   const CountryDropDown({super.key});

//   @override
//   Widget build(final BuildContext context) {
//     // String selectedValue = appData.read(kKeyLanguageName);
//     // int selectedId = appData.read(kKeyLanguageId);
//     // String? selectedValue;
//     // int? selectedId;
//     return Consumer<CountryProvider>(
//       builder: (context, provider, child) {
//         if (provider.isLoading) {
//           return const SizedBox.shrink();
//         } else if (provider.errorMessage != null) {
//           return Text('Error: ${provider.errorMessage}');
//         } else if (provider.countries == null || provider.countries!.isEmpty) {
//           return const Text('No data found');
//         } else {
//           return DropdownButton<CountryData>(
//             isExpanded: true,
//             underline: Container(),
//             hint:
//                 Text('Select Your Country', style: mediumTS(homeTabTextColor)),
//             icon: Image.asset(
//               'assets/icons/image.png',
//               width: Utils.scrHeight * .03,
//             ),
//             value: provider.selectedCountry,
//             onChanged: (CountryData? newValue) {
//               provider.setSelectedCountry(newValue);
//               appData.writeIfNull(kKeyCountryCode, newValue!.code);
//               appData.writeIfNull(kKeyCountryName, newValue.name);
//               appData.writeIfNull(kKeyCountryId, newValue.id);
//             },
//             items: provider.countries!
//                 .map<DropdownMenuItem<CountryData>>((CountryData country) {
//               return DropdownMenuItem<CountryData>(
//                 value: country,
//                 child: SizedBox(
//                     width: 100,
//                     child:
//                         Text(country.name!, style: mediumTS(homeTabTextColor))),
//               );
//             }).toList(),
//           );
//         }
//       },
//     );
//   }
// }
