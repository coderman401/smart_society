import 'dart:io';
import 'package:builders_group/src/shared/widgets/app_text_field.dart';
import 'package:builders_group/src/shared/widgets/dashed_box.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddEditForum extends StatefulWidget {
  const AddEditForum({super.key});
  @override
  State<AddEditForum> createState() => _AddEditForumState();
}

class _AddEditForumState extends State<AddEditForum> {
  File? _image;
  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post New')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppTextField(label: 'Title', hint: 'Enter title', maxLines: 1),
            AppTextField(
              label: 'Description',
              hint: 'Enter description',
              maxLines: 5,
            ),

            _image != null
                ? Container(
                  height: 200,
                  width: double.infinity,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(children: [Image.file(_image!, height: 200)]),
                )
                : DashedBorderBox(
                  height: 100,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: GestureDetector(
                    onTap: _pickImage,
                    child: Center(child: Text('Click to add images')),
                  ),
                ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Handle save action
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
