import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FABMenuWidget extends ConsumerStatefulWidget {
  const FABMenuWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<FABMenuWidget> createState() => _FABMenuWidgetState();
}

class _FABMenuWidgetState extends ConsumerState<FABMenuWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  bool _isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleMenu() {
    if (_isMenuOpen) {
      _animationController.reverse();
    } else {
      _animationController.forward();
    }
    setState(() {
      _isMenuOpen = !_isMenuOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        if (_isMenuOpen)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: GestureDetector(
              onTap: _toggleMenu,
            ),
          ),
        Positioned(
          bottom: 100,
          right: 16,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
            ),
            child: FloatingActionButton.small(
              heroTag: 'fab_voice',
              onPressed: () {
                _toggleMenu();
                // TODO: Implement voice input
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Voice input coming soon')),
                );
              },
              child: const Icon(Icons.mic),
            ),
          ),
        ),
        Positioned(
          bottom: 160,
          right: 16,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0, end: 1).animate(
              CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
            ),
            child: FloatingActionButton.small(
              heroTag: 'fab_camera',
              onPressed: () {
                _toggleMenu();
                // TODO: Implement camera/OCR input
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Camera input coming soon')),
                );
              },
              child: const Icon(Icons.camera_alt),
            ),
          ),
        ),
        FloatingActionButton(
          heroTag: 'fab_main',
          onPressed: _toggleMenu,
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow,
            progress: _animationController,
          ),
        ),
      ],
    );
  }
}
