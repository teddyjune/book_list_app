import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:untitled/model/book.dart';


class UpdateBookViewModel {
  final _db = FirebaseFirestore.instance
      .collection('books')
      .withConverter<Book>(
  fromFirestore: (snapshot, _) => Book.fromJson(snapshot.data()!),
  toFirestore: (book, _) => book.toJson());
  void updateBook(
      {required String id, required String title, required String author}) {
    bool isValid = title.isNotEmpty && author.isNotEmpty;
    if (isValid) {
      _db.doc(id).set(Book
        (title: title, author: author, imageUrl: imageUrl));
    } else if (title.isEmpty && author.isEmpty) {
      throw '모두 입력해주세요';
    } else if (title.isEmpty) {
      throw '제목을 입력해주세요';
    } else if (author.isEmpty) {
      throw '저자를 입력해주세요';
    }
  }
}
