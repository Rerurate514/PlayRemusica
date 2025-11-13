import 'package:flutter/material.dart';
import 'package:playremusica/core/settings/my_colors.dart';
import 'package:playremusica/domain/entities/picture_image.dart';
import 'package:playremusica/presentation/widgets/gradient_icon.dart';

class ListViewMusicPicture extends StatelessWidget {
  final PictureImage pictureImage;
  const ListViewMusicPicture({
    super.key,
    required this.pictureImage
  });

  @override
  Widget build(BuildContext context) {
    final image = pictureImage.imageProvider;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: image != null
      ? Image(image: image)
      : GradientIcon(icon: Icons.image, size: 32, gradient: MyColors.iconGradient),
    );
  }
}
