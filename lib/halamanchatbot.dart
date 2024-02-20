import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({Key? key}) : super(key: key);

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  List<Map<String, String>> _chatMessages = [];
  int _currentIndex = 2;

  IO.Socket? socket;

  @override
  void initState() {
    super.initState();
    initSocket();
  }

  void initSocket() {
    socket = IO.io("https://mr-chatbot-for-ceklukaid-yzlgx72ieq-uc.a.run.app/", <String, dynamic>{
      'autoConnect': true,
      'transports': ['websocket'],
    });
    socket!.connect();
    socket!.onConnect((_) {
      print('Connection established');
      _receiveBotResponse(
          'Hai, selamat datang di Cek Luka App! Saya Mr.Chat Luka, chatbot layanan pengguna. Bagaimana saya bisa membantu Anda hari ini?');
    });
    socket!.onDisconnect((_) => print('Connection Disconnection'));
    socket!.onConnectError((err) => print(err));
    socket!.onError((err) => print(err));
    socket!.on('message', (data) {
      _receiveBotResponse(data); // Handle incoming messages
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final message = _chatMessages[index];
                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildInputField(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.red,
        iconSize: 35,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });

          if (index == 0) {
            Navigator.pushNamed(context, '/dashboard');
          } else if (index == 1) {
            Navigator.pushNamed(context, '/scan');
          } else if (index == 2) {
            // Navigator.pushNamed(context, '/chatbot'); // Uncomment if needed
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chatbot',
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, String> message) {
    final isUserMessage = message.containsKey('user');
    final messageText = message.values.first;

    return Container(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.blue : Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          messageText,
          style: TextStyle(color: Colors.white, fontSize: 17), // Ukuran teks diperbesar disini (fontSize: 18)
        ),
      ),
    );
  }

  Widget _buildInputField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              _sendMessage(_messageController.text);
            },
          ),
        ],
      ),
    );
  }

  void _sendMessage(String message) {
    setState(() {
      _chatMessages.add({'user': message});
    });

    socket?.emit('message', message); // Send the message to the server

    _messageController.clear();
  }

  void _receiveBotResponse(String response) {
    setState(() {
      _chatMessages.add({'bot': response});
    });
  }

  @override
  void dispose() {
    socket?.disconnect();
    super.dispose();
  }
}
