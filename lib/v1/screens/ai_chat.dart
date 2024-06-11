import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:zula/v1/constants/colors.dart';
import 'package:zula/v1/constants/strings.dart';
import 'package:zula/v1/utils/extensions.dart';
import 'package:zula/v1/utils/typography.dart';

class ChatWidget extends StatefulWidget {
  const ChatWidget({super.key, this.sheetView = false});
  final bool? sheetView;

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

  AppBar _appBar(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Colors.white,
      surfaceTintColor: brandPrimaryColor.withOpacity(0.2),
      title: title(
          text: 'Zulando',
          fontSize: 46.sp,
          color: brandPrimaryColor,
          fontFamily: 'TypoGraphica',
          textAlign: TextAlign.center),
    );
  }

  @override
  Widget build(BuildContext context) {
    var textFieldDecoration = InputDecoration(
      suffixIcon: IconButton(
        onPressed: () async {
          if (_textController.text.isNotEmpty) {
            _sendChatMessage(_textController.text);
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus &&
                currentFocus.focusedChild != null) {
              currentFocus.focusedChild!.unfocus();
            }
          }
        },
        icon: !_loading
            ? Container(
                width: 45.w,
                height: 45.w,
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(
                    color: Colors.black12, shape: BoxShape.circle),
                child: Icon(
                  LineIcons.arrowUp,
                  color: brandPrimaryColor,
                ),
              )
            : SizedBox.square(
                dimension: 35,
                child: CircularProgressIndicator(
                  strokeWidth: 2.w,
                  color: brandPrimaryColor,
                ),
              ),
      ),
      hintText: 'Ask me anything...',
      hintStyle: TextStyle(fontFamily: 'Cereal', fontSize: 18.sp),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(48.r),
        ),
        borderSide: BorderSide(
          width: 0.5,
          color: brandPrimaryColor.withOpacity(0.3),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(48.r),
        ),
        borderSide: BorderSide(
          width: 0.5,
          color: brandPrimaryColor.withOpacity(0.4),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _apiKey.isEmpty
                      ? ListView(
                          children: const [
                            Text(
                                'No API key found. Please provide an API Key.'),
                          ],
                        )
                      : _generatedContent.isEmpty
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                heading(text: 'Hi there😊, I\'m Zulando'),
                                10.ph,
                                paragraph(
                                    text:
                                        'Unleash your Ugandan escape! Ask me anything about adventures, resturants, night life, wildlife, or places to stay. 🇺🇬',
                                    textAlign: TextAlign.center),
                                60.ph,
                                SizedBox(
                                  height: 200.h,
                                  child: ListView.builder(
                                    clipBehavior: Clip.none,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: optionsAi.length,
                                    itemBuilder: (context, index) {
                                      return GestureDetector(
                                        onTap: () {
                                          HapticFeedback.selectionClick();
                                          _sendChatMessage(optionsAi[index]);
                                          _scrollDown();
                                        },
                                        child: Container(
                                          width: 180.w,
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 15.h),
                                          margin:
                                              const EdgeInsets.only(right: 10),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12.r),
                                            border: Border.all(
                                              color: Colors.black38,
                                              width: 0.6,
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(
                                                CupertinoIcons.sparkles,
                                                color: Colors.black38,
                                              ),
                                              10.ph,
                                              Expanded(
                                                  child: paragraph(
                                                text: optionsAi[index],
                                                color: Colors.black87,
                                              ))
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            )
                          : ListView.builder(
                              padding: EdgeInsets.only(top: 30.h),
                              shrinkWrap: true,
                              controller: _scrollController,
                              itemBuilder: (context, idx) {
                                final content = _generatedContent[idx];

                                return MessageWidget(
                                  text: content.text!,
                                  image: content.image,
                                  isFromUser: content.fromUser,
                                );
                              },
                              itemCount: _generatedContent.length,
                            ),
                ),
                20.ph,
                Material(
                  elevation: 30,
                  shadowColor: Colors.black45,
                  borderRadius: BorderRadius.circular(40.r),
                  color: Colors.white,
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
                            if (value.isNotEmpty) {
                              _sendChatMessage(value);
                              FocusScopeNode currentFocus =
                                  FocusScope.of(context);
                              if (!currentFocus.hasPrimaryFocus &&
                                  currentFocus.focusedChild != null) {
                                currentFocus.focusedChild!.unfocus();
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                30.ph,
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendChatMessage(String message) async {
    _scrollDown();
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
