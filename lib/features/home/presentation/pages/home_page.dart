import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/home/presentation/viewmodel/home_page_view_model.dart';

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
            return ReorderableListView.builder(
              itemBuilder: (BuildContext context, int index) {
                final name = state.musics[index].name;
                return ListTile(
                  key: Key(name),
                  title: Text(name),
                );
              }, 
              itemCount: state.musics.length, 
              onReorder: (oldIndex, newIndex) {

              }
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
