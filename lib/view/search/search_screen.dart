import 'package:am_innnn/common_widgets/email_form_field.dart';
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
  String? selectedCategory;
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
              EmailFormField(
                  emailController: _searchController, hintText: 'Search news', validate: false,),
              SizedBox(height: Utils.scrHeight * .024),
              Text('Categories', style: semiBoldTS(appTextColor, fontSize: 20)),
              SizedBox(height: Utils.scrHeight * .016),
              Expanded(
                child: GridView.builder(
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
                        print(
                            'Selected category: ${Utils.categoriesName[index]}');
                        setState(() {
                          selectedCategory = Utils.categoriesName[index];
                        });
                      },
                      title: Utils.categoriesName[index],
                    );
                  },
                ),
              ),
              ActionButton(
                onTap: () {
                    print('Selected category: $selectedCategory');
                    print('Select search: ${_searchController.text}');
                    // Navigate to next page with selected category
                    Navigator.pushNamed(context, RoutesName.home,
                        arguments:  _searchController.text);
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

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class CustomCategoryItems extends StatelessWidget {
  const CustomCategoryItems({
    Key? key,
    required this.title,
    this.onTap,
    required this.isSelected,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : categoryColor,
          borderRadius: BorderRadius.circular(Utils.scrHeight * .014),
        ),
        child: Text(
          title,
          style: semiBoldTS(
            isSelected ? Colors.white : appThemeColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
