import 'package:flutter/material.dart';
import 'package:vng_pilot/tabs/history.dart';
import 'package:vng_pilot/tabs/home.dart';
import '../configs/colors.dart';
import '../widgets/dialogs.dart';

class HomeScreenActivity extends StatefulWidget {
  const HomeScreenActivity({Key? key}) : super(key: key);

  @override
  State<HomeScreenActivity> createState() => _HomeScreenActivityState();
}

class _HomeScreenActivityState extends State<HomeScreenActivity> {
  final ProgressDialog progressDialog = ProgressDialog();
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0), // here the desired height
          child: AppBar(elevation: 0)),
      body: SafeArea(
        child: _getCurrentTab(),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [primaryColor.withOpacity(0.6), primaryColor], begin: const FractionalOffset(0.0, 0.0), end: const FractionalOffset(0.6, 0.6), stops: [0.0, 1.0], tileMode: TileMode.clamp),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(1),
                      decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
                      child: Image.asset("assets/images/image_default_user.png", width: 60, height: 60),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Demo User",
                      style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ),
            ),
            _buildNavItem(index: 0, title: 'Upload Image', icon: Icons.upload_outlined, onTap: () => _onItemTapped(0)),
            _buildNavItem(index: 1, title: 'History', icon: Icons.photo_library_outlined, onTap: () => _onItemTapped(1)),
            Divider(),
            _buildNavItem(
                index: 4,
                title: 'Log Out',
                icon: Icons.logout,
                onTap: () async {
                  Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                }),
          ],
        ),
      ),
    );
  }

  Widget _getCurrentTab() {
    List<Widget> _tabList = [
      HomeTab(),
      HistoryTab(onUpload: () {
        setState(() => _selectedPage = 0);
      }),
    ];

    return _tabList[_selectedPage];
  }

  Widget _buildNavItem({required int index, required String title, required IconData icon, required GestureTapCallback onTap}) {
    return ListTile(
      selected: (_selectedPage == index),
      selectedTileColor: primaryColor.withOpacity(0.1),
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedPage = index;
    });
    Navigator.pop(context);
  }
}
