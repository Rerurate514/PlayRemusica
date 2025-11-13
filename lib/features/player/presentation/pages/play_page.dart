import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/player/presentation/viewmodel/play_page_view_model.dart';

class PlayPage extends HookConsumerWidget {
  const PlayPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(playPageViewModelProvider);
    final viewmodel = ref.watch(playPageViewModelProvider.notifier);

    return Scaffold(
      body: Center(
        child: Container()
      ),
    );
  }
}
