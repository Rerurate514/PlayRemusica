import 'package:flutter/material.dart';

class InkCard extends StatelessWidget{
  final Function() onTap;
  final Widget child;
  final double radius;
  final double padding;

  const InkCard({
    super.key, 
    required this.onTap, 
    required this.child,
    this.radius = 16.0,
    this.padding = 0.0,
  });

  @override
  Widget build(BuildContext context){
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius)
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(radius),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(padding),
          child: child
        )
      ),
    );
  }
}
