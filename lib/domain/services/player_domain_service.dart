import 'package:playremusica/domain/entities/music.dart';
import 'package:playremusica/domain/entities/playlist.dart';
import 'package:playremusica/domain/values/index.dart';
import 'package:playremusica/domain/values/music_mode.dart';
import 'package:playremusica/domain/values/transition.dart';

class PlayerDomainService {
  final PlayList playList;
  final Index _index;

  PlayerDomainService({
    required this.playList
  }): _index = Index(len: playList.list.length);

  MusicMode _musicMode = Normal();
  MusicMode get musicMode => _musicMode;

  Music handleMusicTransition(Transition transition) {
    switch(transition){
      case Next(): _index.increase();
      case Previous(): _index.dicrease();
      case Random(): _index.random();
    }

    return playList.list[_index.value];
  }

  void setMusicMode(MusicMode musicMode) {
    _musicMode = musicMode;
  }

  Music handleMusicCompletion() {
    switch (_musicMode) {
      case Normal(): _index.increase();
      case Loop(): break; 
      case Shuffle(): _index.random();
    }

    return playList.list[_index.value];
  }

  Music getCurrentMusicId(){
    return playList.list[_index.value];
  }
}
