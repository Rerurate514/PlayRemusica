import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/home/presentation/viewmodel/home_page_view_model.dart';
import 'package:playremusica/presentation/widgets/music_list_view.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prov = ref.watch(homePageViewModelProvider);
    final viewmodel = ref.watch(homePageViewModelProvider.notifier);

    return Scaffold(
      body: Center(
        child: prov.when(
          data: (state) {
            return MusicListView(
              musics: state.musics,
              onTappedMusic: (int index, _) {
                viewmodel.onTappedMusic(index);
              },
            );
          }, 
          error: (e, o) {
            return Text(e.toString());
          },
          loading: () => CircularProgressIndicator()
        ),
      ),
    );
  }
}
