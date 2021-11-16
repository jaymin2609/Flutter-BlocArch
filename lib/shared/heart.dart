import 'package:flutter/material.dart';

class Heart extends StatefulWidget {
  @override
  _HeartState createState() => _HeartState();
}

class _HeartState extends State<Heart> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _colorAnimation;
  Animation _sizeAnimation;
  Animation _curve;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(milliseconds: 300), vsync: this);


    _curve=CurvedAnimation(parent: _controller,curve: Curves.slowMiddle);

    _colorAnimation = ColorTween(begin: Colors.grey[400], end: Colors.red)
        .animate(_curve);

    _sizeAnimation = TweenSequence(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 30.0, end: 50.0), weight: 50),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 50.0, end: 30.0), weight: 50)
    ]).animate(_curve);


    _controller.addListener(() {
      print(_controller.value);
      print(_colorAnimation.value);
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isFav = false;
        });
      }
      if (status == AnimationStatus.completed) {
        setState(() {
          isFav = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, _) {
        return IconButton(
          icon: Icon(
            Icons.favorite,
            color: _colorAnimation.value,
            size: _sizeAnimation.value,
          ),
          onPressed: () {
            isFav ? _controller.reverse() : _controller.forward();
          },
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
