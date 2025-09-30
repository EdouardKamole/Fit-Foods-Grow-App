import 'package:flutter/material.dart';
import '../../widgets/photo_upload_widget.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({super.key});

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {
  String? _capturedImagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plant Camera'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: _capturedImagePath != null
                  ? Image.file(_capturedImagePath! as dynamic)
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_alt, size: 80, color: Colors.grey),
                          SizedBox(height: 16),
                          Text('No photo captured'),
                        ],
                      ),
                    ),
            ),
            const SizedBox(height: 24),
            PhotoUploadWidget(
              onPhotoUploaded: (imagePath) {
                setState(() {
                  _capturedImagePath = imagePath;
                });
              },
              label: 'Capture Plant Growth',
            ),
            const SizedBox(height: 16),
            if (_capturedImagePath != null)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _analyzePlant,
                  icon: const Icon(Icons.analytics),
                  label: const Text('Analyze Plant Health'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _analyzePlant() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Plant Analysis'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('Plant is healthy'),
            ),
            ListTile(
              leading: Icon(Icons.warning, color: Colors.orange),
              title: Text('Needs more water'),
            ),
            ListTile(
              leading: Icon(Icons.lightbulb, color: Colors.yellow),
              title: Text('Consider more sunlight'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}