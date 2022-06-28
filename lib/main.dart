import 'package:flutter/material.dart';
import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:intl/intl.dart';
import 'package:whatsappcopia/bloc/call_bloc.dart';
import 'package:whatsappcopia/models/message.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: const MaterialColor(0xFF075e54, <int, Color>{
          50: Color.fromRGBO(7, 94, 84, 0.1), //10%
          100: Color.fromRGBO(7, 94, 84, 0.2), //20%
          200: Color.fromRGBO(7, 94, 84, 0.3), //30%
          300: Color.fromRGBO(7, 94, 84, 0.4), //40%
          400: Color.fromRGBO(7, 94, 84, 0.5), //50%
          500: Color.fromRGBO(7, 94, 84, 0.6), //60%
          600: Color.fromRGBO(7, 94, 84, 0.7), //70%
          700: Color.fromRGBO(7, 94, 84, 0.8), //80%
          800: Color.fromRGBO(7, 94, 84, 0.9), //90%
          900: Color.fromRGBO(7, 94, 84, 1), //100% ]),
        }),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
        ),
      ),
      home: const MyHomePage(title: 'WhatsApp Cópia'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final CallBloc signaling = CallBloc();
  final RTCVideoRenderer _localRenderer = RTCVideoRenderer();
  final RTCVideoRenderer _remoteRenderer = RTCVideoRenderer();
  String? roomId;
  TextEditingController textEditingController = TextEditingController(text: '');

  @override
  void initState() {
    _localRenderer.initialize();
    _remoteRenderer.initialize();

    signaling.onAddRemoteStream = ((stream) {
      setState(() {
        _remoteRenderer.srcObject = stream;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _localRenderer.dispose();
    _remoteRenderer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          elevation: 0,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              tooltip: "Search",
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_vert),
              tooltip: "more options",
            )
          ],
        ),
        body: Column(
          children: [
            DefaultTabController(
              length: 4,
              child: Material(
                color: const Color(0xFF075e54),
                child: TabBar(tabs: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                    child: const Tab(
                      icon: Icon(Icons.camera),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Tab(
                      text: "CHATS",
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Tab(
                      text: "STATUS",
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const Tab(
                      text: "CALLS",
                    ),
                  ),
                ]),
              ),
            ),
            Flexible(
              child: ListView(
                children: List.generate(
                    10,
                    (index) => Contact(
                          key: Key(index.toString()),
                          index: index,
                        )),
              ),
            ),
          ],
        ));
  }
}

class Contact extends StatelessWidget {
  const Contact({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(child: CircleAvatar(child: Icon(Icons.person))),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text("Contact $index"),
                const Text("[last messages]"),
              ],
            ),
          ),
          Column(
            children: const [
              Text("time"),
              Icon(Icons.volume_off_rounded),
            ],
          )
        ]),
      ),
    );
  }
}

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

  final String senderId = 'me';

  final List<Message> fakemessages = [
    Message()
      ..id = '5'
      ..message = 'teste'
      ..receiver = 'receiverId'
      ..sender = 'you'
      ..receivedAt = DateTime(2022, 1, 1, 17, 53, 0)
      ..sendedAt = DateTime(2022, 1, 1, 17, 53, 0),
    Message()
      ..id = '2'
      ..message = 'teste'
      ..receiver = 'receiverId'
      ..sender = 'me'
      ..receivedAt = DateTime(2022, 1, 1, 17, 50, 0)
      ..sendedAt = DateTime(2022, 1, 1, 17, 49, 0),
    Message()
      ..id = '1'
      ..message = 'teste'
      ..receiver = 'receiverId'
      ..sender = 'me'
      ..receivedAt = DateTime(2022, 1, 1, 17, 50, 0)
      ..sendedAt = DateTime(2022, 1, 1, 17, 49, 0),
    Message()
      ..id = '3'
      ..message =
          'testeaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      ..receiver = 'receiverId'
      ..sender = 'you'
      ..receivedAt = DateTime(2022, 1, 1, 17, 51, 0)
      ..sendedAt = DateTime(2022, 1, 1, 17, 50, 0),
    Message()
      ..id = '4'
      ..message =
          'testeaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'
      ..receiver = 'receiverId'
      ..sender = 'me'
      ..receivedAt = DateTime(2022, 1, 1, 17, 52, 0)
      ..sendedAt = DateTime(2022, 1, 1, 17, 52, 0),
  ];

  @override
  Widget build(BuildContext context) {
    fakemessages.sort((a, b) => a.receivedAt.isAfter(b.receivedAt) ? 1 : 0);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        leadingWidth: 30,
        title: Flex(
          direction: Axis.horizontal,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 212, 212, 212),
                child: Icon(Icons.person),
              ),
            ),
            Expanded(
              child: InkWell(
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Row(
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const <Widget>[
                            Text("data"),
                            Text("data"),
                          ],
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
        actions: <Widget>[
          IconButton(
              splashRadius: 25,
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(Icons.video_call)),
          IconButton(
              splashRadius: 25,
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(Icons.phone)),
          IconButton(
              splashRadius: 25,
              padding: EdgeInsets.zero,
              onPressed: () {},
              icon: const Icon(Icons.more_vert))
        ],
      ),
      body: Container(
        color: const Color(0xFFECE5DD),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 55.0),
              child: ListView(
                children: fakemessages
                    .map((e) => Align(
                          alignment: e.sender == senderId
                              ? Alignment.bottomRight
                              : Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth:
                                      MediaQuery.of(context).size.width * 0.80),
                              decoration: BoxDecoration(
                                  color: e.sender == senderId
                                      ? Colors.green
                                      : Colors.blueGrey,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(15))),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 8.0, horizontal: 16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(e.message),
                                    Text(
                                      DateFormat('kk:mm').format(e.receivedAt),
                                      textAlign: TextAlign.end,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(40))),
                          height: 60,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.tag_faces_rounded)),
                              const Expanded(
                                child: TextField(
                                  maxLines: null,
                                  minLines: null,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.attach_file)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.monetization_on)),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.camera_alt)),
                            ],
                          ),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.mic))
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
