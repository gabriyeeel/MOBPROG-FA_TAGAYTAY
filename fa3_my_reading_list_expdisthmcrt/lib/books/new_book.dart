import 'package:fa3_my_reading_list_expdisthmcrt/constants.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

class NewBook extends StatefulWidget {
  const NewBook({super.key, required this.addBook});

  final void Function(Book) addBook;

  @override
  State<NewBook> createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _pagesController = TextEditingController();
  final _ratingController = TextEditingController();
  Genre _selectedGenre = Genre.fiction;
  ReadingStatus _selectedStatus = ReadingStatus.wantToRead;

  void _submitBookData() {
    int? pages = int.tryParse(_pagesController.text.trim());
    int? rating = int.tryParse(_ratingController.text.trim());
    String errors = '';

    if (_titleController.text.trim().isEmpty) {
      errors += '\n- Title cannot be empty.';
    }

    if (_authorController.text.trim().isEmpty) {
      errors += '\n- Author cannot be empty.';
    }

    if (pages == null || pages <= 0 || pages > kMaxPages) {
      errors += '\n- Pages must be a whole number from 1 to $kMaxPages.';
    }

    if (rating == null || rating < kMinRating || rating > kMaxRating) {
      errors +=
          '\n- Rating must be a whole number from $kMinRating to $kMaxRating.';
    }

    if (errors.isNotEmpty) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please fix the following:$errors'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );

      return;
    }

    Book newBook = Book(
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      pages: pages!,
      rating: rating!,
      genre: _selectedGenre,
      status: _selectedStatus,
    );

    widget.addBook(newBook);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Book Added'),
        content: Text('Your book has been added successfully.'
        '\nTitle: ${newBook.title},'
        '\nAuthor: ${newBook.author},'
        '\nPages: ${newBook.pages},'
        '\nRating: ${newBook.rating},'
        '\nGenre: ${genreLabels[newBook.genre]},'
        '\nStatus: ${statusLabels[newBook.status]}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _pagesController.dispose();
    _ratingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          kPagePadding,
          kPagePadding,
          kPagePadding,
          kPagePadding + keyboardSpace,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              maxLength: kMaxTextLength,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text('Title'),
              ),
            ),
            TextField(
              controller: _authorController,
              maxLength: kMaxTextLength,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                label: Text('Author'),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _pagesController,
                    maxLength: 5,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Pages'),
                      counterText: '',
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextField(
                    controller: _ratingController,
                    maxLength: 2,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      label: Text('Rating (1-5)'),
                      counterText: '',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Genre', style: Theme.of(context).textTheme.bodySmall),
                      DropdownButton<Genre>(
                        isExpanded: true,
                        value: _selectedGenre,
                        items: Genre.values
                            .map(
                              (genre) => DropdownMenuItem(
                                value: genre,
                                child: Text(genreLabels[genre]!),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedGenre = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Status', style: Theme.of(context).textTheme.bodySmall),
                      DropdownButton<ReadingStatus>(
                        isExpanded: true,
                        value: _selectedStatus,
                        items: ReadingStatus.values
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(statusLabels[status]!),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _selectedStatus = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submitBookData,
                  child: Text('Save Book'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}