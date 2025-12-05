import 'package:freezed_annotation/freezed_annotation.dart';

part 'time.freezed.dart';

@freezed
sealed class Time with _$Time {
  const Time._();

  const factory Time({
    required double rawSeconds,
  }) = _Time;
  
  factory Time.createEmpty() {
    return Time(rawSeconds: 0.0);
  }

  int get hours => (rawSeconds ~/ 3600).toInt();
  int get minutes => ((rawSeconds % 3600) ~/ 60).toInt();
  double get remainingSeconds => rawSeconds % 60;

  @override
  String toString() {
    final int h = hours;
    final int m = minutes;
    
    final int sec = remainingSeconds.toInt();
    final String secFormatted = sec.toString().padLeft(2, '0');
    final String sDisplay = secFormatted;

    if (h > 0) {
      return "$h:$m:$sDisplay";
    }
    else if (m > 0) {
      return "$m:$sDisplay";
    }
    else {
      return "00:$sDisplay";
    }
  }
}
