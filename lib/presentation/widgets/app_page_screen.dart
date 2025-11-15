import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:playremusica/core/settings/my_colors.dart';
import 'package:playremusica/features/home/presentation/pages/home_page.dart';
import 'package:playremusica/features/player/presentation/pages/play_page.dart';
import 'package:playremusica/presentation/widgets/gradient_icon.dart';

class AppPageScreen extends HookWidget {
  const AppPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPageIndex = useState(0);

    final pages = useMemoized(() => const [
      HomePage(),
      HomePage(),
      PlayPage(),
      HomePage(),
    ]);

    final bottomNavItems = useMemoized(() => [
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
    ]);

    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: currentPageIndex.value,
          children: pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavItems,
        currentIndex: currentPageIndex.value,
        onTap: (index) => currentPageIndex.value = index,
      ),
    );
  }
}
