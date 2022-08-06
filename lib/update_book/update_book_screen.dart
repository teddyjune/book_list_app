import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:untitled/update_book/update_book_view_model.dart';

class UpdateBookScreen extends StatefulWidget {
  final DocumentSnapshot document;

  const UpdateBookScreen(this.document, {Key? key}) : super(key: key);

  @override
  State<UpdateBookScreen> createState() => _UpdateBookScreenState();
}

class _UpdateBookScreenState extends State<UpdateBookScreen> {
  final _titleTextController = TextEditingController();
  final _authorTextController = TextEditingController();
  final viewModel = UpdateBookViewModel();
  final ImagePicker _picker = ImagePicker();
  Uint8List? _bytes;

  @override
  void initState() {
    super.initState();
    _titleTextController.text = widget.document['title'];
    _authorTextController.text = widget.document['author'];
  }

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
        title: const Text('도서 수정'),
      ),
      body: Column(
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
                ? Image.network(downloadUrl.toString(),
                width: 200, height: 200)
                : Image.memory(_bytes!, width: 200, height: 200),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (_) {
                setState(() {});
              },
              controller: _titleTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '제목',
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (_) {
                setState(() {});
              },
              controller: _authorTextController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: '저자',
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                try {
                  // 에러가 날 것 같은 코드
                  viewModel.updateBook(
                    id: widget.document.id,
                    title: _titleTextController.text,
                    author: _authorTextController.text,
                    bytes: _bytes,
                  );

                  Navigator.pop(context);
                } catch (e) {
                  // 에러가 났을 때
                  final snackBar = SnackBar(
                    content: Text(e.toString()),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                }
              },
              child: const Text('수정 버튼')),
        ],
      ),
    );
  }
}
