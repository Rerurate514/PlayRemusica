import 'package:flutter/material.dart';

class MusicImage extends StatefulWidget {
  final ImageProvider<Object>? image;
  const MusicImage({
    super.key,
    required this.image
  });

  @override
  State<MusicImage> createState() => _MusicImageState();
}

class _MusicImageState extends State<MusicImage> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsetsDirectional.symmetric(vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(1000)
        ),
        elevation: 16,
        child: SizedBox(
          width: 325,
          height: 325,
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: widget.image,
            child: widget.image == null
            ? const Icon(Icons.image)
            : null,
          ),
        ),
      ),
    );
  }
}
