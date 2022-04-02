import 'package:bubble/bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:provider/provider.dart';
import 'package:utstyr/pages/chat.dart';
import 'package:utstyr/pages/home_page.dart';
import 'package:utstyr/pages/login_page.dart';
import 'package:utstyr/pages/users.dart';
import 'package:utstyr/pages/util.dart';
import 'package:utstyr/widgets.dart';

class RoomsPage extends StatefulWidget {
  const RoomsPage({Key? key}) : super(key: key);

  @override
  _RoomsPageState createState() => _RoomsPageState();
}

class _RoomsPageState extends State<RoomsPage> {
  User? _user;
  types.Room? room1 = types.Room(
      id: 'YEZ1XSC3Mlq901uu7wwx',
      type: types.RoomType.direct,
      users: [
        types.User(id: 'ao58WuR6r1SdwHulVQC78Q67dMf2'),
        types.User(id: 'N1ShD0BFMjTKDcNutwlOfWQNMbz1')
      ]);

  void logout() async {
    await FirebaseAuth.instance.signOut();
  }

  Widget _buildAvatar(types.Room room) {
    var color = Colors.transparent;

    if (room.type == types.RoomType.direct) {
      try {
        final otherUser = room.users.firstWhere(
          (u) => u.id != _user!.uid,
        );

        color = getUserAvatarNameColor(otherUser);
      } catch (e) {
        // Do nothing if other user is not found
      }
    }

    final hasImage = room.imageUrl != null;
    final name = room.name ?? '';

    return Container(
      margin: const EdgeInsets.only(right: 16),
      child: CircleAvatar(
        backgroundColor: hasImage ? Colors.transparent : color,
        backgroundImage: hasImage ? NetworkImage(room.imageUrl!) : null,
        radius: 20,
        child: !hasImage
            ? Text(
                name.isEmpty ? '' : name[0].toUpperCase(),
                style: const TextStyle(color: Colors.white),
              )
            : null,
      ),
    );
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final updatedMessage = message.copyWith(previewData: previewData);

    FirebaseChatCore.instance.updateMessage(updatedMessage, room1!.id);
  }

  void _handleSendPressed(types.PartialText message) {
    FirebaseChatCore.instance.sendMessage(
      message,
      room1!.id,
    );
  }

  int selectedIndex = 99999;

  @override
  Widget build(BuildContext context) {
    final _user = Provider.of<User?>(context);

    return utstyrScaffold(
        context,
        _user == null
            ? Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(
                  bottom: 200,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Not authenticated'),
                    TextButton(
                      onPressed: () {
                        standardNavigator(context, LoginPage());
                      },
                      child: const Text('Login'),
                    ),
                  ],
                ),
              )
            : Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: StreamBuilder<List<types.Room>>(
                      stream: FirebaseChatCore.instance.rooms(),
                      initialData: const [],
                      builder: (context, snapshot) {
                        if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                              bottom: 200,
                            ),
                            child: const Text('No rooms'),
                          );
                        }

                        return Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final room = snapshot.data![index];

                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                    room1 = room;
                                  });
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: selectedIndex == index
                                            ? Colors.grey[300]
                                            : null,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 8,
                                    ),
                                    child: Row(
                                      children: [
                                        _buildAvatar(room),
                                        Text(
                                          room.name ?? '',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: StreamBuilder<types.Room>(
                      initialData: room1,
                      stream: FirebaseChatCore.instance.room(room1!.id),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return Container(
                            alignment: Alignment.center,
                            margin: const EdgeInsets.only(
                              bottom: 200,
                            ),
                            child: const Text('No chat selected'),
                          );
                        }
                        return StreamBuilder<List<types.Message>>(
                          initialData: const [],
                          stream: FirebaseChatCore.instance
                              .messages(snapshot.data!),
                          builder: (context, snapshot) {
                            return SafeArea(
                              bottom: true,
                              child: Chat(
                                bubbleBuilder: _bubbleBuilder,
                                //isAttachmentUploading: _isAttachmentUploading,
                                messages: snapshot.data ?? [],
                                //onAttachmentPressed: _handleAtachmentPressed,
                                //onMessageTap: _handleMessageTap,
                                //onPreviewDataFetched: _handlePreviewDataFetched,
                                onSendPressed: _handleSendPressed,
                                user: types.User(
                                  id: FirebaseChatCore
                                          .instance.firebaseUser?.uid ??
                                      '',
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ));
  }

  Widget _bubbleBuilder(
    Widget child, {
    required message,
    required nextMessageInGroup,
  }) {
    return Bubble(
      child: child,
      color: FirebaseAuth.instance.currentUser!.uid != message.author.id ||
              message.type == types.MessageType.image
          ? Color.fromARGB(255, 220, 221, 220)
          : Color(0xff2C4C16),
      margin: nextMessageInGroup
          ? const BubbleEdges.symmetric(horizontal: 6)
          : null,
      nip: nextMessageInGroup
          ? BubbleNip.no
          : FirebaseAuth.instance.currentUser!.uid != message.author.id
              ? BubbleNip.leftBottom
              : BubbleNip.rightBottom,
    );
  }
}
