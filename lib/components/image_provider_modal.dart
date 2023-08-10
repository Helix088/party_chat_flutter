import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ImageProviderModel extends ChangeNotifier {
  XFile? _imageFile;

  XFile? get imageFile => _imageFile;

  get imageUrl => null;

  void setImageFile(XFile? imageFile) {
    _imageFile = imageFile;
    notifyListeners();
  }
}
