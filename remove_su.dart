import 'dart:io';

void main() {
  final libDir = Directory('lib');
  final files = libDir
      .listSync(recursive: true)
      .whereType<File>()
      .where((f) => f.path.endsWith('.dart'));

  for (final file in files) {
    var content = file.readAsStringSync();
    var original = content;

    // Remove import
    content = content.replaceAll(
        RegExp(r"import 'package:flutter_screenutil/flutter_screenutil\.dart';\r?\n"), '');

    // Replace .w, .h, .sp, .r only on numbers or simple variable identifiers
    // e.g. 10.w, 14.5.sp, width.w
    // Negative lookbehind ensures we don't replace things inside strings or random dart properties, though .w is rare.
    content = content.replaceAllMapped(RegExp(r"\.([whr]|sp)\b"), (match) {
      return '';
    });

    if (content != original) {
      file.writeAsStringSync(content);
      print('Updated: ${file.path}');
    }
  }
}
