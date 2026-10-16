import 'package:flutter/material.dart';

import 'drawer_widgets.dart';

// Screen with the animated side drawer and the gadget home page
class DrawerPage extends StatefulWidget {
  const DrawerPage({super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 450),
    value: 1, // start with the drawer open
  );
  late final Animation<double> anim = CurvedAnimation(
    parent: controller,
    curve: Curves.easeOutCubic,
    reverseCurve: Curves.easeInCubic,
  );

  int selectedMenu = 1;
  int selectedTab = 0;

  void toggleDrawer() =>
      controller.value == 1 ? controller.reverse() : controller.forward();

  void selectMenu(int i) {
    setState(() => selectedMenu = i);
    controller.reverse();
  }

  void selectTab(int i) => setState(() => selectedTab = i);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kNavy,
      body: Stack(
        children: [
          sideMenu(
            children: [
              menuHeader(),
              menuTopButtons(selected: selectedMenu, onSelect: selectMenu),
              menuBottomButtons(selected: selectedMenu, onSelect: selectMenu),
              signOutButton(),
            ],
          ),
          animatedPages(
            context: context,
            animation: anim,
            onClose: controller.reverse,
            child: homeLayout(
              children: [
                menuButton(toggleDrawer),
                homeTitle(),
                searchBar(),
                promoBanner(),
                pageDots(),
                sectionTitle("Categories"),
                productTabs(selected: selectedTab, onTap: selectTab),
                productList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
