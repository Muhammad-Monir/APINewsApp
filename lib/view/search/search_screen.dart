import 'dart:async';
import 'dart:developer';
import 'package:am_innnn/common_widgets/email_form_field.dart';
import 'package:am_innnn/data/news_data.dart';
import 'package:am_innnn/data/search_data.dart';
import 'package:am_innnn/model/category_model.dart';
import 'package:am_innnn/model/news_model.dart';
import 'package:am_innnn/route/routes_name.dart';
import 'package:am_innnn/view/search/widgets/category_item.dart';
import 'package:am_innnn/view/search/widgets/news_details_screen.dart';
import 'package:am_innnn/view/search/widgets/search_list.dart';
import 'package:flutter/material.dart';
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

  SearchDataStream searchDataStream = SearchDataStream();
  StreamSubscription? _searchSubscription;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the search text field
    _searchController.text.isEmpty
        ? searchDataStream.fetchSearchStream('')
        : _searchController.addListener(_onSearchTextChanged);
    _searchController.addListener(_onSearchTextChanged);
    // _searchSubscription = _searchController.addListener(_onSearchTextChanged);
  }

  @override
  void dispose() {
    _searchSubscription
        ?.cancel(); // Cancel the subscription when disposing the widget
    _searchController.dispose();
    super.dispose();
  }

  // Function to handle search text changes
  void _onSearchTextChanged() {
    final searchText = _searchController.text;
    log('Search text changed: $searchText');
    searchDataStream.fetchSearchStream(searchText);
  }

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
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Filed for search by title
              EmailFormField(
                emailController: _searchController,
                hintText: 'Search news',
                validate: false,
              ),
              SizedBox(height: Utils.scrHeight * .024),
              Text('Categories', style: semiBoldTS(appTextColor, fontSize: 20)),
              SizedBox(height: Utils.scrHeight * .016),

              // Select Category for search by category
              SizedBox(
                height: Utils.scrHeight * .62,
                child: selectCategorySection(),
              ),

              // Search button
              // ActionButton(
              //   onTap: () {
              //     log('Selected category: $selectedCategory');
              //     log('Select search: ${_searchController.text}');
              //     Map<String, dynamic> filter = {
              //       'selectedCategory': selectedCategory,
              //       'searchText': _searchController.text,
              //     };
              //     log('Select search: $filter');
              //     // Navigate to next page with selected category
              //     Navigator.pushNamed(context, RoutesName.home,
              //         arguments: filter);
              //   },
              //   buttonColor: appThemeColor,
              //   textColor: Colors.white,
              //   buttonName: 'Search',
              // ),
              SizedBox(height: Utils.scrHeight * .010),
              Text('All News', style: semiBoldTS(appTextColor, fontSize: 20)),
              SizedBox(height: Utils.scrHeight * .010),
              searchListItem()
            ],
          ),
        ),
      ),
    );
  }

  SizedBox searchListItem() {
    return SizedBox(
      child: StreamBuilder<NewsModel>(
        stream: searchDataStream.broadCastStream,
        builder: (context, AsyncSnapshot<NewsModel> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data;
            List<Widget> searchList = data!
                .map((e) => GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NewsDetailsScreen(
                                newsId: e.id!,
                                newsDec: e.description,
                                sourceLink: e.url!,
                                newsTitle: e.title!,
                                image: e.featuredImage,
                              ),
                            ));
                      },
                      child: SearchListItem(
                        title: e.title,
                        imageName: e.featuredImage,
                        time: e.createdAt,
                      ),
                    ))
                .toList();
            return Column(children: [
              if (searchList.isNotEmpty) ...searchList,
              if (searchList.isEmpty) const Text('No Search Result Found'),
            ]);

            // data.isNotEmpty
            //     ?
            //     // ? data
            //     //     .map((e) => GestureDetector(
            //     //           onTap: () {
            //     //             Navigator.push(
            //     //                 context,
            //     //                 MaterialPageRoute(
            //     //                   builder: (context) => NewsDetailsScreen(
            //     //                     newsId: e.id!,
            //     //                     newsDec: e.description,
            //     //                     sourceLink: e.url!,
            //     //                     newsTitle: e.title!,
            //     //                     image: e.featuredImage,
            //     //                   ),
            //     //                 ));
            //     //           },
            //     //           child: SearchListItem(
            //     //             title: e.title,
            //     //             imageName: e.featuredImage,
            //     //             time: e.createdAt,
            //     //           ),
            //     //         ));)
            //     //     .toList()

            //     ListView.builder(
            //         // padding: EdgeInsets.symmetric(
            //         //     horizontal: Utils.scrHeight * .024,
            //         //     vertical: Utils.scrHeight * .024),
            //         itemCount: data.length,
            //         itemBuilder: (context, index) {
            //           return GestureDetector(
            //             onTap: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                     builder: (context) => NewsDetailsScreen(
            //                       newsId: data[index].id!,
            //                       newsDec: data[index].description,
            //                       sourceLink: data[index].url!,
            //                       newsTitle: data[index].title!,
            //                       image: data[index].featuredImage,
            //                     ),
            //                   ));
            //             },
            //             child: SearchListItem(
            //               title: data[index].title,
            //               imageName: data[index].featuredImage,
            //               time: data[index].createdAt,
            //             ),
            //           );
            //         },
            //       )
            //     : const Center(child: Text('Data not found'));
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('No Search result found'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  FutureBuilder<CategoryModel> selectCategorySection() {
    return FutureBuilder<CategoryModel>(
        future: NewsData.fetchCategory(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data!;
            return GridView.builder(
              primary: false,
              padding: EdgeInsets.all(Utils.scrHeight * .014),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisSpacing: Utils.scrHeight * .014,
                mainAxisSpacing: Utils.scrHeight * .014,
                crossAxisCount: 2,
                childAspectRatio: 1.4,
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                return CustomCategoryItems(
                  isSelected: selectedCategory == data[index].title,
                  onTap: () {
                    Navigator.pushNamed(context, RoutesName.home,
                        arguments: data[index].title);
                    log('Selected category: ${data[index].title}');
                    setState(() {
                      selectedCategory = data[index].title;
                      // Navigator.pushNamed(context, RoutesName.home,
                      //     arguments: selectedCategory);
                    });
                  },
                  title: data[index].title!,
                  image: data[index].image ?? '',
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('No Category Found'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

// @override
// void dispose() {
//   _searchController.dispose();
//   super.dispose();
// }
}
