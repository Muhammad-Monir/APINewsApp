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

class CountryDropDown extends StatefulWidget {
  const CountryDropDown({
    super.key,
  });

  @override
  State<CountryDropDown> createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  final TextEditingController textEditingController = TextEditingController();
  final isLogin = appData.read(kKeyIsLoggedIn);

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
                    padding: EdgeInsets.symmetric(
                        horizontal: Utils.scrHeight * .008),
                    child: Text(
                      country.name!,
                      style: mediumTS(appTextColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
              // value: countryData,
              value: provider.selectedCountry,
              onChanged: (CountryData? newValue) {
                provider.setSelectedCountry(newValue);
                appData.write(kKeyCountryCode, newValue!.code);
                appData.write(kKeyCountryName, newValue.name);
                appData.write(kKeyCountryId, newValue.id);
              },

              //DropDown Button Style
              buttonStyleData: ButtonStyleData(
                padding:
                    EdgeInsets.symmetric(horizontal: Utils.scrHeight * .016),
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
                padding:
                    EdgeInsets.symmetric(horizontal: Utils.scrHeight * .008),
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
                      hintStyle: const TextStyle(fontSize: 12),
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
        );
      }),
    );
  }
}
