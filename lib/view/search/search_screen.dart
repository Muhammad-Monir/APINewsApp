// ignore_for_file: unnecessary_null_comparison
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
  List<Widget> searchList = [];
  final FocusNode _focusNode = FocusNode();
  bool _isKeyboardOpen = false;
  late Future<NewsModel> fetchAllNews;

  void _onFocusChange() {
    setState(() {
      _isKeyboardOpen = _focusNode.hasFocus;
    });
  }

  SearchDataStream searchDataStream = SearchDataStream();
  // StreamSubscription? _searchSubscription;

  @override
  void initState() {
    super.initState();
    // fetchNews(_searchController.text);
    _focusNode.addListener(_onFocusChange);
    searchDataStream.fetchSearchStream(searchTitle: '');
    // _searchController.addListener(_onSearchTextChanged);
  }

  Future<NewsModel> fetchNews(String? searchText) async {
    if (searchText == null) {
      // Fetch All News
      fetchAllNews = NewsData.fetchAllNews();
    } else {
      // Fetch News filter by Category
      fetchAllNews = NewsData.searchText(searchTitle: searchText);
    }
    return fetchAllNews;
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _searchController.dispose();
    // _searchController.removeListener(_onSearchTextChanged);
    super.dispose();
  }

// Function to handle search text changes
  // void _onSearchTextChanged() {
  //   log(_searchController.text);
  //   if (_searchController.text.isNotEmpty) {
  //     log('if work');
  //     searchDataStream.fetchSearchStream(searchTitle: _searchController.text);
  //   } else {
  //     log('else work');
  //     searchDataStream.fetchSearchStream(searchTitle: '');
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    log('build widget');
    return Scaffold(
      appBar: AppBar(
        title: Text('Search For', style: mediumTS(appBarColor, fontSize: 24)),
      ),
      body: GestureDetector(
        // onTap: () {
        //   FocusScope.of(context).requestFocus(FocusNode());
        //   searchDataStream.fetchSearchStream(searchTitle: '');
        // },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Utils.scrHeight * .024,
            vertical: Utils.scrHeight * .016,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                // Search Filed for search by title
                Focus(
                  focusNode: _focusNode,
                  child: EmailFormField(
                    onFiledSubmitt: (value) {
                      log('submitte called $value');
                      if (value!.isNotEmpty) {
                        // searchDataStream.fetchSearchStream(
                        //     searchTitle: _searchController.text);
                        fetchNews(_searchController.text);
                      } else {
                        // searchDataStream.fetchSearchStream(searchTitle: '');
                        fetchNews(_searchController.text);
                      }
                    },
                    // onChanged: (value) {
                    //   if (value!.isNotEmpty || value != null) {
                    //     searchDataStream.fetchSearchStream(searchTitle: value);
                    //   }
                    // },
                    emailController: _searchController,
                    hintText: 'Search news',
                    validate: false,
                  ),
                ),
                SizedBox(height: Utils.scrHeight * .024),
                Text('Categories',
                    style: semiBoldTS(appTextColor, fontSize: 20)),
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
      ),
    );
  }

  SizedBox searchListItem() {
    return SizedBox(
      child: FutureBuilder<NewsModel>(
        future: fetchNews(_searchController.text),
        builder: (context, AsyncSnapshot<NewsModel> snapshot) {
          if (snapshot.hasData) {
            final data = snapshot.data!.data;
            if (data!.isNotEmpty) {
              searchList = data
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
                                  image: e.featuredImage!,
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
              return Column(
                children: searchList,
              );
            } else {
              return const Center(child: Text('Data not found'));
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
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
}
