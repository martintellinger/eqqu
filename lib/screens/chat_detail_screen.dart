import 'package:flutter/material.dart';
import 'package:eqqu/widgets/app_header.dart';

class ChatDetailScreen extends StatefulWidget {
  final String name;
  final String initials;
  final String avatarImage;
  final String productImage;
  final String productName;

  const ChatDetailScreen({
    super.key,
    required this.name,
    required this.initials,
    this.avatarImage = '',
    this.productImage = '',
    this.productName = '',
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final _controller = TextEditingController();
  final _scrollController = ScrollController();

  final List<_Message> _messages = [
    _Message('Ahoj, je sedlo ještě dostupné?', false, '10:28'),
    _Message('Ano, stále je k dispozici!', true, '10:30'),
    _Message('Jaký je jeho stav? Jsou nějaké vady?', false, '10:31'),
    _Message(
      'Je ve velmi dobrém stavu, žádné viditelné vady. Používané asi rok.',
      true,
      '10:33',
    ),
    _Message('Super, můžu si ho někde prohlédnout?', false, '10:35'),
    _Message(
      'Samozřejmě! Jsem z Prahy, můžeme se domluvit na předání.',
      true,
      '10:36',
    ),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(_Message(text, true, TimeOfDay.now().format(context)));
      _controller.clear();
    });
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        children: [
          // App bar
          _buildAppBar(cs),
          Divider(color: cs.outline, height: 1),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessageBubble(cs, msg);
              },
            ),
          ),

          // Input bar
          _buildInputBar(cs),
        ],
      ),
    );
  }

  Widget _buildAppBar(ColorScheme cs) {
    return SafeArea(
      bottom: false,
      child: AppHeader(
        title: widget.productName.isNotEmpty ? widget.productName : widget.name,
        subtitle: widget.name,
        showBack: true,
        trailing: widget.productImage.isNotEmpty
            ? ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.productImage,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildMessageBubble(ColorScheme cs, _Message msg) {
    final isMe = msg.isMe;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.82,
            minHeight: 44,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isMe ? cs.secondary : cs.surfaceContainerHigh,
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
              bottomLeft: Radius.circular(isMe ? 20 : 8),
              bottomRight: Radius.circular(isMe ? 8 : 20),
            ),
          ),
          child: Text(
            msg.text,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: isMe ? cs.onSecondary : cs.onSurfaceVariant,
              letterSpacing: 0.5,
              height: 24 / 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputBar(ColorScheme cs) {
    return Container(
      decoration: BoxDecoration(
        color: cs.surface,
        border: Border(top: BorderSide(color: cs.outline, width: 1)),
      ),
      padding: EdgeInsets.fromLTRB(
        16, 16, 16, MediaQuery.of(context).padding.bottom + 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Outlined text field
          Expanded(
            child: TextField(
              controller: _controller,
              onSubmitted: (_) => _sendMessage(),
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 16,
                color: cs.onSurface,
                letterSpacing: 0.5,
                height: 24 / 16,
              ),
              decoration: InputDecoration(
                hintText: 'Napište zprávu',
                hintStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: cs.onSurfaceVariant,
                  letterSpacing: 0.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: cs.outline),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: cs.outline),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(color: cs.onSurface, width: 2),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                isCollapsed: true,
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Send button - rounded rectangle 56x56
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: cs.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(Icons.send, size: 24, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isMe;
  final String time;

  _Message(this.text, this.isMe, this.time);
}
