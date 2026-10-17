import 'package:fa3_my_reading_list_expdisthmcrt/books/book_list.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/books/new_book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/books/reading_summary.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/chart/chart.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

class BooksScreen extends StatefulWidget {
  const BooksScreen({super.key, required this.toggleTheme});

  final void Function() toggleTheme;

  @override
  State<BooksScreen> createState() => _BooksScreenState();
}

class _BooksScreenState extends State<BooksScreen> {
  final List<Book> _books = [
    Book(
      title: 'Avengers: Infinity War',
      author: 'Marvel Comics',
      pages: 232,
      rating: 5,
      genre: Genre.fiction,
      status: ReadingStatus.reading,
    ),
    Book(
      title: "Harry Potter: Sorcerer's Stone",
      author: 'J.K. Rowling',
      pages: 309,
      rating: 5,
      genre: Genre.fantasy,
      status: ReadingStatus.finished,
    ),
    Book(
      title: 'Percy Jackson: Lightning Thief',
      author: 'Rick Riordan',
      pages: 377,
      rating: 4,
      genre: Genre.fantasy,
      status: ReadingStatus.wantToRead,
    ),
    Book(
      title: 'The Hunger Games',
      author: 'Suzanne Collins',
      pages: 374,
      rating: 5,
      genre: Genre.fiction,
      status: ReadingStatus.finished,
    ),
    Book(
      title: 'Steve Jobs',
      author: 'Walter Isaacson',
      pages: 656,
      rating: 4,
      genre: Genre.biography,
      status: ReadingStatus.reading,
    ),
  ];

  void _openBookModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => NewBook(addBook: _addBook),
    );
  }

  void _addBook(Book book) {
    setState(() {
      _books.add(book);
    });
  }

  void _updateStatus(Book book, ReadingStatus status) {
    setState(() {
      book.status = status;
    });
  }

  void _removeBook(Book book) {
    final bookIndex = _books.indexOf(book);

    setState(() {
      _books.remove(book);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Book removed.'),
        duration: Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _books.insert(bookIndex, book);
            });
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = const Center(
      child: Text('No books yet. Tap the + button to add one!'),
    );

    if (_books.isNotEmpty) {
      mainContent = BookList(
        books: _books,
        updateStatus: _updateStatus,
        removeBook: _removeBook,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('My Reading List'),
        actions: [
          IconButton(
            onPressed: widget.toggleTheme,
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          ),
          IconButton(
            onPressed: _openBookModal,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(books: _books),
          ReadingSummary(books: _books),
          Expanded(
            child: mainContent,
          ),
        ],
      ),
    );
  }
}