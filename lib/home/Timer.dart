import 'dart:async';
import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  const TimerPage({super.key});

  @override
  State<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Color bgcolor = Colors.black12;
  Color highlight = Colors.white10;

  List<dynamic> lapsList = [];

  Timer? _timer;
  int _elapsedMilliseconds = 0;

  bool isStart = false;
  bool isPause = false;

  String timeFormat(int milliseconds) {
    final Duration duration = Duration(milliseconds: milliseconds);
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String hour = twoDigits(duration.inHours);
    String min = twoDigits(duration.inMinutes.remainder(60));
    String sec = twoDigits(duration.inSeconds.remainder(60));
    String millis = ((milliseconds % 1000) ~/ 10).toString().padLeft(2, '0'); // Convert to two digits
    return '$hour:$min:$sec:$millis';
  }

  void startWatch() {
    if (!isStart) {
      _timer = Timer.periodic(Duration(milliseconds: 100), (timer) {
        setState(() {
          _elapsedMilliseconds += 100; // Increment by 100 milliseconds
        });
      });
      setState(() {
        isStart = true;
        isPause = false;
      });
    }
  }

  void pauseWatch() {
    _timer?.cancel();
    setState(() {
      isPause = true;
      isStart = false;
    });
  }

  void reset() {
    _timer?.cancel();
    _elapsedMilliseconds = 0;
    lapsList.clear();
    setState(() {
      isStart = false;
      isPause = false;
    });
  }

  void stop() {
    _timer?.cancel();
    _elapsedMilliseconds = 0;
    setState(() {
      isStart = false;
      isPause = false;
    });
  }

  void laps() {
    lapsList.add({
      'lap': 'LAP ${lapsList.length + 1}',
      'time': timeFormat(_elapsedMilliseconds)
    });
  }

  void deleteLap(int index) {
    setState(() {
      lapsList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.pink[300],
        ),
        backgroundColor: Colors.white12,
        title: Text(
          "Timer",
          style: TextStyle(color: Colors.pink[300]),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 50),
          Center(
            child: InkWell(
              splashColor: Colors.black87,
              onTap: () {
                if (isStart) {
                  laps();
                }
              },
              child: Container(
                height: 270,
                width: 270,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(360),
                  boxShadow: List.filled(10, BoxShadow(color: highlight, blurRadius: 30)),
                ),
                child: Center(
                  child: Text(
                    timeFormat(_elapsedMilliseconds),
                    style: TextStyle(
                      color: Colors.pink[300],
                      fontSize: 40,
                      fontFamily: 'Redex',
                    ),
                  ),
                ),
              ),
            ),
          ),
          // List - laps
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: double.infinity,
                height: 250,
                child: ListView.builder(
                  itemCount: lapsList.length,
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 80),
                  itemBuilder: (context, index) {
                    final lapsItem = lapsList[index];
                    return Padding(
                      padding: EdgeInsets.only(top: 30, left: 10, right: 5),
                      child: Container(
                        height: 120,
                        width: 180,
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 10, right: 10),
                                    child: IconButton(
                                      hoverColor: Colors.white60,
                                      onPressed: () {
                                        deleteLap(index);
                                      },
                                      icon: Icon(
                                        Icons.delete,
                                        size: 20,
                                        color: Colors.pink[200],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10, left: 15),
                              child: Text(
                                lapsItem['lap'],
                                style: TextStyle(
                                  color: Colors.pink[300],
                                  fontFamily: 'Redex',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, left: 15),
                              child: Text(
                                lapsItem['time'],
                                style: TextStyle(
                                  color: Colors.pink.shade100,
                                  fontFamily: 'Ubuntu',
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Spacer(),
          Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                // Button 1 - Start, pause, resume
                Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: InkWell(
                    splashColor: Colors.black87,
                    onTap: () {
                      if (isStart) {
                        pauseWatch();
                      } else {
                        startWatch();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isStart ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: Colors.pink.shade200,
                            size: 35,
                          ),
                          Container(width: 10),
                          Text(
                            isStart ? 'PAUSE' : isPause ? 'RESUME' : 'START',
                            style: TextStyle(
                              color: Colors.pink[200],
                              fontSize: 19,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                // Button 2 - Reset, stop
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: InkWell(
                    splashColor: Colors.black87,
                    onTap: () {
                      if (isStart) {
                        stop();
                      } else {
                        reset();
                      }
                    },
                    child: Container(
                      height: 70,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(360),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            isStart ? Icons.stop_rounded : Icons.restart_alt,
                            color: Colors.pink.shade200,
                            size: 35,
                          ),
                          Container(width: 10),
                          Text(
                            isStart ? 'STOP' : 'RESET',
                            style: TextStyle(
                              color: Colors.pink[200],
                              fontSize: 19,
                              fontFamily: 'Ubuntu',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
