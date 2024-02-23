import 'package:am_innn/utils/color.dart';
import 'package:am_innn/utils/styles.dart';
import 'package:am_innn/utils/utils.dart';
import 'package:am_innn/view/search/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search For', style: mediumTS(appBarColor, fontSize: 24)),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .024,
            vertical: Utils.scrHeight * .016),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomSearchBar(hint: 'Search news'),
            SizedBox(height: Utils.scrHeight * .024),
            Text('Categories', style: semiBoldTS(appTextColor, fontSize: 20)),
            SizedBox(height: Utils.scrHeight * .016),
            Expanded(
              child: GridView.count(
                primary: false,
                crossAxisSpacing: Utils.scrHeight * .01,
                mainAxisSpacing: Utils.scrHeight * .01,
                crossAxisCount: 2,
                children: const <Widget>[
                  CustomCategoryItems(title: 'Politics'),
                  CustomCategoryItems(title: 'Health'),
                  CustomCategoryItems(title: 'Stocks'),
                  CustomCategoryItems(title: 'Weather'),
                  CustomCategoryItems(title: 'Crime'),
                  CustomCategoryItems(title: 'shopping'),
                  CustomCategoryItems(title: 'Sports'),
                  CustomCategoryItems(title: 'Entertainment'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CustomCategoryItems extends StatelessWidget {
  const CustomCategoryItems({super.key, required this.title, this.onTap});

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: categoryColor,
            borderRadius: BorderRadius.circular(Utils.scrHeight * .014)),
        child: Text(title, style: semiBoldTS(appThemeColor, fontSize: 14)),
      ),
    );
  }
}
