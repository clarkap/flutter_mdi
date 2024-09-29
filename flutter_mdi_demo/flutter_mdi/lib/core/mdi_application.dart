import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mdi/core/window_data.dart';
import 'package:flutter_mdi/core/window_manager.dart';
import 'mdi_window.dart';

class MDIApplication extends StatefulWidget {
  const MDIApplication({super.key});

  @override
  State<MDIApplication> createState() => _MDIApplicationState();
}

class _MDIApplicationState extends State<MDIApplication> {
  SystemMouseCursor _cursor = SystemMouseCursors.basic;

  String _selectedWindow = "";

  ResizeDirection resize = ResizeDirection.none;

  @override
  Widget build(BuildContext context) {
    final windowManager = DefaultWindowManager.of(context);

    return MouseRegion(
      hitTestBehavior: HitTestBehavior.translucent,
      cursor: _cursor,
      onHover: (event) {
        final WindowData? windowIdHit = windowManager
            .getWindows()
            .cast<WindowData?>()
            .firstWhere(
                (window) =>
                    window?.position.contains(event.localPosition) == true,
                orElse: () => null);

        var cursor = _cursor;

        if (windowIdHit != null) {
          _selectedWindow = windowIdHit.uuid;

          if (event.localPosition.dx > windowIdHit.position.right - 5) {
            cursor = SystemMouseCursors.resizeLeftRight;
            resize = ResizeDirection.right;
          } else if (event.localPosition.dx < windowIdHit.position.left + 5) {
            cursor = SystemMouseCursors.resizeLeftRight;
            resize = ResizeDirection.left;
          } else if (event.localPosition.dy < windowIdHit.position.top + 5) {
            cursor = SystemMouseCursors.resizeUpDown;
            resize = ResizeDirection.up;
          } else if (event.localPosition.dy > windowIdHit.position.bottom - 5) {
            cursor = SystemMouseCursors.resizeUpDown;
            resize = ResizeDirection.down;
          } else {
            cursor = SystemMouseCursors.basic;
            resize = ResizeDirection.none;
          }
        } else {
          _selectedWindow = "";
          cursor = SystemMouseCursors.basic;
          resize = ResizeDirection.none;
        }

        if (cursor != _cursor) {
          setState(() {
            _cursor = cursor;
          });
        }
      },
      child: GestureDetector(
        onVerticalDragUpdate: (event) {
          if (resize == ResizeDirection.up) {
            final window = windowManager.getWindowForId(_selectedWindow);
            setState(() {
              window.position = Rect.fromLTRB(
                  window.position.left,
                  event.localPosition.dy,
                  window.position.right,
                  window.position.bottom);
            });
          }

          if (resize == ResizeDirection.down) {
            final window = windowManager.getWindowForId(_selectedWindow);
            setState(() {
              window.position = Rect.fromLTRB(
                  window.position.left,
                  window.position.top,
                  window.position.right,
                  event.localPosition.dy);
            });
          }
        },
        onHorizontalDragUpdate: (event) {
          if (resize == ResizeDirection.left) {
            final window = windowManager.getWindowForId(_selectedWindow);
            setState(() {
              window.position = Rect.fromLTRB(
                  event.localPosition.dx,
                  window.position.top,
                  window.position.right,
                  window.position.bottom);
            });
          }

          if (resize == ResizeDirection.right) {
            final window = windowManager.getWindowForId(_selectedWindow);
            setState(() {
              window.position = Rect.fromLTRB(
                  window.position.left,
                  window.position.top,
                  event.localPosition.dx,
                  window.position.bottom);
            });
          }
        },
        child: StreamBuilder(
          stream: DefaultWindowManager.of(context).windowEvents,
          builder: (context, snapshot) {

            final windows = List.of(windowManager.getWindows());
            windows.sort((a,b)=> a.zOrder.compareTo(b.zOrder));

            return Container(
              color: Colors.white,
              child: Stack(
                children: [
                  ...windows.map((window) {
                    debugPrint("Outputting MDIWindows for $window");
                    return MDIWindow(id: window.uuid);
                  })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

enum ResizeDirection { up, down, left, right, none }
