import 'dart:io';
import 'package:image_picker/image_picker.dart';

class StorageService {
  static final StorageService _instance = StorageService._internal();
  factory StorageService() => _instance;
  StorageService._internal();

  final ImagePicker _imagePicker = ImagePicker();

  Future<File?> pickImage() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<File?> takePhoto() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.camera);
    if (image != null) {
      return File(image.path);
    }
    return null;
  }

  Future<String> uploadImage(File image, String path) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'https://example.com/images/$path';
  }

  Future<void> deleteImage(String url) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}