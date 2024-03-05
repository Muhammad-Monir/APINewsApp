import 'dart:developer';
import 'package:am_innnn/common_widgets/email_form_field.dart';
import 'package:am_innnn/view/search/widgets/category_item.dart';
import 'package:flutter/material.dart';
import '../../common_widgets/action_button.dart';
import '../../route/routes_name.dart';
import '../../utils/color.dart';
import '../../utils/styles.dart';
import '../../utils/utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? selectedCategory = '';
  final _searchController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search For', style: mediumTS(appBarColor, fontSize: 24)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Utils.scrHeight * .024,
          vertical: Utils.scrHeight * .016,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Filed for search by title
              EmailFormField(
                  emailController: _searchController, hintText: 'Search news', validate: false,),
              SizedBox(height: Utils.scrHeight * .024),
              Text('Categories', style: semiBoldTS(appTextColor, fontSize: 20)),
              SizedBox(height: Utils.scrHeight * .016),

              // Select Category for search by category
              Expanded(
                child: selectCategorySection(),
              ),

              // Search button
              ActionButton(
                onTap: () {
                    log('Selected category: $selectedCategory');
                    log('Select search: ${_searchController.text}');
                    Map<String, dynamic> filter = {
                      'selectedCategory': selectedCategory,
                      'searchText': _searchController.text,
                    };
                    log('Select search: $filter');
                    // Navigate to next page with selected category
                    Navigator.pushNamed(context, RoutesName.home,
                        arguments:  filter);
                },
                buttonColor: appThemeColor,
                textColor: Colors.white,
                buttonName: 'Save & Continue',
              ),
              SizedBox(height: Utils.scrHeight * .04),
            ],
          ),
        ),
      ),
    );
  }

  GridView selectCategorySection() {
    return GridView.builder(
                primary: false,
                padding: EdgeInsets.all(Utils.scrHeight * .014),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: Utils.scrHeight * .014,
                  mainAxisSpacing: Utils.scrHeight * .014,
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                ),
                itemCount: Utils.categoriesName.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomCategoryItems(
                    isSelected: selectedCategory == Utils.categoriesName[index],
                    onTap: () {
                      log(
                          'Selected category: ${Utils.categoriesName[index]}');
                      setState(() {
                        selectedCategory = Utils.categoriesName[index];
                      });
                    },
                    title: Utils.categoriesName[index],
                  );
                },
              );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}


