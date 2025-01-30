// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:companion/src/core/database/tables.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HisabKitabFilter {
  final String searchText;
  final PartyType type;
  final int limit;

  HisabKitabFilter({
    required this.searchText,
    required this.type,
    required this.limit,
  });

  HisabKitabFilter copyWith({
    String? searchText,
    PartyType? type,
    int? limit,
  }) {
    return HisabKitabFilter(
      searchText: searchText ?? this.searchText,
      type: type ?? this.type,
      limit: limit ?? this.limit,
    );
  }
}

final hisabKitabFilterProvider = StateProvider<HisabKitabFilter>(
  (ref) {
    return HisabKitabFilter(
      searchText: "",
      type: PartyType.customer,
      limit: 10,
    );
  },
);
