import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

enum AsyncState { notstarted, loading, error, success }

class ButtonStatus {
  final String title;
  final bool selected;

  ButtonStatus({required this.title, required this.selected});

  factory ButtonStatus.fromJson(Map<String, dynamic> json) {
    return ButtonStatus(
      title: json['title'] as String,
      selected: json['selected'] as bool,
    );
  }
}

Future<ButtonStatus> getButtonStatus() async {
  final url = Uri.parse(
    'https://y2t3-md-default-rtdb.asia-southeast1.firebasedatabase.app/.json',
  );

  final response = await http.get(url);

  if (response.statusCode != 200) {
    throw Exception('Failed to fetch (HTTP ${response.statusCode})');
  }

  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return ButtonStatus.fromJson(json);
}

class ButtonScreen extends StatefulWidget {
  const ButtonScreen({super.key});

  @override
  State<ButtonScreen> createState() => _ButtonScreenState();
}

class _ButtonScreenState extends State<ButtonScreen> {
  AsyncState state = AsyncState.loading;
  String? errorMessage;
  String title = '';
  bool selected = false;

  @override
  void initState() {
    super.initState();
    _fetchButtonData();
  }

  void _fetchButtonData() async {
    setState(() => state = AsyncState.loading);
    try {
      final status = await getButtonStatus();
      setState(() {
        title = status.title;
        selected = status.selected;
        state = AsyncState.success;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        state = AsyncState.error;
      });
    }
  }

  void _toggleSelected() {
    setState(() {
      selected = !selected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: _buildContent()));
  }

  Widget _buildContent() {
    switch (state) {
      case AsyncState.loading:
        return const CircularProgressIndicator();
      case AsyncState.error:
        return Text(errorMessage!, style: const TextStyle(color: Colors.red));
      case AsyncState.success:
        return Button(title: title, selected: selected, onTap: _toggleSelected);
      case AsyncState.notstarted:
        return const SizedBox();
    }
  }
}

class Button extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const Button({
    super.key,
    required this.title,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: selected ? Colors.blue : Colors.white,
          border: Border.all(color: Colors.blue),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Text(
          title,
          style: TextStyle(color: selected ? Colors.white : Colors.blue),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: ButtonScreen()));
}
