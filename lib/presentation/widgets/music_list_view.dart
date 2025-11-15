import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/core/settings/my_colors.dart';
import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/features/home/presentation/widgets/list_view_music_picture.dart';
import 'package:playremusica/presentation/widgets/glass_filter_card.dart';
import 'package:playremusica/presentation/widgets/gradient_icon.dart';
import 'package:playremusica/presentation/widgets/ink_card.dart';

class MusicListView extends ConsumerStatefulWidget {
  final List<Music> musics;
  final void Function(int, Music) onTappedMusic;

  const MusicListView({
    super.key,
    required this.musics,
    required this.onTappedMusic
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MusicListViewState();
}

class _MusicListViewState extends ConsumerState<MusicListView> {

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      itemBuilder: (BuildContext context, int index) {
        final music = widget.musics[index];
        return Padding(
          key: ValueKey(music.name),
          padding: const EdgeInsets.all(8),
          child: InkCard(
            onTap: () => widget.onTappedMusic(index, music), 
            child: GlassFilterCard(
              child: ListTile(
                leading: ListViewMusicPicture(pictureImage: music.musicSettings.picture),
                title: Text(
                  music.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),
                ),
                trailing: GradientIcon(
                  icon: Icons.reorder, 
                  size: 50, 
                  gradient: MyColors.iconGradient
                ),
              ),
            ),
          )
        );
      }, 
      itemCount: widget.musics.length, 
      onReorder: (oldIndex, newIndex) {

      },
      proxyDecorator: (Widget child, int index, Animation<double> animation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (BuildContext context, Widget? child) {
            final scale = 1.0 + 0.05 * animation.value;
            return Transform.scale(
              scale: scale,
              child: Opacity(
                opacity: 0.8,
                child: child, 
              ),
            );
          },
          child: child,
        );
      },
    );
  }
}
