import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';

class GenreBucket {
  const GenreBucket({
    required this.genre,
    required this.books,
  });

  final Genre genre;
  final List<Book> books;

  GenreBucket.forGenre(List<Book> allBooks, this.genre)
      : books = allBooks.where((book) => book.genre == genre).toList();

  int get totalBooks {
    return books.length;
  }
}