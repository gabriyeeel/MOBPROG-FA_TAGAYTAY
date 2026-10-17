import 'package:flutter/material.dart';

enum Genre {
  fiction,
  nonFiction,
  fantasy,
  biography,
}

enum ReadingStatus {
  wantToRead,
  reading,
  finished,
}

const genreLabels = {
  Genre.fiction: 'Fiction',
  Genre.nonFiction: 'Non-Fiction',
  Genre.fantasy: 'Fantasy',
  Genre.biography: 'Biography',
};

const genreIcons = {
  Genre.fiction: Icons.menu_book,
  Genre.nonFiction: Icons.lightbulb,
  Genre.fantasy: Icons.auto_awesome,
  Genre.biography: Icons.person,
};

const statusLabels = {
  ReadingStatus.wantToRead: 'Want to Read',
  ReadingStatus.reading: 'Reading',
  ReadingStatus.finished: 'Finished',
};

const statusIcons = {
  ReadingStatus.wantToRead: Icons.bookmark,
  ReadingStatus.reading: Icons.auto_stories,
  ReadingStatus.finished: Icons.check_circle,
};

class Book {
  Book({
    required this.title,
    required this.author,
    required this.pages,
    required this.rating,
    required this.genre,
    required this.status,
  });

  final String title;
  final String author;
  final int pages;
  final int rating;
  final Genre genre;
  ReadingStatus status;
}