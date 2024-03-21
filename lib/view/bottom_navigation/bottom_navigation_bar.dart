
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../provider/bottom_navigation_provider.dart';
// import '../../utils/color.dart';
// import '../../utils/utils.dart';
// import '../bookmarks/bookmarks_screen.dart';
// import '../font/font_screen.dart';
// import '../search/search_screen.dart';
// import '../share/share_screen.dart';

// class BottomNavigationMenu extends StatelessWidget {
//   const BottomNavigationMenu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BottomNavigationProvider>(
//       builder: (context, provider, child) {
//         return Scaffold(
//           body: IndexedStack(
//             index: provider.selectedIndex,
//             children: _screens,
//           ),
//           bottomNavigationBar: Theme(
//             data: Theme.of(context).copyWith(
//                 canvasColor: Colors.white,
//                 splashColor: Colors.transparent,
//                 highlightColor: Colors.transparent),
//             child: BottomNavigationBar(
//               selectedLabelStyle: const TextStyle(color: appThemeColor),
//               unselectedLabelStyle: const TextStyle(color: appSecondTextColor),
//               items: <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: provider.selectedIndex == 0
//                       ? Utils.showSvgPicture('search_selected',
//                           height: Utils.scrHeight * 0.024,
//                           width: Utils.scrHeight * 0.024)
//                       : Utils.showSvgPicture('search',
//                           height: Utils.scrHeight * 0.024,
//                           width: Utils.scrHeight * 0.024),
//                   label: 'Search',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: provider.selectedIndex == 1
//                       ? Utils.showSvgPicture('selected_font',
//                           height: Utils.scrHeight * 0.024,
//                           width: Utils.scrHeight * 0.024)
//                       : Utils.showSvgPicture('font',
//                           height: Utils.scrHeight * 0.024,
//                           width: Utils.scrHeight * 0.024),
//                   label: 'Font',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: provider.selectedIndex == 2
//                       ? Stack(
//                           children: [
//                             Utils.showSvgPicture('selected_bookmark',
//                                 height: Utils.scrHeight * 0.024,
//                                 width: Utils.scrHeight * 0.024),
//                           ],
//                         )
//                       : Stack(
//                           children: [
//                             Utils.showSvgPicture('bookmark',
//                                 height: Utils.scrHeight * 0.024,
//                                 width: Utils.scrHeight * 0.024),
//                           ],
//                         ),
//                   label: 'BookMark',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: provider.selectedIndex == 3
//                       ? Utils.showSvgPicture('share',
//                           height: Utils.scrHeight * 0.024,
//                           width: Utils.scrHeight * 0.024)
//                       : Utils.showSvgPicture('share',
//                           height: Utils.scrHeight * 0.024,
//                           width: Utils.scrHeight * 0.024),
//                   label: 'Share',
//                 ),
//               ],
//               useLegacyColorScheme: false,
//               showSelectedLabels: true,
//               showUnselectedLabels: true,
//               currentIndex: provider.selectedIndex,
//               type: BottomNavigationBarType.fixed,
//               onTap: (index) {
//                 provider.updateSelectedIndex(index);
//               },
//             ),
//           ),
//         );
//       },
//     );
//   }

//   static final List<Widget> _screens = <Widget>[
//     const SearchScreen(),
//     const FontScreen(),
//     const BookMarksScreen(),
//     const ShareScreen(),
//   ];
// }
