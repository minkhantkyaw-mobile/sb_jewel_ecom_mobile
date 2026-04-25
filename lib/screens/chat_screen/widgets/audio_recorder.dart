// ignore_for_file: unused_local_variable

import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import 'package:path/path.dart' as p;
import 'package:record/record.dart';

import '../chat_controller.dart';
import 'audio_player.dart';

class AudioRecorderWidget extends StatefulWidget {
  final void Function(String path) onStop;

  const AudioRecorderWidget({super.key, required this.onStop});

  @override
  State<AudioRecorderWidget> createState() => _AudioRecorderWidgetState();
}

class _AudioRecorderWidgetState extends State<AudioRecorderWidget> {
  int _recordDuration = 0;
  Timer? _timer;
  final _audioRecorder = AudioRecorder();
  StreamSubscription<RecordState>? _recordSub;
  RecordState _recordState = RecordState.stop;
  StreamSubscription<Amplitude>? _amplitudeSub;
  Amplitude? _amplitude;

  String audioPath = "";

  @override
  void initState() {

    _recordSub = _audioRecorder.onStateChanged().listen((recordState) {
      setState(() => _recordState = recordState);
    });

    _amplitudeSub = _audioRecorder
        .onAmplitudeChanged(const Duration(milliseconds: 300))
        .listen((amp) => setState(() => _amplitude = amp));

    super.initState();
  }

  Future<void> _start() async {
    try {
      if (await _audioRecorder.hasPermission()) {
        // We don't do anything with this but printing

        /*setState(() async {
          isRecording = true;
        });*/
        // final devs = await _audioRecorder.listInputDevices();
        final dir = await getApplicationDocumentsDirectory();
        if(Platform.isAndroid){
          audioPath = p.join(
            dir.path,
            'audio_${DateTime.now().millisecondsSinceEpoch}.mp3',
          );
        }else if(Platform.isIOS){
          audioPath = p.join(
            dir.path,
            'audio_${DateTime.now().millisecondsSinceEpoch}.wav',
          );
        }else{
          audioPath = p.join(
            dir.path,
            'audio_${DateTime.now().millisecondsSinceEpoch}.mp3',
          );
        }



        await _audioRecorder.start(const RecordConfig(numChannels: 1,encoder: AudioEncoder.wav),
            path: audioPath);

       // _recordDuration = 0;
       // _recordDuration = 0;

        _startTimer();
      }
    } catch (e) {
      if (kDebugMode) {
        // print(e);
      }
    }
  }

  Future<void> _stop() async {
    _timer?.cancel();
    String? path=await _audioRecorder.stop();
    setState(() {
      widget.onStop(path!);
    });
    _recordDuration = 0;

  }


  Future<void> _pause() async {
    _timer?.cancel();

    await _audioRecorder.pause();
  }

  Future<void> _resume() async {
    _startTimer();

    await _audioRecorder.resume();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _buildRecordStopControl(),
            SizedBox(width: 20),
            _buildPauseResumeControl(),
            SizedBox(width: 20),
            _buildText(),
          ],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    _recordSub?.cancel();
    _amplitudeSub?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  Widget _buildRecordStopControl() {
    late Icon icon;
    late Color color;

    if (_recordState != RecordState.stop) {

      icon = const Icon(Icons.stop, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = Icon(Icons.mic, color: theme.primaryColor, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState != RecordState.stop) ? _stop() : _start();
          },
        ),
      ),
    );
  }

  Widget _buildPauseResumeControl() {
    if (_recordState == RecordState.stop) {
      return SizedBox.shrink();
    }

    late Icon icon;
    late Color color;

    if (_recordState == RecordState.record) {
      icon = const Icon(Icons.pause, color: Colors.red, size: 30);
      color = Colors.red.withOpacity(0.1);
    } else {
      final theme = Theme.of(context);
      icon = const Icon(Icons.play_arrow, color: Colors.red, size: 30);
      color = theme.primaryColor.withOpacity(0.1);
    }

    return ClipOval(
      child: Material(
        color: color,
        child: InkWell(
          child: SizedBox(width: 56, height: 56, child: icon),
          onTap: () {
            (_recordState == RecordState.pause) ? _resume() : _pause();
          },
        ),
      ),
    );
  }

  Widget _buildText() {
    if (_recordState != RecordState.stop) {
      return _buildTimer();
    }

    return Text("Waiting to record".tr);
  }

  Widget _buildTimer() {
    final String minutes = _formatNumber(_recordDuration ~/ 60);
    final String seconds = _formatNumber(_recordDuration % 60);

    return Text(
      '$minutes : $seconds',
      style: const TextStyle(color: Colors.red),
    );
  }

  String _formatNumber(int number) {
    String numberStr = number.toString();
    if (number < 10) {
      numberStr = '0$numberStr';
    }
    return numberStr;
  }

  Future<void> _startTimer() async {
    _timer?.cancel();

    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      if(int.parse(androidInfo.version.release)>13){
        _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
          setState(() {
            _recordDuration++;
            if(_recordDuration==11){
              _timer?.cancel();
              _stop();
            }
          });
        });
      }else if(int.parse(androidInfo.version.release)>9){
        _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
          setState(() {
            _recordDuration++;
            if(_recordDuration==15){
              _timer?.cancel();
              _stop();
            }
          });
        });
      }else{
        _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
          setState(() {
            _recordDuration++;
            if(_recordDuration==10){
              _timer?.cancel();
              _stop();
            }
          });
        });
      }
    }else{
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        setState(() {
          _recordDuration++;
          if(_recordDuration==15){
            _timer?.cancel();
            _stop();
          }
        });
      });
    }

  }

}

class MyRecoder extends StatefulWidget {
  const MyRecoder({super.key});

  @override
  State<MyRecoder> createState() => _MyAppState();
}

class _MyAppState extends State<MyRecoder> {
  bool showPlayer = false;
  String? audioPath;
  final controller = Get.put(ChatController());

  @override
  void initState() {
    showPlayer = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: showPlayer
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: AudioPlayer(
                source: audioPath!,
                onDelete: () {
                  setState(() => showPlayer = false);
                },
                onSend: () {},
              ),
            )
          : AudioRecorderWidget(
              onStop: (path) {
                if (kDebugMode) print('Recorded file path: $path');
                setState(() {
                  audioPath = path;
                  showPlayer = true;
                });
              },
            ),
    );
  }
}
