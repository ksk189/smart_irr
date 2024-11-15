import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:smart_irr/models/model.dart';

// Import your custom ModelMessage class, assuming it's defined in model.dart


class GeminiChatBot extends StatefulWidget {
  const GeminiChatBot({super.key});

  @override
  State<GeminiChatBot> createState() => _GeminiChatBotState();
}

class _GeminiChatBotState extends State<GeminiChatBot> {
  TextEditingController promptController = TextEditingController();
  static const apiKey = "AIzaSyBu6wmO83SMoYfyBR8n50Nk5V_qI8__fsw";

  // Initialize the generative model
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);
  late final ChatSession chatSession;  // Chat session for conversation flow

  // List to store user and bot messages
  final List<ModelMessage> messages = [];

  @override
  void initState() {
    super.initState();
    // Initialize chat session
    chatSession = model.startChat();
  }

  // Function to send user messages and receive bot responses
  Future<void> sendMessage() async {
    final userMessage = promptController.text;
    if (userMessage.trim().isEmpty) return; // Avoid sending empty messages

    // Add user's message to the chat
    setState(() {
      promptController.clear();
      messages.add(
        ModelMessage(
          isPrompt: true,
          message: userMessage,
          time: DateTime.now(),
        ),
      );
    });

    try {
      // Send the message to the chat session and get response
      final response = await chatSession.sendMessage(Content.text(userMessage));

      // Add bot's response to the chat
      setState(() {
        messages.add(
          ModelMessage(
            isPrompt: false,
            message: response.text ?? "Sorry, I didn't understand that.",
            time: DateTime.now(),
          ),
        );
      });
    } catch (e) {
      setState(() {
        messages.add(
          ModelMessage(
            isPrompt: false,
            message: "An error occurred: $e",
            time: DateTime.now(),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        elevation: 3,
        backgroundColor: Colors.blue[100],
        title: const Text("Agribot"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[messages.length - index - 1];
                return ChatBubble(
                  isUserMessage: message.isPrompt,
                  message: message.message,
                  timestamp: DateFormat('hh:mm a').format(message.time),
                );
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: promptController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                hintText: "Enter a message...",
              ),
              style: const TextStyle(fontSize: 18),
              onSubmitted: (_) => sendMessage(),
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: sendMessage,
            child: const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.green,
              child: Icon(Icons.send, color: Colors.white, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isUserMessage;
  final String message;
  final String timestamp;

  const ChatBubble({
    required this.isUserMessage,
    required this.message,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(12),
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: isUserMessage ? 80 : 16),
        decoration: BoxDecoration(
          color: isUserMessage ? Colors.green : Colors.grey[300],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: isUserMessage ? const Radius.circular(16) : Radius.zero,
            bottomRight: isUserMessage ? Radius.zero : const Radius.circular(16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message,
              style: TextStyle(
                color: isUserMessage ? Colors.white : Colors.black87,
                fontSize: 16,
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                timestamp,
                style: TextStyle(
                  fontSize: 12,
                  color: isUserMessage ? Colors.white70 : Colors.black54,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
