import 'package:behavior_bridge/features/daily_log/data/models/daily_log_model.dart';
import 'package:behavior_bridge/shared/core/constant/storage_keys.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

class DailyLogLocalDataSource {
  const DailyLogLocalDataSource(this._store);
  final LocalStore _store;

  List<DailyLogModel> readAll() => _store
      .readJsonList(StorageKeys.dailyLogs)
      .map(DailyLogModel.fromJson)
      .toList(growable: true);

  Future<void> writeAll(List<DailyLogModel> items) async {
    await _store.writeJsonList(
      StorageKeys.dailyLogs,
      items.map((e) => e.toJson()).toList(growable: false),
    );
  }

  Future<DailyLogModel> upsert(DailyLogModel item) async {
    final all = readAll();
    final idx = all.indexWhere((e) => e.id == item.id);
    if (idx >= 0) {
      all[idx] = item;
    } else {
      all.add(item);
    }
    await writeAll(all);
    return item;
  }

  Future<void> remove(String id) async {
    final all = readAll()..removeWhere((e) => e.id == id);
    await writeAll(all);
  }
}
