import 'package:behavior_bridge/features/subject/data/models/subject_model.dart';
import 'package:behavior_bridge/shared/core/constant/storage_keys.dart';
import 'package:behavior_bridge/shared/core/infrastructure/storage/local_store.dart';

class SubjectLocalDataSource {
  const SubjectLocalDataSource(this._store);
  final LocalStore _store;

  List<SubjectModel> readAll() => _store
      .readJsonList(StorageKeys.subjects)
      .map(SubjectModel.fromJson)
      .toList(growable: true);

  Future<void> writeAll(List<SubjectModel> items) async {
    await _store.writeJsonList(
      StorageKeys.subjects,
      items.map((e) => e.toJson()).toList(growable: false),
    );
  }

  Future<SubjectModel> upsert(SubjectModel item) async {
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
