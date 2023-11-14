import 'package:flutter/material.dart';
import 'package:hungry/views/screens/add_recipe.dart';
import 'package:hungry/views/screens/bookmarks_page.dart';
import 'package:hungry/views/screens/explore_page.dart';
import 'package:hungry/views/screens/home_page.dart';
import 'package:hungry/utils/AppColor.dart';
import 'package:hungry/views/widgets/custom_bottom_navigation_bar.dart';

class PageSwitcher extends StatefulWidget {
  final String token;

  const PageSwitcher({
    Key? key,
    required this.token,
  }) : super(key: key);
  @override
  _PageSwitcherState createState() => _PageSwitcherState();
}

class _PageSwitcherState extends State<PageSwitcher> {
  int _selectedIndex = 0;

  _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    String token = widget.token;
    print(token);
    print(token);
    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          [
            HomePage(),
          ][_selectedIndex],
          BottomGradientWidget(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColor.primary,
        child: const Icon(Icons.add_circle),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (builder) => AddRecipeScreen(token: token),
          ),
        ),
      ),
    );
  }
}

class BottomGradientWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 150,
        decoration: BoxDecoration(gradient: AppColor.bottomShadow),
      ),
    );
  }
}
