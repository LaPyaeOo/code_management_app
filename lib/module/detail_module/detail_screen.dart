import 'package:code_management_app/module/detail_module/movie_detail_bloc.dart';
import 'package:code_management_app/module/detail_module/movie_detail_model.dart';
import 'package:code_management_app/util/api_path.dart';
import 'package:code_management_app/util/response_obj.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  static String routeName = '/detailScreen';
  final String? movieId;

  const DetailScreen({Key? key,this.movieId}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  late MovieDetailBloc movieDetailBloc;
  late MovieDetailModel movieDetailModel;

  @override
  void initState() {
    movieDetailBloc = MovieDetailBloc();
    movieDetailModel = MovieDetailModel();
    movieDetailBloc.fetchMovieDetail(widget.movieId!+'?api_key=$API_KEY');
    movieDetailBloc.movieDetailStream().listen((value) {
      if (value.message == MsgState.data) {
       setState(() {
         movieDetailModel = value.data;
       });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail Screen'),
      ),
      body: Column(
        children: [
          Container(
            margin:
            EdgeInsets.only(left: 10, right: 20, top: 20),
            height: 300,
            width: 300,
            decoration: BoxDecoration(
                borderRadius:
                BorderRadius.all(Radius.circular(10)),
                border: Border.all(
                  color: Colors.black,
                )),
            child: Image.network(
              movieDetailModel.posterPath.toString(),
              errorBuilder: (context, error, stackTrace) {
                return Container(
                    child: Center(
                        child:
                        Text('Cannot load poster yet.')));
              },
            ),
          ),
          SingleChildScrollView(
            child: Container(
              width: 500,
              height: 400,
              child: Row(
                children: [
                  Expanded(
                    child: Text(movieDetailModel.overview.toString(),style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
