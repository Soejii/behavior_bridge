import 'package:behavior_bridge/features/reinforcement_schedule/data/models/reinforcement_schedule_model.dart';
import 'package:behavior_bridge/shared/core/constant/storage_keys.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

class ReinforcementScheduleLocalDataSource {
  const ReinforcementScheduleLocalDataSource(this._store);
  final LocalStore _store;

  List<ReinforcementScheduleModel> readAll() => _store
      .readJsonList(StorageKeys.reinforcementSchedules)
      .map(ReinforcementScheduleModel.fromJson)
      .toList(growable: true);

  Future<void> writeAll(List<ReinforcementScheduleModel> items) async {
    await _store.writeJsonList(
      StorageKeys.reinforcementSchedules,
      items.map((e) => e.toJson()).toList(growable: false),
    );
  }

  Future<ReinforcementScheduleModel> upsert(
      ReinforcementScheduleModel item) async {
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
