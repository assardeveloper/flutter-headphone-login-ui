import 'package:flutter/material.dart';

// Colors used in the drawer UI
const Color kNavy = Color(0xFF0F1D35);
const Color kNavyLight = Color(0xFF1E3050);
const Color kGreen = Color(0xFF4CB782);
const Color kYellow = Color(0xFFF4C542);
const Color kGrey = Color(0xFF9E9E9E);
const Color kLightBg = Color(0xFFF5F6F8);

// Menu items on the left side
const List<Map<String, dynamic>> menuItems = [
  {'title': 'Profile', 'icon': Icons.account_circle},
  {'title': 'Home Page', 'icon': Icons.home_rounded},
  {'title': 'My Cart', 'icon': Icons.shopping_cart},
  {'title': 'Favorite', 'icon': Icons.favorite},
  {'title': 'Orders', 'icon': Icons.shopping_basket},
  {'title': 'Notifications', 'icon': Icons.notifications},
];

// ---------------------------------------------------------------------------
// Side menu
// ---------------------------------------------------------------------------

// Left menu wrapper, children go top to bottom
Widget sideMenu({required List<Widget> children}) {
  return SafeArea(
    child: Padding(
      padding: const EdgeInsets.fromLTRB(20, 40, 0, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    ),
  );
}

// Avatar with "Hey Mia Johnson"
Widget menuHeader() {
  return Padding(
    padding: const EdgeInsets.only(bottom: 50),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        avatar(),
        const SizedBox(height: 16),
        const Text(
          'Hey 👋',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        const Text(
          'Mia Johnson',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
  );
}

// Profile, Home Page and My Cart buttons
Widget menuTopButtons({
  required int selected,
  required ValueChanged<int> onSelect,
}) {
  return menuGroup(from: 0, to: 3, selected: selected, onSelect: onSelect);
}

// Favorite, Orders and Notifications buttons
Widget menuBottomButtons({
  required int selected,
  required ValueChanged<int> onSelect,
}) {
  return menuGroup(from: 3, to: 6, selected: selected, onSelect: onSelect);
}

// A few menu tiles from the menuItems list
Widget menuGroup({
  required int from,
  required int to,
  required int selected,
  required ValueChanged<int> onSelect,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      for (int i = from; i < to; i++)
        menuTile(
          title: menuItems[i]['title'],
          icon: menuItems[i]['icon'],
          isSelected: i == selected,
          onTap: () => onSelect(i),
        ),
    ],
  );
}

// Sign out button pinned to the bottom of the menu
Widget signOutButton() {
  return Expanded(
    child: Align(
      alignment: Alignment.bottomLeft,
      child: menuTile(
        title: 'Sign Out',
        icon: Icons.logout,
        isSelected: false,
        onTap: () {},
      ),
    ),
  );
}

// Yellow rounded square with the profile photo
Widget avatar() {
  return Container(
    width: 68,
    height: 68,
    decoration: BoxDecoration(
      color: kYellow,
      borderRadius: BorderRadius.circular(18),
    ),
    clipBehavior: Clip.antiAlias,
    child: Image.network(
      'https://randomuser.me/api/portraits/women/44.jpg',
      fit: BoxFit.cover,
      errorBuilder: (context, error, stack) =>
          const Icon(Icons.person, color: kNavy, size: 40),
    ),
  );
}

// One row in the menu, highlighted when selected
Widget menuTile({
  required String title,
  required IconData icon,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? kNavyLight : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 24),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Ghost page behind the home page
// ---------------------------------------------------------------------------

// Faded product details page that shows behind the main card
Widget ghostPage() {
  return Container(
    decoration: BoxDecoration(
      color: const Color(0xFFB8BEC8),
      borderRadius: BorderRadius.circular(30),
    ),
    clipBehavior: Clip.antiAlias,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 60, 20, 0),
          child: Icon(Icons.arrow_back_ios, size: 16, color: Colors.black54),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Text(
            'Lorem ipsum\nDolor sit',
            style: TextStyle(fontSize: 18, color: Colors.black54),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade300,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 14, 20, 0),
          child: Row(
            children: [
              Icon(Icons.star, size: 14, color: Colors.orange),
              Icon(Icons.star, size: 14, color: Colors.orange),
              Icon(Icons.star, size: 14, color: Colors.orange),
            ],
          ),
        ),
        const SizedBox(height: 40),
        Container(
          height: 60,
          width: double.infinity,
          color: const Color(0xFF3A4556),
          padding: const EdgeInsets.only(left: 20),
          alignment: Alignment.centerLeft,
          child: const Text(
            '\$299',
            style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Home page widgets
// ---------------------------------------------------------------------------

// Big title on top of the home page
Widget homeTitle() {
  return const Text(
    "Let's find\nYour Gadget!",
    style: TextStyle(
      fontSize: 28,
      height: 1.2,
      fontWeight: FontWeight.w800,
      color: kNavy,
    ),
  );
}

// Grey rounded search field
Widget searchBar() {
  return Container(
    height: 52,
    padding: const EdgeInsets.symmetric(horizontal: 18),
    decoration: BoxDecoration(
      color: kLightBg,
      borderRadius: BorderRadius.circular(14),
    ),
    child: const Row(
      children: [
        Expanded(
          child: Text('Search', style: TextStyle(color: kGrey, fontSize: 14)),
        ),
        Icon(Icons.search, color: kGrey),
      ],
    ),
  );
}

// Green promo banner with headphones
Widget promoBanner() {
  return Container(
    height: 150,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: kGreen,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Lorem ipsum\ndolor',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Noise Cancelling\nWireless Headphone',
                style: TextStyle(color: Colors.white70, fontSize: 11),
              ),
            ],
          ),
        ),
        Container(
          width: 90,
          height: 90,
          decoration: const BoxDecoration(
            color: Color(0xFF3B9468),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.headphones, color: kNavy, size: 50),
        ),
      ],
    ),
  );
}

