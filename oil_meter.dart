
import 'package:flutter/material.dart';
class OilMeter extends StatelessWidget {
  final int oil;
  const OilMeter({super.key, required this.oil});
  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(children:[const Icon(Icons.local_fire_department,color:Colors.orange,size:18), const SizedBox(width:6), const Text('Oil / Lamp'), const Spacer(), Text('$oil/100')]),
        const SizedBox(height:6),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(value: oil/100, minHeight: 10, color: Color.lerp(Colors.red, Colors.amber, oil/100)!, backgroundColor: Colors.black12),
        ),
      ],
    );
  }
}
