import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/add_book/add_book_view_model.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({Key? key}) : super(key: key);

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleTextController = TextEditingController();
  final _authorTextController = TextEditingController();

  final viewModel = AddBookViewModel();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _bytes;

  @override
  void dispose() {
    _titleTextController.dispose();
    _authorTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('도서 추가'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () async {
                XFile? image =
                    await _picker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  _bytes = await image.readAsBytes();
                  setState(() {});
                }
              },
              child: _bytes == null
                  ? Container(
                      width: 200,
                      height: 200,
                      color: Colors.grey,
                    )
                  : Image.memory(_bytes!, width: 200, height: 200),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _titleTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '제목',
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _authorTextController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: '저자',
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          viewModel.addBook(
            title: _titleTextController.text,
            author: _authorTextController.text,
            bytes: _bytes,
          );
          Navigator.pop(context);
        },
        child: const Icon(Icons.done),
      ),
    );
  }
}
