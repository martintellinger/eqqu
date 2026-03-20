import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back, color: cs.onSurface),
              onPressed: () => Navigator.pop(context),
            ),
            // Title: product name + person name subtitle (centered)
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.productName.isNotEmpty
                        ? widget.productName
                        : widget.name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                      color: cs.onSurface,
                      height: 28 / 20,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.name,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: cs.onSurfaceVariant,
                      letterSpacing: 0.5,
                      height: 16 / 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            // Product image thumbnail (trailing)
            if (widget.productImage.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  widget.productImage,
                  width: 48,
                  height: 48,
                  fit: BoxFit.cover,
                ),
              )
            else
              const SizedBox(width: 48),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(ColorScheme cs, _Message msg) {
    final isMe = msg.isMe;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe) ...[
            _buildAvatar(cs, 28),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: isMe ? cs.primary : cs.surfaceContainerHigh,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isMe ? 20 : 8),
                  bottomRight: Radius.circular(isMe ? 8 : 20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    msg.text,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: isMe ? Colors.white : cs.onSurface,
                      letterSpacing: 0.25,
                      height: 20 / 14,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    msg.time,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 11,
                      color: isMe
                          ? Colors.white.withValues(alpha: 0.7)
                          : cs.tertiary,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(ColorScheme cs, double size) {
    if (widget.avatarImage.isNotEmpty) {
      return ClipOval(
        child: Image.asset(
          widget.avatarImage,
          width: size,
          height: size,
          fit: BoxFit.cover,
        ),
      );
    }
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: cs.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          widget.initials,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: size * 0.3,
            fontWeight: FontWeight.w600,
            color: Colors.white,
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
        8, 8, 8, MediaQuery.of(context).padding.bottom + 8,
      ),
      child: Row(
        children: [
          // Attachment button
          IconButton(
            icon: SvgPicture.asset(
              'assets/icons/Add.svg',
              width: 24,
              height: 24,
              colorFilter: ColorFilter.mode(cs.tertiary, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
          // Text field
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: cs.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(24),
              ),
              child: TextField(
                controller: _controller,
                onSubmitted: (_) => _sendMessage(),
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 14,
                  color: cs.onSurface,
                ),
                decoration: InputDecoration(
                  hintText: 'Napište zprávu...',
                  hintStyle: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 14,
                    color: cs.tertiary,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  isDense: true,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
          // Send button
          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: cs.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.send, size: 20, color: Colors.white),
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
