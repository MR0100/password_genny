import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:password_genny/local_data.dart';
import 'package:password_genny/provider/home_screen_provider.dart';
import 'package:password_genny/screens/add_new_password_screen.dart';
import 'package:password_genny/widgets/all_application_password_page.dart';
import 'package:password_genny/widgets/bank_password_page.dart';
import 'package:password_genny/widgets/home_screen_appbar.dart';
import 'package:password_genny/widgets/home_screen_tab_bar.dart';
import 'package:password_genny/widgets/social_application_password_page.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// currpage ...
  int currPage = 0;

  /// pageview controller ...
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: currPage,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Consumer<HomeScreenProvider>(
      builder: (_, _homeScreenProvider, child) => Scaffold(
        appBar: CustomAppBar(
          context: context,
        ),
        floatingActionButton: Builder(builder: (context) {
          return FloatingActionButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => AddNewPasswordScreen())),
            autofocus: false,
            backgroundColor: Color(0xff710a77),
            child: Icon(
              Icons.add,
              size: 30.0,
            ),
          );
        }),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            CustomTabBar(
              currPage: currPage,
              onPageChange: (page) => setState(() {
                _pageController.animateToPage(page,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeIn);
                currPage = page;
              }),
            ),
            Expanded(
              child: PageView(
                physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                children: [
                  AllApplicationPasswordsPage(),
                  SocialApplicationPasswordsPage(),
                  BankPasswordsPage()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
