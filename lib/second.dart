import 'package:apitest/first.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class secondPage extends StatefulWidget {
  secondPage(this.data);
  var data;
  @override
  _secondPageState createState() => _secondPageState();
}

class _secondPageState extends State<secondPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => firstScreen()));
                  },
                  child: Text("Take Measurement Again")),
              Cardx("Neck", widget.data['d']['neck']),
              Cardx("Height", widget.data['d']['height']),
              Cardx("Weight", widget.data['d']['weight']),
              Cardx("Belly", widget.data['d']['belly']),
              Cardx("Chest", widget.data['d']['chest']),
              Cardx("Wrist", widget.data['d']['wrist']),
              Cardx("Arm-Length", widget.data['d']['armLength']),
              Cardx("Thigh", widget.data['d']['thigh']),
              Cardx("Shoulder", widget.data['d']['shoulder']),
              Cardx("Hips", widget.data['d']['hips']),
              Cardx("Ankle", widget.data['d']['ankle']),
            ],
          ),
        ),
      ),
    );
  }
}

class Cardx extends StatelessWidget {
  String keys, value;
  Cardx(@required this.keys, this.value);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 10, left: 3, right: 3),
      padding: EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
          border: Border.all(
        color: Colors.grey,
      )),
      height: 50,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(keys),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
