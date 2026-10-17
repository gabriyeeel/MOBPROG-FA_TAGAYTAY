import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  const BookItem(
    this.book, {
    super.key,
    required this.updateStatus,
  });

  final Book book;
  final void Function(Book, ReadingStatus) updateStatus;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              book.title,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              'by ${book.author}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(genreIcons[book.genre]),
                const SizedBox(width: 5),
                Text(
                  genreLabels[book.genre]!,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                const Spacer(),
                Text(
                  '${book.pages} pages',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            ),
            Row(
              children: [
                for (int i = 0; i < book.rating; i++)
                  Icon(
                    Icons.star,
                    size: 18,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                const Spacer(),
                DropdownButton<ReadingStatus>(
                  value: book.status,
                  items: ReadingStatus.values
                      .map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Row(
                            children: [
                              Icon(statusIcons[status]),
                              const SizedBox(width: 6),
                              Text(statusLabels[status]!),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value == null) {
                      return;
                    }
                    updateStatus(book, value);
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}