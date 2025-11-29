import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:playremusica/features/player/presentation/viewmodel/play_page_view_model.dart';
import 'package:playremusica/presentation/widgets/glass_filter_card.dart';
import 'package:playremusica/presentation/widgets/ink_card.dart';

class MovePreviousButton extends ConsumerStatefulWidget {
  const MovePreviousButton({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MoveNextButtonState();
}

class _MoveNextButtonState extends ConsumerState<MovePreviousButton> {
  @override
  Widget build(BuildContext context) {
    final prov = ref.watch(playPageViewModelProvider.notifier);
    
    return InkCard(
      radius: 256,
      onTap: () {
        prov.movePrevious();
      }, 
      child: GlassFilterCard(
        radius: 256,
        child: Padding(
          padding: EdgeInsets.all(14),
          child: Icon(Icons.skip_previous),
        ),
      ),
    );
  }
}
