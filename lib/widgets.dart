// ignore_for_file: avoid_unnecessary_containers, must_be_immutable

import 'dart:math';
import 'package:flutter/material.dart';
import 'binary_time.dart';
import 'dart:async';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  BinaryTime _now = BinaryTime();

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 1), (v) {
      setState(() {
        _now = BinaryTime();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(50.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClockColumn(
            binaryInteger: _now.hourTens,
            title: 'H',
            color: Colors.blue,
            rows: 2,
          ),
          ClockColumn(
            binaryInteger: _now.hourOnes,
            title: 'h',
            color: Colors.lightBlue,
          ),
          ClockColumn(
            binaryInteger: _now.minuteTens,
            title: 'M',
            color: Colors.green,
            rows: 3,
          ),
          ClockColumn(
            binaryInteger: _now.minuteOnes,
            title: 'm',
            color: Colors.lightGreen,
          ),
          ClockColumn(
            binaryInteger: _now.secondTens,
            title: 'S',
            color: Colors.pink,
            rows: 3,
          ),
          ClockColumn(
            binaryInteger: _now.secondOnes,
            title: 's',
            color: Colors.pinkAccent,
          )
        ],
      ),
    );
  }
}

class ClockColumn extends StatelessWidget {
  final String binaryInteger;
  final String title;
  final Color color;
  final int rows;
  late List bits;

  ClockColumn(
      {super.key,
      required this.binaryInteger,
      required this.title,
      required this.color,
      this.rows = 4}) {
    bits = binaryInteger.split('');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ...[
          Container(
            child:
                Text(title, style: Theme.of(context).textTheme.headlineMedium),
          ),
        ],
        ...bits.asMap().entries.map((entry) {
          int idx = entry.key;
          String bit = entry.value;
          bool isActive = bit == '1';
          num binaryCellValue = pow(2, 3 - idx);
          return AnimatedContainer(
            duration: const Duration(milliseconds: 475),
            curve: Curves.ease,
            height: 40.0,
            width: 30.0,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(5.0),
                ),
                color: isActive
                    ? color
                    : idx < 4 - rows
                        ? Colors.white.withOpacity(0.0)
                        : Colors.black38),
            margin: const EdgeInsets.all(
              4.0,
            ),
            child: Center(
              child: isActive
                  ? Text(
                      binaryCellValue.toString(),
                      style: TextStyle(
                        color: Colors.black.withOpacity(0.2),
                        fontSize: 18.0,
                        fontWeight: FontWeight.w700,
                      ),
                    )
                  : Container(),
            ),
          );
        }),
        ...[
          Text(
            int.parse(binaryInteger, radix: 2).toString(),
            style: TextStyle(
              fontSize: 30.0,
              color: color,
            ),
          ),
          Container(
            child: Text(
              binaryInteger,
              style: TextStyle(
                fontSize: 15.0,
                color: color,
              ),
            ),
          )
        ]
      ],
    );
  }
}
