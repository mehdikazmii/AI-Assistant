import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../helper/ad_helper.dart';
import '../helper/global.dart';
import '../helper/pref.dart';
import '../model/home_type.dart';
import '../widget/home_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _isDarkMode = Get.isDarkMode.obs; //bug fix
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Pref.showOnboarding = false;
    _loadAd();
  }

  @override
  void dispose() {
    // Clean up any resources if needed
    super.dispose();
  }

  Future<void> _loadAd() async {
    try {
      // The ad will be loaded automatically when the widget is created
      setState(() {
        _isAdLoaded = true;
      });
    } catch (e) {
      print('Error loading ad: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    //initializing device size
    mq = MediaQuery.sizeOf(context);

    //sample api call
    // APIs.getAnswer('hii');

    return Scaffold(
      //app bar
      appBar: AppBar(
        title: const Text(appName),
      ),

      //ad
      bottomNavigationBar: _isAdLoaded ? AdHelper.nativeBannerAd() : null,
      // ... existing code ...
      //floating action button for theme switching
      floatingActionButton: FloatingActionButton(
        backgroundColor: _isDarkMode.value
            ? Colors.white.withOpacity(0.2)
            : Colors.black.withOpacity(0.1),
        elevation: 0,
        onPressed: () {
          Get.changeThemeMode(
              _isDarkMode.value ? ThemeMode.light : ThemeMode.dark);
          _isDarkMode.value = !_isDarkMode.value;
          Pref.isDarkMode = _isDarkMode.value;
        },
        child: Obx(() => Icon(
            _isDarkMode.value
                ? Icons.brightness_2_rounded
                : Icons.brightness_5_rounded,
            size: 26,
            // color: Get.isDarkMode ? Colors.black87 : Colors.white)),
            color: _isDarkMode.value ? Colors.white : Colors.black87)),
      ),
// ... existing code ...

      //body
      body: ListView(
        padding: EdgeInsets.symmetric(
            horizontal: mq.width * .04, vertical: mq.height * .015),
        children: HomeType.values.map((e) => HomeCard(homeType: e)).toList(),
      ),
    );
  }
}
