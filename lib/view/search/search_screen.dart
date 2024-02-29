//
// import 'package:am_innnn/view/search/widgets/custom_search_bar.dart';
// import 'package:flutter/material.dart';
// import '../../common_widgets/action_button.dart';
// import '../../route/routes_name.dart';
// import '../../utils/color.dart';
// import '../../utils/styles.dart';
// import '../../utils/utils.dart';
//
// class SearchScreen extends StatefulWidget {
//   const SearchScreen({super.key});
//
//   @override
//   State<SearchScreen> createState() => _SearchScreenState();
// }
//
// class _SearchScreenState extends State<SearchScreen> {
//
//   bool isSelected = false;
//   int selectedIndex = -1;
//   String selectedCategory = '';
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Search For', style: mediumTS(appBarColor, fontSize: 24)),
//       ),
//       body: Padding(
//         padding: EdgeInsets.symmetric(
//             horizontal: Utils.scrHeight * .024,
//             vertical: Utils.scrHeight * .016),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const CustomSearchBar(hint: 'Search news'),
//             SizedBox(height: Utils.scrHeight * .024),
//             Text('Categories', style: semiBoldTS(appTextColor, fontSize: 20)),
//             SizedBox(height: Utils.scrHeight * .016),
//             Expanded(
//               child:
//               GridView.builder(
//                 primary: false,
//                 padding: EdgeInsets.all(Utils.scrHeight * .014),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisSpacing: Utils.scrHeight * .014,
//                   mainAxisSpacing: Utils.scrHeight * .014,
//                   crossAxisCount: 2,
//                   childAspectRatio: 1.5,
//                 ),
//                 itemCount: Utils.categoriesName.length,
//                 itemBuilder: (BuildContext context, int index) {
//                   return CustomCategoryItems(
//                       isSelected: index == selectedIndex,
//                       onTap: () {
//                         setState(() {
//                           selectedIndex = index;
//                           selectedCategory = Utils.categoriesName[index];
//                           print(selectedCategory);
//                         });
//                       },title: Utils.categoriesName[index]);
//                 },
//               )
//
//               // GridView.count(
//               //   primary: false,
//               //   crossAxisSpacing: Utils.scrHeight * .014,
//               //   mainAxisSpacing: Utils.scrHeight * .014,
//               //   crossAxisCount: 2,
//               //   childAspectRatio: 1.5,
//               //   children: <Widget>[
//               //     CustomCategoryItems(title: 'Politics',isSelected: isSelected,),
//               //     CustomCategoryItems(title: 'Health',isSelected: isSelected),
//               //     CustomCategoryItems(title: 'Stocks',isSelected: isSelected),
//               //     CustomCategoryItems(title: 'Weather',isSelected: isSelected),
//               //     CustomCategoryItems(title: 'Crime',isSelected: isSelected),
//               //     CustomCategoryItems(title: 'shopping',isSelected: isSelected),
//               //     CustomCategoryItems(title: 'Sports',isSelected: isSelected),
//               //     CustomCategoryItems(title: 'Entertainment',isSelected: isSelected),
//               //   ],
//               // ),
//             ),
//             ActionButton(
//               onTap: () {
//                 print(selectedCategory);
//                 Navigator.pushNamed(context, RoutesName.home,arguments: [selectedCategory]);
//               },
//               buttonColor: appThemeColor,
//               textColor: Colors.white,
//               buttonName: 'Save & Continue',
//             ),
//             SizedBox(
//               height: Utils.scrHeight * .04,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class CustomCategoryItems extends StatelessWidget {
//   const CustomCategoryItems({super.key, required this.title, this.onTap, required this.isSelected});
//
//   final String title;
//   final VoidCallback? onTap;
//   final bool isSelected;
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//             color: isSelected ? Colors.blue : categoryColor,
//             borderRadius: BorderRadius.circular(Utils.scrHeight * .014)),
//         child: Text(title, style: semiBoldTS(isSelected ? Colors.white : appThemeColor, fontSize: 14)),
//       ),
//     );
//   }
// }
import 'package:am_innnn/view/search/widgets/custom_search_bar.dart';
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
  List<String> selectedCategories = [];

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSearchBar(hint: 'Search news'),
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
                    isSelected: selectedCategories.contains(Utils.categoriesName[index]),
                    onTap: () {
                      print('send argument : $selectedCategories');
                      setState(() {
                        if (selectedCategories.contains(Utils.categoriesName[index])) {
                          selectedCategories.remove(Utils.categoriesName[index]);
                        } else {
                          selectedCategories.add(Utils.categoriesName[index]);
                        }
                      });
                    },
                    title: Utils.categoriesName[index],
                  );
                },
              ),
            ),
            ActionButton(
              onTap: () {
                print('send argument : $selectedCategories');
                // Navigate to next page with selected categories
                Navigator.pushNamed(context, RoutesName.home, arguments: selectedCategories);
              },
              buttonColor: appThemeColor,
              textColor: Colors.white,
              buttonName: 'Save & Continue',
            ),
            SizedBox(height: Utils.scrHeight * .04),
          ],
        ),
      ),
    );
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
