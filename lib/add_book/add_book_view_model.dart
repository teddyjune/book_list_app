import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:untitled/model/book.dart';

class AddBookViewModel {
  final _db = FirebaseFirestore.instance
      .collection('books')
      .withConverter<Book>(
          fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data()!),
          toFirestore: (book, _) => book.toJson());
  final _storage = FirebaseStorage.instance;
  bool isLoading = false;

  void startLoading() {
    isLoading = true;
  }

  void endLoading() {
    isLoading = false;
  }

  Future<String> uploadImage(String title, Uint8List bytes) async {
    final storageRef = _storage.ref('book_cover/$title.jpg');
    await storageRef.putData(bytes);
    final String downloadUrl = await storageRef.getDownloadURL();
    return downloadUrl;
  }

  Future addBook({
    required String title,
    required String author,
    //사진 데이터 받음
    required Uint8List? bytes,
  }) async {
    // 빈 문서 (ID를 미리 얻을 때)
    final doc = _db.doc();

    // 이미지 업로드하고 다운로드 URL 얻기
    String downloadUrl = await uploadImage(doc.id, bytes!);

    // 문서 덮어쓰기
    await _db
        .doc(doc.id)
        .set(Book(title: title, author: author, imageUrl: downloadUrl));
  }

  bool isValid(String title, String author) {
    return title.isEmpty || author.isEmpty;
  }
}
