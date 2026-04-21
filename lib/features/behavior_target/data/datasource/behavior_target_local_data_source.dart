import 'package:behavior_bridge/features/behavior_target/data/models/behavior_target_model.dart';
import 'package:behavior_bridge/shared/core/constant/storage_keys.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

class BehaviorTargetLocalDataSource {
  const BehaviorTargetLocalDataSource(this._store);
  final LocalStore _store;

  List<BehaviorTargetModel> readAll() => _store
      .readJsonList(StorageKeys.behaviorTargets)
      .map(BehaviorTargetModel.fromJson)
      .toList(growable: true);

  Future<void> writeAll(List<BehaviorTargetModel> items) async {
    await _store.writeJsonList(
      StorageKeys.behaviorTargets,
      items.map((e) => e.toJson()).toList(growable: false),
    );
  }

  Future<BehaviorTargetModel> upsert(BehaviorTargetModel item) async {
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
