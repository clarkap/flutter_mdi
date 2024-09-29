
import 'package:flutter/widgets.dart';
import 'package:flutter_mdi/core/window_manager.dart';
import 'package:uuid/uuid.dart';

class WindowData with ChangeNotifier {
  final String uuid = const Uuid().v8();
  Rect position = const Rect.fromLTRB(0, 0, 100, 100);
  final WindowContentBuilder builder;
  String title;
  int zOrder = 10;



//<editor-fold desc="Data Methods">
  WindowData({
    required this.position,
    required this.builder,
    this.title = ""
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WindowData &&
          runtimeType == other.runtimeType &&
          uuid == other.uuid &&
          position == other.position &&
          builder == other.builder);

  @override
  int get hashCode => uuid.hashCode ^ position.hashCode ^ builder.hashCode;

  @override
  String toString() {
    return 'WindowData{ uuid: $uuid, position: $position, builder: $builder,}';
  }

  WindowData copyWith({
    String? uuid,
    Rect? position,
    WindowContentBuilder? builder,
  }) {
    return WindowData(
      position: position ?? this.position,
      builder: builder ?? this.builder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uuid': uuid,
      'position': position,
      'builder': builder,
    };
  }

  factory WindowData.fromMap(Map<String, dynamic> map) {
    return WindowData(
      position: map['position'] as Rect,
      builder: map['builder'] as WindowContentBuilder,
    );
  }


//</editor-fold>
}