import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  bool _loading = false;
  static const _apiKey = 'AIzaSyAp_apGSktLxlEoMFTGSA95y1v3G22QJ3Y';
  final List<({Image? image, String? text, bool fromUser})> _generatedContent =
      <({Image? image, String? text, bool fromUser})>[];

  @override
  void initState() {
    super.initState();

    _model = GenerativeModel(
        model: 'gemini-1.5-pro-latest',
        apiKey: _apiKey,
        systemInstruction: Content.system(
            'Your name is Zulando, a virtual travel guide in Uganda. You will respond as a charismatic happy travel expert  to anything that is related to tourism, sport, wildlife, trips, entertainment and accomodation. If a question is not related to those topics, the response should be, "That is beyond my knowledge."'));

    _chat = _model.startChat();
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(
          milliseconds: 750,
        ),
        curve: Curves.easeOutCirc,
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    FirebaseAnalytics.instance.logScreenView(screenName: "AiCahtbotScreen");
  }

  @override
  Widget build(BuildContext context) {
    var textFieldDecoration = InputDecoration(
      hintText: 'Ask me anything...',
      hintStyle: TextStyle(fontFamily: 'Cereal', fontSize: 18.sp),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18.r),
        ),
        borderSide: BorderSide(
          color: brandPrimaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(18.r),
        ),
        borderSide: BorderSide(
          color: brandPrimaryColor,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 80.h, left: 20.w, right: 20.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.ph,
                Expanded(
                  child: _apiKey.isEmpty
                      ? ListView(
                          children: const [
                            Text(
                                'No API key found. Please provide an API Key.'),
                          ],
                        )
                      : _generatedContent.isEmpty
                          ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  heading(text: 'Hi there😊, I\'m Zulando'),
                                  10.ph,
                                  paragraph(
                                      text:
                                          'Unleash your Ugandan escape! Ask me anything about adventures, resturants, night life, wildlife, or places to stay. 🇺🇬',
                                      textAlign: TextAlign.center)
                                ],
                              ),
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemBuilder: (context, idx) {
                                final content = _generatedContent[idx];
                                print(content);

                                return MessageWidget(
                                  text: content.text!,
                                  image: content.image,
                                  isFromUser: content.fromUser,
                                );
                              },
                              itemCount: _generatedContent.length,
                            ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style:
                              TextStyle(fontFamily: 'Cereal', fontSize: 18.sp),
                          focusNode: _textFieldFocus,
                          decoration: textFieldDecoration,
                          controller: _textController,
                          onSubmitted: (String value) {
                            _sendChatMessage(value);
                          },
                        ),
                      ),
                      const SizedBox.square(
                        dimension: 10,
                      ),
                      if (!_loading)
                        IconButton(
                          onPressed: () async {
                            _sendChatMessage(_textController.text);
                          },
                          icon: Icon(
                            LucideIcons.send,
                            color: brandPrimaryColor,
                          ),
                        )
                      else
                        CircularProgressIndicator(
                          color: brandPrimaryColor,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
              top: Platform.isAndroid ? 40.h : 60.h,
              left: 20.w,
              right: 20.w,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        color: Colors.transparent,
                        child: Row(
                          children: [
                            Icon(CupertinoIcons.arrow_left,
                                color: brandPrimaryColor, size: 30.w),
                            20.pw,
                            title(
                                text: 'Zulando',
                                fontSize: 46.sp,
                                color: brandPrimaryColor,
                                textAlign: TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                  ])),
        ],
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    setState(() {
      _loading = true;
    });

    try {
      _generatedContent.add((image: null, text: message, fromUser: true));

      var response = await _chat.sendMessage(
        Content.text(message),
      );
      var text = response.text;
      _generatedContent.add((image: null, text: text, fromUser: false));

      if (text == null) {
        _showError('No response from API.');
        return;
      } else {
        setState(() {
          _loading = false;
          _scrollDown();
        });
      }
    } catch (e, s) {
      await FirebaseCrashlytics.instance.recordError(
        e,
        s,
        reason: 'error: sending ai chat',
      );
      _showError(e.toString());
      setState(() {
        _loading = false;
      });
    } finally {
      _textController.clear();
      setState(() {
        _loading = false;
      });
      _textFieldFocus.requestFocus();
    }
  }

  void _showError(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Something went wrong'),
          content: SingleChildScrollView(
            child: SelectableText(message),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        );
      },
    );
  }
}

class MessageWidget extends StatelessWidget {
  final String text;
  final bool isFromUser;
  final Image? image;

  const MessageWidget({
    super.key,
    this.image,
    required this.text,
    required this.isFromUser,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              decoration: BoxDecoration(
                color: isFromUser
                    ? Theme.of(context).colorScheme.primary.withOpacity(0.5)
                    : Theme.of(context).colorScheme.onTertiaryContainer,
                borderRadius: BorderRadius.circular(18.r),
              ),
              padding: EdgeInsets.symmetric(
                vertical: 15.h,
                horizontal: 20.w,
              ),
              margin: const EdgeInsets.only(bottom: 8),
              child: Column(children: [
                if (text case final text?)
                  MarkdownBody(
                    data: text,
                    styleSheet: MarkdownStyleSheet(
                        listBullet: TextStyle(
                            fontFamily: 'Cereal',
                            fontSize: 18.sp,
                            color: Colors.white),
                        h4: TextStyle(
                            fontFamily: 'Cereal',
                            fontSize: 18.sp,
                            color: Colors.white),
                        h3: TextStyle(
                            fontFamily: 'Cereal',
                            fontSize: 18.sp,
                            color: Colors.white),
                        h2: TextStyle(
                            fontFamily: 'Cereal',
                            fontSize: 18.sp,
                            color: Colors.white),
                        h1: TextStyle(
                            fontFamily: 'Cereal',
                            fontSize: 18.sp,
                            color: Colors.white),
                        a: TextStyle(
                            fontFamily: 'Cereal',
                            fontSize: 18.sp,
                            color: Colors.white),
                        p: TextStyle(
                            fontFamily: 'Cereal',
                            fontSize: 18.sp,
                            color: Colors.white)),
                    selectable: true,
                  ),
                if (image case final image?) image,
              ])),
        ),
      ],
    );
  }
}
