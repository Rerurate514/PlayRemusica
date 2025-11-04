import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/splash/presentation/state/splash_page_view_model.dart';
import 'package:playremusica/presentation/widgets/app_page_screen.dart';

class SplashPage extends ConsumerStatefulWidget { 
  const SplashPage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  void _navigateMainScreen() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AppPageScreen(),)
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = ref.watch(splashPageViewModelProvider);

    // ref.listen<AsyncValue<void>>(splashPageViewModelProvider, (p, n) {
    //   n.whenData((_) {
    //     _navigateMainScreen();
    //   });
    // });

    viewModel.whenData((_) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _navigateMainScreen();
      });
    });

    return Scaffold(
      body: Center(
        child: viewModel.when(
          loading: () => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 16),
              const Text("Setup Application...")
            ],
          ),
          data: (_) => const Text("Completed!"), 
          error: (e, s) => const Text("Failed to launch application..."), 
        ),
      ),
    );
  }
}
