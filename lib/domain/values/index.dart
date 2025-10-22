import 'dart:math';

class Index {
  final int len;
  int _value = 0;
  int get value => _value;

  Index({required this.len});

  void increase(){
    _value++;
    if(len <= _value) _value -= len;
  }

  void dicrease(){
    _value--;
    if(0 > _value) _value = len + _value;
  }

  void random(){
    _value = Random().nextInt(len);
  }

  void setIndex(int index){
    _value = index;
  }
}
