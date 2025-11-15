import 'dart:math';

import 'package:playremusica/core/exception/out_bounds_index_exception.dart';

class Index {
  final int len;
  int _value = 0;
  int get value => _value;

  Index({required this.len});

  void increase(){
    _value++;
    if(len <= _value) _value -= len;
  }

  void decrease(){
    _value--;
    if(0 > _value) _value = len + _value;
  }

  void random(){
    _value = Random().nextInt(len);
  }

  void setIndex(int index){
    if(0 > index || index >= len) throw OutBoundsIndexException(index, len);
    _value = index;
  }
}
