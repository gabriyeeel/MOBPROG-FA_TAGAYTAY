import 'package:fa3_my_reading_list_expdisthmcrt/chart/chart_bar.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/constants.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/book.dart';
import 'package:fa3_my_reading_list_expdisthmcrt/models/genre_bucket.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.books});

  final List<Book> books;

  List<GenreBucket> get buckets {
    List<GenreBucket> result = [];

    for (final genre in Genre.values) {
      result.add(GenreBucket.forGenre(books, genre));
    }

    return result;
  }

  int get maxTotalBooks {
    int maxTotalBooks = 0;

    for (final bucket in buckets) {
      if (bucket.totalBooks > maxTotalBooks) {
        maxTotalBooks = bucket.totalBooks;
      }
    }

    return maxTotalBooks;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final scheme = Theme.of(context).colorScheme;
    final gradientColor = isDarkMode ? scheme.primary : scheme.secondary;

    return Container(
      margin: const EdgeInsets.fromLTRB(
        kPagePadding,
        kPagePadding,
        kPagePadding,
        8,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: kChartHeight,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            gradientColor.withOpacity(0.5),
            gradientColor.withOpacity(0.1),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(kCardRadius),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets)
                  ChartBar(
                    fill: bucket.totalBooks == 0
                        ? 0
                        : bucket.totalBooks / maxTotalBooks,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets.map((bucket) {
              return Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      genreIcons[bucket.genre],
                      color: scheme.onSurface,
                    ),
                    Text(
                      '${bucket.totalBooks}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: scheme.onSurface,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}