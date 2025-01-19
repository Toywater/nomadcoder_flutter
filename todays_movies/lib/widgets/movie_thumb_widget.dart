import 'package:flutter/material.dart';
import 'package:todays_movies/constants/gaps.dart';
import 'package:todays_movies/constants/movie_info._service.dart';
import 'package:todays_movies/constants/sizes.dart';
import 'package:todays_movies/models/movie_model.dart';
import 'package:todays_movies/screens/movie_detail_screen.dart';

class MovieThumbWidget extends StatelessWidget {
  const MovieThumbWidget({
    super.key,
    required Future<List<MovieModel>> movieModels,
    double imageWidth = Sizes.size96,
    double imageHeight = 140,
    bool isTitleVisible = false,
  })  : _movieModels = movieModels,
        _imageWidth = imageWidth,
        _imageHeight = imageHeight,
        _isTitleVisible = isTitleVisible;

  // #region [ Member variables ]
  final Future<List<MovieModel>> _movieModels;
  final double _imageWidth;
  final double _imageHeight;
  final bool _isTitleVisible;
  // #endregion [ Member variables ]

  // #region [ Override methods ]
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _movieModels,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return SizedBox(
            // 하단 타이틀 있는 경우 텍스트 높이까지 계산
            height: _imageHeight + (_isTitleVisible ? Sizes.size44 : 0),
            child: ListView.separated(
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) => Gaps.h14,
              itemBuilder: (context, index) {
                var mdl = snapshot.data![index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MovieDetailScreen(movieInfo: mdl),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      // 썸네일
                      Container(
                        width: _imageWidth,
                        height: _imageHeight,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Sizes.size8),
                        ),
                        child: Image.network(
                          fit: BoxFit.cover,
                          MovieInfoService.getImageUrl(mdl.backdropPath),
                        ),
                      ),
                      // 하단 타이틀
                      Visibility(
                        visible: _isTitleVisible,
                        child: SizedBox(
                          width: _imageWidth,
                          height: Sizes.size44,
                          child: Text(
                            mdl.title,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }
  // #endregion [ Override methods ]
}