// Small page indicator under the banner
Widget pageDots() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      for (int i = 0; i < 3; i++)
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: i == 0 ? 7 : 5,
          height: i == 0 ? 7 : 5,
          decoration: BoxDecoration(
            color: i == 0 ? kNavy : Colors.black26,
            shape: BoxShape.circle,
          ),
        ),
    ],
  );
}

// Section heading like "Categories"
Widget sectionTitle(String text) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w700,
      color: kNavy,
    ),
  );
}

// Horizontal list of category chips
Widget categories() {
  const items = [
    {'title': 'Computer', 'icon': Icons.laptop},
    {'title': 'Phone', 'icon': Icons.phone_iphone},
    {'title': 'Watch', 'icon': Icons.watch},
    {'title': 'Camera', 'icon': Icons.camera_alt_outlined},
  ];
  return SizedBox(
    height: 46,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(width: 12),
      itemBuilder: (context, i) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: kLightBg,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(items[i]['icon'] as IconData, size: 20, color: kNavy),
            const SizedBox(width: 8),
            Text(
              items[i]['title'] as String,
              style: const TextStyle(color: kGrey, fontSize: 13),
            ),
          ],
        ),
      ),
    ),
  );
}

// Popular / Discount / New tabs with a dot under the active one
Widget productTabs({required int selected, required ValueChanged<int> onTap}) {
  const tabs = ['Popular', 'Discount', 'New Arrival'];
  return Row(
    children: [
      for (int i = 0; i < tabs.length; i++)
        GestureDetector(
          onTap: () => onTap(i),
          child: Padding(
            padding: const EdgeInsets.only(right: 24),
            child: Column(
              children: [
                Text(
                  tabs[i],
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: i == selected ? FontWeight.w700 : FontWeight.w400,
                    color: i == selected ? kNavy : kGrey,
                  ),
                ),
                const SizedBox(height: 4),
                CircleAvatar(
                  radius: 2.5,
                  backgroundColor: i == selected ? kNavy : Colors.transparent,
                ),
              ],
            ),
          ),
        ),
    ],
  );
}

// Product cards with a laptop image
Widget productList() {
  const products = [
    {'name': 'MacBook Pro', 'price': '\$1299', 'icon': Icons.laptop_mac},
    {'name': 'Surface Book', 'price': '\$999', 'icon': Icons.laptop_windows},
    {'name': 'Chromebook', 'price': '\$499', 'icon': Icons.laptop_chromebook},
  ];
  return SizedBox(
    height: 190,
    child: ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: products.length,
      separatorBuilder: (_, __) => const SizedBox(width: 14),
      itemBuilder: (context, i) => Container(
        width: 150,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: kLightBg,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Center(
                child: Icon(
                  products[i]['icon'] as IconData,
                  size: 80,
                  color: Colors.blueGrey.shade700,
                ),
              ),
            ),
            Text(
              products[i]['name'] as String,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                color: kNavy,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              products[i]['price'] as String,
              style: const TextStyle(color: kGreen, fontWeight: FontWeight.w700),
            ),
          ],
        ),
      ),
    ),
  );
}

// Bottom navigation bar of the home page
Widget bottomBar() {
  const icons = [
    Icons.home_rounded,
    Icons.shopping_basket_outlined,
    Icons.favorite_border,
    Icons.person_outline,
  ];
  return Container(
    height: 70,
    decoration: const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        for (int i = 0; i < icons.length; i++)
          Icon(icons[i], color: i == 0 ? kNavy : Colors.black26, size: 26),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Layout helpers
// ---------------------------------------------------------------------------

// Grid icon that opens and closes the drawer
Widget menuButton(VoidCallback onTap) {
  return Align(
    alignment: Alignment.centerLeft,
    child: GestureDetector(
      onTap: onTap,
      child: const Icon(Icons.grid_view_rounded, color: kNavy, size: 28),
    ),
  );
}

// White home page with bottom bar, children are stacked with spacing
Widget homeLayout({required List<Widget> children}) {
  return Scaffold(
    backgroundColor: Colors.white,
    bottomNavigationBar: bottomBar(),
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: children,
        ),
      ),
    ),
  );
}

// Shrinks and slides the home page to the right with the ghost page behind
Widget animatedPages({
  required BuildContext context,
  required Animation<double> animation,
  required VoidCallback onClose,
  required Widget child,
}) {
  final width = MediaQuery.of(context).size.width;
  return AnimatedBuilder(
    animation: animation,
    builder: (context, child) {
      final t = animation.value;
      return Stack(
        children: [
          // Faded page behind the home page
          Transform(
            alignment: Alignment.centerLeft,
            transform: Matrix4.identity()
              ..translateByDouble(width * 0.56 * t, 0, 0, 1)
              ..scaleByDouble(1 - 0.32 * t, 1 - 0.32 * t, 1, 1),
            child: Opacity(opacity: t, child: ghostPage()),
          ),
          // Home page card
          Transform(
            alignment: Alignment.centerLeft,
            transform: Matrix4.identity()
              ..translateByDouble(width * 0.66 * t, 0, 0, 1)
              ..scaleByDouble(1 - 0.2 * t, 1 - 0.2 * t, 1, 1),
            child: GestureDetector(
              onTap: t == 1 ? onClose : null,
              child: AbsorbPointer(
                absorbing: t > 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30 * t),
                  child: child,
                ),
              ),
            ),
          ),
        ],
      );
    },
    child: child,
  );
}
