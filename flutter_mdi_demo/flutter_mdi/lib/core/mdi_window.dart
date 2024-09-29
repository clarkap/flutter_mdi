import 'package:flutter/material.dart';
import 'package:flutter_mdi/core/window_header.dart';
import 'package:flutter_mdi/core/window_manager.dart';

class MDIWindow extends StatefulWidget {
  const MDIWindow({required this.id, super.key});

  final String id;

  @override
  State<MDIWindow> createState() => _MDIWindowState();
}

class _MDIWindowState extends State<MDIWindow> {
  double minWidth = 1;
  double minHeight = 1;

  @override
  Widget build(BuildContext context) {

    final windowManager = DefaultWindowManager.of(context);
    final windowData = windowManager.getWindowForId( widget.id );

    return Positioned(
      top: windowData.position.top,
      left: windowData.position.left,
      child: SizedBox(
        height: windowData.position.height,
        width: windowData.position.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            WindowHeader(
              onMove: (dx, dy) {
                setState(() {
                  debugPrint("onMove: $dx, $dy");
                  DefaultWindowManager.of(context).moveWindow(id: widget.id, offset: Offset( dx,dy));
                });
              },
            ),
            Expanded(
              child: _WindowChrome(
                child: _WindowContent(
                  child: windowData.builder.call( context ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _WindowContent extends StatelessWidget {
  final Widget child;

  const _WindowContent({required this.child});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
        onHover: (event) {
          //debugPrint("_WindowContent: onHover: $event");
        },
        child: GestureDetector(child: child));
  }
}

class _WindowChrome extends StatelessWidget {
  final Widget child;

  const _WindowChrome({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0),
          ),
        ),
      ),
      child: child,
    );
  }
}

