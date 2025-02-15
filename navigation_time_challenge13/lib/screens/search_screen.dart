import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:navigation_time_challenge12/constants/sizes.dart';
import 'package:navigation_time_challenge12/models/post_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // #region [ Member variables ]
  final List<PostModel> _postList = [];
  final List<PostModel> _searchList = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchText = "";
  // #endregion [ Member variables ]

  // #region [ Member methods]
  void createSampleData() {
    _postList.add(
      PostModel(
        userName: "rjmithun",
        postStr: "Mithun",
        followers: 26632,
        postChecked: true,
      ),
    );

    _postList.add(
      PostModel(
        userName: "vicenews",
        postStr: "VICE News",
        followers: 301623,
        postChecked: true,
      ),
    );

    _postList.add(
      PostModel(
        userName: "trevornoah",
        postStr: "Trevor Noah",
        followers: 789325,
        postChecked: true,
      ),
    );

    _postList.add(
      PostModel(
        userName: "condenasttraveller",
        postStr: "Conde Nast Traveller",
        followers: 130995,
        postChecked: true,
      ),
    );

    _postList.add(
      PostModel(
        userName: "chef_pillai",
        postStr: "Suresh Pillai",
        followers: 69253,
        postChecked: true,
      ),
    );
    _postList.add(
      PostModel(
        userName: "malala",
        postStr: "Malala Yousafzai",
        followers: 237603,
        postChecked: true,
      ),
    );
    _postList.add(
      PostModel(
        userName: "sebin_cyriac",
        postStr: "Fishing_freaks",
        followers: 53289,
        postChecked: true,
      ),
    );
  }

  String numberFormat(int n) {
    String num = n.toString();
    int len = num.length;

    if (n >= 1000 && n < 1000000) {
      return '${num.substring(0, len - 3)}.${num.substring(len - 3, 1 + (len - 3))}K';
    } else if (n >= 1000000 && n < 1000000000) {
      return '${num.substring(0, len - 6)}.${num.substring(len - 6, 1 + (len - 6))}M';
    } else if (n > 1000000000) {
      return '${num.substring(0, len - 9)}.${num.substring(len - 9, 1 + (len - 9))}B';
    } else {
      return num.toString();
    }
  }
  // #endregion [ Member methods ]

  // #region [ override methods ]
  @override
  void initState() {
    createSampleData();

    _searchList.addAll(_postList);

    // 텍스트 에디트 이벤트
    _searchController.addListener(() {
      _searchText = _searchController.text;

      // 우선 search list 클리어
      _searchList.clear();

      // Search text 가 없으면 모두 보여줌
      if (_searchText.trim().isEmpty) {
        _searchList.addAll(_postList);
      } else {
        for (var value in _postList) {
          if (value.userName.contains(_searchText) || value.postStr.contains(_searchText)) {
            _searchList.add(value);
          }
        }
      }

      setState(() {});
    });

    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        // surfaceTintColor: Colors.transparent,
        // backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: Sizes.size32,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).textTheme.titleLarge?.color,
        ),
        toolbarHeight: 100,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: Sizes.size10,
          children: [
            Text("Search"),
            CupertinoSearchTextField(
              controller: _searchController,
            ),
          ],
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, index) => Divider(height: Sizes.size24, thickness: Sizes.size1),
        itemCount: _searchList.length,
        itemBuilder: (context, index) {
          return ListTile(
            // 아바타
            leading: CircleAvatar(
              radius: Sizes.size24,
              // backgroundColor: Colors.transparent,
              backgroundImage: _searchList[index].avatarUrl.isEmpty ? NetworkImage('https://i.pravatar.cc/150?img=$index') : NetworkImage(_searchList[index].avatarUrl),
            ),
            title: Row(
              spacing: Sizes.size10,
              children: [
                // 이름
                Text(
                  _searchList[index].userName,
                  style: TextStyle(fontSize: Sizes.size16, fontWeight: FontWeight.w600),
                ),
                // 포스팅 체크표시
                if (_searchList[index].postChecked)
                  FaIcon(
                    FontAwesomeIcons.solidCircleCheck,
                    color: Color(0xFF4293EF),
                    size: Sizes.size16,
                  ),
              ],
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: Sizes.size6,
              children: [
                Text(_searchList[index].postStr),
                Text(
                  "${numberFormat(_searchList[index].followers)} followers",
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color, // Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            trailing: TextButton(
              onPressed: () {},
              child: Container(
                height: Sizes.size36,
                width: Sizes.size96,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Sizes.size10),
                  border: Border.all(
                    color: Theme.of(context).colorScheme.outline, // Colors.grey,
                    strokeAlign: Sizes.size1,
                  ),
                ),
                child: Text(
                  "Follow",
                  style: TextStyle(
                    fontSize: Sizes.size16,
                    fontWeight: FontWeight.w900,
                    // color: Colors.black,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  // #endregion [ override methods ]
}
