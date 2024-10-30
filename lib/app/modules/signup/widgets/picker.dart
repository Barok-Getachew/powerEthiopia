import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickView extends StatefulWidget {
  const ImagePickView({super.key});

  @override
  _ImagePickViewState createState() => _ImagePickViewState();
}

class _ImagePickViewState extends State<ImagePickView> {
  String _selectedFileName = '';

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedFileName = pickedFile.path.split('/').last;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _pickImage,
          child: Text(
            'Browse Files',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: Colors.white),
          ),
        ),
        const SizedBox(height: 5),
        Center(
          child: Text(
            _selectedFileName,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
