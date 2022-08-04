import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                bool isValid = _titleTextController.text.isNotEmpty &&
                    _authorTextController.text.isNotEmpty;
                if (isValid) {
                  viewModel.updateBook(
                    id: widget.document.id,
                    title: _titleTextController.text,
                    author: _authorTextController.text,
                  );
                  Navigator.pop(context);
                } else {
                  const snackBar = SnackBar(
                    content: Text('제목과 저자를 입력해 주세요'),
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
