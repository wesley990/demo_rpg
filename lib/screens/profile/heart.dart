import 'package:demo_rpg/models/character.dart';
import 'package:flutter/material.dart';

class HeartIcon extends StatefulWidget {
  const HeartIcon({super.key, required this.character});

  final Character character;

  @override
  HeartIconState createState() => HeartIconState();
}

class HeartIconState extends State<HeartIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _sizeAnimation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    // tween from 0.0 to 1.0
    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 25.0, end: 40.0)
              .chain(CurveTween(curve: Curves.easeIn)),
          weight: 50,
        ),
        TweenSequenceItem<double>(
          tween: Tween<double>(begin: 40.0, end: 25.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 50,
        ),
      ],
    ).animate(_controller);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return IconButton(
          icon: const Icon(Icons.favorite),
          color: widget.character.isFavorite ? Colors.red : Colors.grey[800],
          iconSize: _sizeAnimation.value,
          onPressed: () {
            _controller.reset();
            _controller.forward();
            _toggleFavorite();
          },
        );
      },
    );
  }

  void _toggleFavorite() {
    setState(() {
      widget.character.toggleFavorite();
    });
  }
}
