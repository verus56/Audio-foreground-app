import 'dart:async';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'createur_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Tp 3',
      theme: ThemeData.dark(), 
      home: const MyHomePage(title: 'Music app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({required this.title});

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _player = AudioPlayer();

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateurPage()),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: <Widget>[
          // Album Artwork and Song Title
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage('assets/images/group.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Now Playing: Senya.mp3", style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
          // Control Buttons
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: startAudio,
                  icon: Icon(Icons.skip_previous),
                  iconSize: 48,
                ),
                IconButton(
                  onPressed: pauseAudio,
                  icon: Icon(Icons.pause_circle_filled),
                  iconSize: 64,
                ),
                IconButton(
                  onPressed: startAudio,
                  icon: Icon(Icons.play_circle_filled),
                  iconSize: 64,
                ),
                IconButton(
                  onPressed: stopAudio,
                  icon: Icon(Icons.stop),
                  iconSize: 48,
                ),
                IconButton(
                  onPressed: startAudio, // Example repeat button.
                  icon: Icon(Icons.repeat),
                  iconSize: 48,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void startAudio() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initializeService();

    final audioSource = AudioSource.uri(
      Uri.parse('asset:assets/music/senya.mp3'),
    );
    await _player.setAudioSource(audioSource);
    await _player.play();
  }

  void pauseAudio() {
    if (_player.playing) {
      _player.pause();
    }
  }

  void resumeAudio() {
    if (!_player.playing) {
      _player.play();
    }
  }

  void stopAudio() {
    if (_player.playing) {
      _player.stop();
    }
  }

  Future<void> initializeService() async {
    final service = FlutterBackgroundService();

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'my_foreground',
      'MY FOREGROUND SERVICE',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

    await flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('ic_bg_service_small'),
      ),
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await service.configure(
      androidConfiguration: AndroidConfiguration(
        onStart: onStart,
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: 'my_foreground',
        initialNotificationTitle: 'AWESOME SERVICE',
        initialNotificationContent: 'Initializing',
        foregroundServiceNotificationId: 888,
      ),
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
      ),
    );
  }
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) {
  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final android = AndroidNotificationDetails(
    'my_foreground',
    'MY FOREGROUND SERVICE',
    channelDescription: 'This channel is used for important notifications.',
    importance: Importance.high,
  );
  final platform = NotificationDetails(android: android);
  flutterLocalNotificationsPlugin.show(
    0,
    'Background Audio',
    'Audio is playing in the background',
    platform,
  );
}
