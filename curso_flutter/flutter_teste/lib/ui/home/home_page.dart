import 'package:crystal_navigation_bar/crystal_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_teste/ui/auth/logout/widgets/logout_button.dart';
import 'package:flutter_floating_bottom_bar/flutter_floating_bottom_bar.dart';
import 'package:iconly/iconly.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

enum _SelectedTab { home, favourite }

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  _SelectedTab _selectedTab = _SelectedTab.home;
  late TabController tabController;

  Widget getTab(ScrollController controller) {
    switch (_selectedTab) {
      case _SelectedTab.home:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Home Page'), LogoutButton()],
          ),
        );
      case _SelectedTab.favourite:
        return Center(
          child: ListView(
            controller: controller,
            children: List.generate(
              100,
              (index) => ListTile(
                title: Text('Item $index'),
              ),
            ),
          ),
        );
    }
  }

//  TabController tabController = TabController(length: 2, vsync: );

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  void _handleIndexChanged(int index) {
    setState(() {
      _selectedTab = _SelectedTab.values[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: BottomBar(
        fit: StackFit.expand,
        // icon: (width, height) => Center(
        //   child: IconButton(
        //     padding: EdgeInsets.zero,
        //     onPressed: null,
        //     icon: Icon(
        //       IconlyLight.arrow_up,
        //       color: Colors.white,
        //       size: width,
        //     ),
        //   ),
        // ),
        borderRadius: BorderRadius.circular(500),
        duration: Duration(seconds: 1),
        curve: Curves.decelerate,
        showIcon: true,
        width: MediaQuery.of(context).size.width * 0.8,
        barColor: Colors.transparent,
        start: 2,
        end: 0,
        offset: 0,
        barAlignment: Alignment.bottomCenter,
        iconHeight: 35,
        iconWidth: 35,
        reverse: false,
        // barDecoration: BoxDecoration(
        //   color: Colors.black45, // Use a cor desejada
        //   // image: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        //   borderRadius: BorderRadius.circular(500),
        // ),
        // iconDecoration: BoxDecoration(
        //   color: Colors.blue, // Use a cor desejada
        //   borderRadius: BorderRadius.circular(500),
        // ),
        hideOnScroll: true,
        scrollOpposite: false,
        onBottomBarHidden: () {},
        onBottomBarShown: () {},
        body: (context, controller) => getTab(controller),
        // child: TabBar(
        //   controller: tabController, // Adicione o controlador de guias aqui
        //   tabs: [
        //     Tab(
        //       icon: Icon(IconlyLight.home),
        //     ),
        //     Tab(
        //       icon: Icon(IconlyLight.heart),
        //     ),
        //   ],
        // ),
        child: CrystalNavigationBar(
          currentIndex: _SelectedTab.values.indexOf(_selectedTab) ?? 0,
          // indicatorColor: Colors.white,
          unselectedItemColor: Colors.white70,
          backgroundColor: Colors.black.withValues(alpha: 0.5),
          // outlineBorderColor: Colors.black.withOpacity(0.1),
          onTap: _handleIndexChanged,
          enableFloatingNavBar: true,
          // height: 10,
          items: [
            /// Home
            CrystalNavigationBarItem(
              icon: IconlyBold.home,
              unselectedIcon: IconlyLight.home,
              selectedColor: Colors.white,
            ),

            /// Favourite
            CrystalNavigationBarItem(
              icon: IconlyBold.heart,
              unselectedIcon: IconlyLight.heart,
              selectedColor: Colors.red,
            ),
          ],
        ),
      ),

      // Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [Text('Home Page'), LogoutButton()],
      //   ),
      // ),
      extendBody: true,
      // bottomNavigationBar:
      // Padding(
      //   padding: const EdgeInsets.only(bottom: 10),
      //   child: CrystalNavigationBar(
      //     currentIndex: _SelectedTab.values.indexOf(_selectedTab),
      //     // indicatorColor: Colors.white,
      //     unselectedItemColor: Colors.white70,
      //     backgroundColor: Colors.black.withValues(alpha: 0.5),
      //     // outlineBorderColor: Colors.black.withOpacity(0.1),
      //     onTap: _handleIndexChanged,
      //     enableFloatingNavBar: true,
      //     // height: 10,
      //     items: [
      //       /// Home
      //       CrystalNavigationBarItem(
      //         icon: Icons.home_outlined,
      //         unselectedIcon: Icons.home,
      //         selectedColor: Colors.white,
      //       ),

      //       /// Favourite
      //       CrystalNavigationBarItem(
      //         icon: Icons.favorite_border,
      //         unselectedIcon: Icons.favorite,
      //         selectedColor: Colors.red,
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
