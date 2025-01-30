// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:companion/src/core/services/service_locator.dart';
import 'package:companion/src/features/hisab_kitab/domain/entity/hisab_kitab_entity.dart';
import 'package:companion/src/features/hisab_kitab/presentation/notifiers/hisab_kitab_filter_provider.dart';
import 'package:drift/drift.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'hisab_kitab_notifier.g.dart';

@riverpod
class PartyNotifier extends _$PartyNotifier {
  @override
  Stream<List<PartyEntity>> build() {
    final filterProvider = ref.watch(hisabKitabFilterProvider);
    final database = ref.watch(databaseProvider);

    return database.managers.partyTable
        .filter((f) => f.type.equals(filterProvider.type))
        .filter(
          (f) => f.name.contains(
            filterProvider.searchText,
            caseInsensitive: true,
          ),
        )
        .limit(filterProvider.limit)
        .map(PartyEntity.fromModel)
        .watch();
  }
}
