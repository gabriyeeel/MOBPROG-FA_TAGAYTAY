import 'package:fa3_my_reading_list_expdisthmcrt/books/book_item.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

class BookList extends StatelessWidget {
  const BookList({
    super.key,
    required this.books,
    required this.updateStatus,
    required this.removeBook,
  });

  final List<Book> books;
  final void Function(Book, ReadingStatus) updateStatus;
  final void Function(Book) removeBook;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (ctx, index) {
        return Dismissible(
          background: Container(
            color: Theme.of(context).colorScheme.error.withOpacity(0.2),
            margin: Theme.of(context).cardTheme.margin,
          ),
          key: ValueKey(books[index]),
          onDismissed: (direction) {
            removeBook(books[index]);
          },
          child: BookItem(
            books[index],
            updateStatus: updateStatus,
          ),
        );
      },
    );
  }
}