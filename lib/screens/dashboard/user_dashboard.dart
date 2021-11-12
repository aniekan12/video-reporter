import 'package:flutter/material.dart';
import 'package:frsc_presentation/screens/home/homescreen_view.dart';
import 'package:frsc_presentation/screens/incidents_reported/incidents_reported_view.dart';
import 'package:frsc_presentation/screens/profile/yourprofile_view.dart';
import 'package:frsc_presentation/size_config/size_config.dart';
import 'package:frsc_presentation/utilities/colors.dart';
import 'package:frsc_presentation/utilities/style.dart';

class UserDashboard extends StatefulWidget {
  const UserDashboard({Key? key}) : super(key: key);

  @override
  _UserDashboardState createState() => _UserDashboardState();
}

class _UserDashboardState extends State<UserDashboard>
    with WidgetsBindingObserver {
  PageController _pageController = PageController();
  List<Widget>? dashboardPages;
  int currentPage = 0;
  void onItemSelected(int index) {
    _pageController.jumpToPage(
      index,
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);

    dashboardPages = [
      const HomeScreen(),
      const IncidentsReportedView(),
      const YourProfileView(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig.init(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.primary,
      ),
      body: PageView(
        controller: _pageController,
        children: dashboardPages!,
        physics: NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          onTap: onItemSelected,
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.white,
          elevation: 80,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.subtextColor,
          selectedFontSize: 14.0,
          currentIndex: currentPage,
          unselectedLabelStyle: AppTextStyles.unselectedItembottomNavStyle,
          selectedLabelStyle: AppTextStyles.selectedItembottomNavStyle,
          unselectedFontSize: 14.0,
          items: const [
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 6),
                child: Icon(Icons.camera),
              ),
              label: 'Report',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 6),
                child: Icon(Icons.storage),
              ),
              label: 'Your Reports',
            ),
            // BottomNavigationBarItem(
            //   icon: Padding(
            //     padding: EdgeInsets.fromLTRB(0, 20, 0, 6),
            //     child: ImageIcon(AssetImage(Constants.bottomNavCalender)),
            //   ),
            //   label: Constants.bookingsText,
            // ),

            BottomNavigationBarItem(
              icon: Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 6),
                child: Icon(Icons.person),
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
