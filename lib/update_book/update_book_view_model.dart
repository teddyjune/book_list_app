import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/model/book.dart';

class UpdateBookViewModel {
  final _db = FirebaseFirestore.instance
      .collection('books')
      .withConverter<Book>(
          fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data()!),
          toFirestore: (book, _) => book.toJson());
  final _storage = FirebaseStorage.instance;

  Future<String> uploadImage(String title, Uint8List bytes) async {
    final storageRef = _storage.ref('book_cover/$title.jpg');
    await storageRef.putData(bytes);
    final String downloadUrl = await storageRef.getDownloadURL();
    return downloadUrl;
  }

  void updateBook({
    required String id,
    required String title,
    required String author,
    required Uint8List? bytes,
  }) async {
    final doc = _db.doc();
    String downloadUrl = await uploadImage(doc.id, bytes!);

    bool isValid = title.isNotEmpty && author.isNotEmpty;
    if (isValid) {
      _db
          .doc(id)
          .set(Book(title: title, author: author, imageUrl: downloadUrl));
    } else if (title.isEmpty && author.isEmpty && bytes == null) {
      throw '모두 입력해주세요';
    } else if (title.isEmpty) {
      throw '제목을 입력해주세요';
    } else if (author.isEmpty) {
      throw '저자를 입력해주세요';
    } else if (downloadUrl.isEmpty) {
      throw '책표지를 넣어주세요';
    }
  }
}
