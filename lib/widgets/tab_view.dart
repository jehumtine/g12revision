import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:g12revision/screens/home_screen.dart';
import 'package:g12revision/screens/profile_screen.dart';
import 'package:g12revision/screens/saved_courses_screen.dart';
import 'package:g12revision/screens/web_screen.dart';
import 'package:g12revision/widgets/app_colors.dart';
import 'package:g12revision/widgets/circle_button.dart';
import 'package:g12revision/widgets/custom_text_styles.dart';
import 'package:g12revision/widgets/drawer.dart';
import 'package:g12revision/widgets/menu_button.dart';
import '../screens/notification_screen.dart';

class TabView extends StatefulWidget {
  const TabView({Key? key}) : super(key: key);

  @override
  State<TabView> createState() => _TabViewState();
}

class _TabViewState extends State<TabView> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: purpleColor,
          title: Text(
            "Transcended Institute",
            style: googleStyle.copyWith(color: whiteColor, fontSize: 20),
          ),
          actions: [
            CircularButton(
              child: const Icon(Icons.person),
              onTap: () => Get.to(() => const ProfileScreen()),
            ),
            CircularButton(
              child: const Icon(Icons.notifications),
              onTap: () => Get.to(() => const NotificationScreen(
                    showAppBar: false,
                  )),
            ),
            MenuButton.instance.popUpMenuBtn(context)
          ],
          bottom: TabBar(
              indicatorColor: darkOrangeColor,
              labelStyle: googleStyle.copyWith(color: whiteColor),
              controller: _tabController,
              tabs: const [
                Tab(
                  icon: Icon(
                    FontAwesomeIcons.house,
                    size: 18,
                  ),
                ),
                Tab(
                  text: 'Courses',
                ),
                Tab(
                  text: 'Youtube',
                ),
                Tab(
                  text: 'Facebook',
                )
              ]),
        ),
        drawer: const NavDrawer(),
        body: TabBarView(
          controller: _tabController,
          children: const [
            HomeScreen(),
            SavedCoursesScreen(
              showAppbar: false,
            ),
            WebScreen(
                showAppbar: false,
                url: 'https://www.youtube.com/c/g12revision',
                name: 'Channel'),
            WebScreen(
                showAppbar: false,
                url: 'https://www.facebook.com/TRASCENDED',
                name: 'Facebook'),
          ],
        ));
  }
}
