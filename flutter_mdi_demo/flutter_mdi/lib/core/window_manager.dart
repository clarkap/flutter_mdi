import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_mdi/core/window_data.dart';

abstract class MDIWindowManager{}

typedef WindowContentBuilder = Widget Function( BuildContext );

final Map< String, WindowData> _windows = {};

class DefaultWindowManager extends InheritedWidget implements MDIWindowManager  {
  DefaultWindowManager({super.key, required super.child});


  final StreamController<String> _windowEvents = StreamController<String>();
  StreamSink<String> get _sink => _windowEvents.sink;
  Stream<String> get windowEvents => _windowEvents.stream;


  String createWindow( {required WindowContentBuilder build} )
  {
    final data = WindowData( position: const Rect.fromLTWH(100, 100, 200, 200), builder: build);
    _windows[data.uuid] = data;

    debugPrint("Windows: ${_windows.values}");

    _sink.add(data.uuid);

    return data.uuid;
  }

  WindowData getWindowForId( String id){
    final window = _windows[id];
    if ( window != null ) return window;

    throw FlutterError("Window Id Not Managed");
  }

  void moveWindow( { required String id, required Offset offset }){
    var window = _windows[id];

    if ( window != null ){
      var windowPosition = window.position;
      window.position = windowPosition.shift(offset);
    }
   }

   void closeWindow( {required String id }){

    final result = _windows.remove(id);
    if ( result != null ){
      _sink.add(id);
    }

   }

   List<WindowData> getWindows() => List.unmodifiable(_windows.values);

  static DefaultWindowManager of(BuildContext context) {
    final DefaultWindowManager? result =
    context.dependOnInheritedWidgetOfExactType<DefaultWindowManager>();
    assert(result != null, 'No DefaultWindowManager found in context');
    return result!;
  }


  @override
  bool updateShouldNotify(DefaultWindowManager old) {
    return true;
  }


}
