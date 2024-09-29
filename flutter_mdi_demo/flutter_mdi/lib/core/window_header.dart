import 'package:flutter/material.dart';

class WindowHeader extends StatefulWidget {
  final Function(double x, double y) onMove;

  const WindowHeader({super.key, required this.onMove});

  @override
  State<WindowHeader> createState() => _WindowHeaderState();
}

class _WindowHeaderState extends State<WindowHeader> {
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      decoration: const ShapeDecoration(
        color: Color(0xFF555555),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(8.0),
            topRight: Radius.circular(8.0),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Listener(
          behavior: HitTestBehavior.translucent,
          onPointerDown: (event) {
            setState(() {
              _isSelected = true;
            });
          },
          onPointerUp: (event) {
            setState(() {
              _isSelected = false;
            });
          },
          onPointerMove: (event) {
            if (_isSelected) {
              widget.onMove(event.delta.dx, event.delta.dy);
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flex(
                direction: Axis.horizontal,
                children: [
                  IconButton(
                    constraints:
                        const BoxConstraints.tightFor(width: 12, height: 12),
                    onPressed: () {
                      debugPrint("Pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      // styling the button
                      shape: const CircleBorder(),
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.zero,
                      // Button color
                      foregroundColor: Colors.cyan, // Splash color
                    ),
                    icon: const Icon(Icons.close,
                        size: 8, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    constraints:
                        const BoxConstraints.tightFor(width: 12, height: 12),
                    onPressed: () {
                      debugPrint("Pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      // styling the button
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.amber,
                      // Button color
                      foregroundColor: Colors.cyan, // Splash color
                    ),
                    icon: const Icon(Icons.minimize_outlined,
                        size: 8, color: Colors.white),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  IconButton(
                    constraints:
                        const BoxConstraints.tightFor(width: 12, height: 12),
                    onPressed: () {
                      debugPrint("Pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      // styling the button
                      shape: const CircleBorder(),
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.green,
                      // Button color
                      foregroundColor: Colors.cyan, // Splash color
                    ),
                    icon: const Icon(Icons.minimize_outlined,
                        size: 8, color: Colors.white),
                  ),
                ],
              ),
              Expanded(
                  child: Text("Title",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          !.copyWith(color: Colors.white)))
            ],
          ),
        ),
      ),
    );
  }
}
