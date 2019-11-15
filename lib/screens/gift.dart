import 'package:flutter/Material.dart';
import 'package:flutter/rendering.dart';

class GiftScreen extends StatefulWidget {
  @override
  _GiftScreenState createState() => _GiftScreenState();
}

class _GiftScreenState extends State<GiftScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'Gift Screen',
        ),
      ),
    );
  }
}
