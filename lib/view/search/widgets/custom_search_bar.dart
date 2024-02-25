import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/drop_down_provider.dart';
import '../../../utils/color.dart';
import '../../../utils/styles.dart';
import '../../../utils/utils.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.hint,
  });

  final String hint;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Utils.scrHeight * .06,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Utils.scrHeight * .012),
          border: Border.all(color: tabBarDividerColor)),
      child: Consumer<DropDownProvider>(builder: (context, provider, child) {
        return DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: Text(hint,
                style: regularTS(const Color(0xffC7CBD1), fontSize: 14)),

            // DropDownItem Showing
            items: provider.serviceTypesList?.map((String service) {
              return DropdownMenuItem<String>(
                value: service,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: Utils.scrHeight * .008),
                  child: Text(
                    service,
                    style: mediumTS(homeTabTextColor, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }).toList(),
            value: provider.selectedServiceType,
            onChanged: (String? value) {
              provider.setSelectedServiceType(value);
            },

            //DropDown Button Style
            buttonStyleData: ButtonStyleData(
                padding:
                    EdgeInsets.symmetric(horizontal: Utils.scrHeight * .016),
                height: Utils.scrHeight * .040,
                elevation: 0),
            dropdownStyleData: DropdownStyleData(
              elevation: 0,
              direction: DropdownDirection.left,
              maxHeight: Utils.scrHeight * .35,
              width: Utils.scrHeight * .250,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Utils.scrHeight * .015),
              ),
            ),
            menuItemStyleData: MenuItemStyleData(
                padding:
                    EdgeInsets.symmetric(horizontal: Utils.scrHeight * .008)),
            iconStyleData:
                const IconStyleData(openMenuIcon: Icon(Icons.arrow_drop_up)),
            barrierColor: Colors.transparent,
          ),
        );
      }),
    );
  }
}
