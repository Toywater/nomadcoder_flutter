import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';
import 'package:navigation_time_challenge12/screens/select_media_pick.dart';
import 'package:navigation_time_challenge12/widgets/profile_avatar.dart';
import 'package:navigation_time_challenge12/widgets/profile_photos.dart';

class NewThread extends StatefulWidget {
  const NewThread({super.key, required this.onCancel});

  final Function onCancel;

  @override
  State<NewThread> createState() => _NewThreadState();
}

class _NewThreadState extends State<NewThread> {
  final PostModel _postInfo = PostModel(
    avatarUrl: "https://avatars.githubusercontent.com/u/114986775?v=4",
    userName: "똘배",
  );
  final TextEditingController _textEditingController = TextEditingController();
  String _threadText = "";

  // 카메라 또는 갤러리에서 이미지 가져오기
  Future<void> _getImage() async {
    var retValue = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => SelectMediaPick()));

    if (retValue != null && retValue is XFile) {
      XFile retImage = retValue;
      _postInfo.postImagesUrl ??= [];
      _postInfo.postImagesUrl!.add(retImage.path);

      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();

    _textEditingController.addListener(() {
      setState(() {
        _threadText = _textEditingController.text;
      });
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.95,
      // padding: EdgeInsets.symmetric(horizontal: Sizes.size18, vertical: Sizes.size14),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Sizes.size20), topRight: Radius.circular(Sizes.size20)),
      ),
      child: Scaffold(
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          // backgroundColor: Colors.white,
          elevation: 1,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            "New thread",
            style: TextStyle(
              fontSize: Sizes.size20,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
          ),
          leadingWidth: 100,
          leading: TextButton(
            onPressed: () {
              // Navigator.of(context).pop();
              widget.onCancel();
            },
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: Sizes.size20,
                fontWeight: FontWeight.w400,
                // color: Colors.black,
              ),
            ),
          ),
          shape: Border(
            bottom: BorderSide(
              color: Colors.grey.shade300,
              width: Sizes.size1,
            ),
          ),
        ),
        body: Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: Sizes.size20, left: Sizes.size10, right: Sizes.size10),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: Sizes.size10,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        // 프로필 아바타
                        ProfileAvatar(postInfo: _postInfo),
                        // 세로줄
                        VerticalDivider(
                          thickness: Sizes.size1,
                          color: Colors.red,
                          width: Sizes.size20,
                        ),
                        // Replies avatars
                        // Text("TEST"),
                      ],
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: Sizes.size10,
                        children: [
                          Text(_postInfo.userName, style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600)),
                          TextField(
                            controller: _textEditingController,
                            autofocus: true,
                            decoration: InputDecoration(
                              hintText: "Start a thread",
                              hintStyle: TextStyle(color: Colors.grey.shade500),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                            ),
                          ),
                          // 사진
                          if (_postInfo.postImagesUrl != null) ProfilePhotos(postInfo: _postInfo),

                          IconButton(
                            alignment: Alignment.center,
                            // 카메라 또는 갤러리 호출
                            onPressed: () {
                              _getImage();
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.paperclip,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Anyone can reply", style: TextStyle(fontSize: Sizes.size16, color: Colors.grey)),
                    TextButton(
                      // Post button event
                      onPressed: () {},
                      child: Text(
                        "Post",
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          color: _threadText.isEmpty ? Colors.grey : Colors.lightBlue,
                          fontWeight: _threadText.isEmpty ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Gaps.v20,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
