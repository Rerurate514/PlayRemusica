import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:playremusica/core/settings/my_colors.dart';
import 'package:playremusica/features/home/presentation/pages/home_page.dart';
import 'package:playremusica/presentation/widgets/gradient_icon.dart';
import 'package:playremusica/presentation/widgets/gradient_screen.dart';

class AppPageScreen extends HookWidget {
  const AppPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController(initialPage: 0);
    
    final currentPageIndex = useState(0);

    final List<Widget> pages = const [
      HomePage(),
    ];

    void onItemTapped(int indexArg) {
      currentPageIndex.value = indexArg;
      pageController.animateToPage(
        indexArg,
        duration: const Duration(milliseconds: 300),
        curve: Curves.ease,
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: pageController,
            onPageChanged: (index) {
              currentPageIndex.value = index;
            },
            children: pages,
          ),
          GradientScreen()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.home, 
              size: 25, 
              gradient: MyColors.iconGradient,
            ), 
            label: "Home"
          ),
          BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.list, 
              size: 25, 
              gradient: MyColors.iconGradient,
            ), 
            label: "List"
          ),
          BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.play_arrow, 
              size: 25, 
              gradient: MyColors.iconGradient,
            ), 
            label: "Play"
          ),
          BottomNavigationBarItem(
            icon: GradientIcon(
              icon: Icons.settings, 
              size: 25, 
              gradient: MyColors.iconGradient,
            ), 
            label: "Settings"
          ),
        ],
        currentIndex: currentPageIndex.value,
        onTap: onItemTapped,
      ),
    );
  }
}
