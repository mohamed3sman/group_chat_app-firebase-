import 'package:chat_app/constants/constants.dart';
import 'package:chat_app/models/message.dart';
import 'package:chat_app/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatelessWidget {
  ChatPage({super.key});
  static String id = 'ChatPage';
  final ScrollController _scrollController = ScrollController();
  CollectionReference messages =
      FirebaseFirestore.instance.collection(KMessagesCollections);

  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var email = ModalRoute.of(context)!.settings.arguments;
    return StreamBuilder<QuerySnapshot>(
        stream: messages.orderBy(KCreatedAt, descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Message> messagesList = [];
            for (int i = 0; i < snapshot.data!.docs.length; i++) {
              messagesList.add(Message.fromJson(snapshot.data!.docs[i]));
            }
            return Scaffold(
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: KPrimaryColor,
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      KLogo,
                      height: 50,
                    ),
                    const Text('Chat'),
                  ],
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      reverse: true,
                      controller: _scrollController,
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        return messagesList[index].id == email
                            ? ChatBubble(
                                message: messagesList[index],
                              )
                            : ChatBubbleForFriend(message: messagesList[index]);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: TextField(
                      controller: controller,
                      onSubmitted: (data) {
                        messages.add({
                          KMessage: data,
                          KCreatedAt: DateTime.now(),
                          'id': email
                        });
                        controller.clear();
                        _scrollController.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                      },
                      decoration: InputDecoration(
                          hintText: 'Send Message',
                          hintStyle: const TextStyle(color: KPrimaryColor),
                          suffixIcon: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.send,
                                color: KPrimaryColor,
                              )),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide:
                                  const BorderSide(color: KPrimaryColor))),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(body: Center(child: const Text('Loading...')));
          }
        });
  }
}
