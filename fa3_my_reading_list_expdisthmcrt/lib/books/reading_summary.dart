import 'package:fa3_my_reading_list_expdisthmcrt/constants.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:flutter/material.dart';

class ReadingSummary extends StatelessWidget {
  const ReadingSummary({super.key, required this.books});

  final List<Book> books;

  int countByStatus(ReadingStatus status) {
    int count = 0;

    for (final book in books) {
      if (book.status == status) {
        count++;
      }
    }

    return count;
  }

  double get averageRating {
    double sum = 0;
    int count = 0;

    for (final book in books) {
      if (book.status == ReadingStatus.finished) {
        sum += book.rating;
        count++;
      }
    }

    if (count == 0) {
      return 0;
    }

    return sum / count;
  }

  Widget _buildStat(BuildContext context, String label, int value) {
    return Expanded(
      child: Column(
        children: [
          Text('$value', style: Theme.of(context).textTheme.titleLarge),
          Text(
            label,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: kPagePadding,
        vertical: 8,
      ),
      padding: const EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              _buildStat(context, 'Total', books.length),
              _buildStat(
                context,
                'Want to Read',
                countByStatus(ReadingStatus.wantToRead),
              ),
              _buildStat(
                context,
                'Reading',
                countByStatus(ReadingStatus.reading),
              ),
              _buildStat(
                context,
                'Finished',
                countByStatus(ReadingStatus.finished),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            countByStatus(ReadingStatus.finished) == 0
                ? 'Average rating of finished books: none yet'
                : 'Average rating of finished books: '
                    '${averageRating.toStringAsFixed(1)} / $kMaxRating',
            style: Theme.of(context).textTheme.titleSmall,
          ),
        ],
      ),
    );
  }
}