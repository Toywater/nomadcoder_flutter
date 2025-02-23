import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation_time_challenge12/constants/gaps.dart';

class SelectMediaPick extends StatefulWidget {
  const SelectMediaPick({super.key});

  @override
  State<SelectMediaPick> createState() => _SelectMediaPickState();
}

class _SelectMediaPickState extends State<SelectMediaPick> {
  // Image picker
  final ImagePicker _picker = ImagePicker();

  // Get gallery or camera image
  Future<void> getImage(BuildContext context, ImageSource imageSource) async {
    try {
      // 카메라 또는 갤러리의 이미지
      final XFile? imageFile = await _picker.pickImage(source: imageSource);

      if (imageFile != null) {
        // 이미지 파일 정보를 리턴
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop(imageFile);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // foregroundColor: Colors.white,
        // backgroundColor: Colors.black,
        title: Text("Select camera or gallery image"),
      ),
      body: Container(
        // color: Colors.black,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 카메라 선택 버튼
              OutlinedButton(
                onPressed: () {
                  getImage(context, ImageSource.camera);
                },
                child: const Text("Camera"),
              ),
              Padding(padding: EdgeInsets.all(10)),
              // 앨범 선택
              OutlinedButton(
                onPressed: () {
                  getImage(context, ImageSource.gallery);
                },
                child: Text("Gallery"),
              ),
              Gaps.v40,
            ],
          ),
        ),
      ),
    );
  }
}
