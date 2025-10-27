import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'picture_binary_converter.g.dart';

@riverpod
PictureBinaryConverter pictureBinaryConverter (Ref ref) {
  return PictureBinaryConverter();
}

class PictureBinaryConverter {
  Future<Uint8List> convertBoundaryToBytes(RenderRepaintBoundary boundary) async {
    ui.Image image = await boundary.toImage();
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List imageData = byteData!.buffer.asUint8List();
    return imageData;
  }

  ImageProvider convertBytesToImage(Uint8List imageData) {
    ImageProvider imageProvider = Image.memory(imageData).image;
    return imageProvider;
  }

  Future<Uint8List?> convertImageToBytes(ImageProvider imageProvider) async {
    final ImageStream stream = imageProvider.resolve(const ImageConfiguration());

    final Completer<ui.Image> completer = Completer<ui.Image>();
    late ImageStreamListener listener;

    listener = ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info.image);
      stream.removeListener(listener);
    });

    stream.addListener(listener);
    final ui.Image image = await completer.future;

    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png
    );

    if(byteData == null) return null;
    return byteData.buffer.asUint8List();
  }
}
