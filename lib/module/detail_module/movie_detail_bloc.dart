import 'dart:convert';

import 'package:code_management_app/data/network/base_request.dart';
import 'package:code_management_app/module/detail_module/movie_detail_model.dart';
import 'package:code_management_app/util/response_obj.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailBloc extends BaseRequest{

  PublishSubject<ResponseObj> movieDetailController = PublishSubject();

  Stream<ResponseObj> movieDetailStream() => movieDetailController.stream;


  fetchMovieDetail(String endUrl){
    ResponseObj responseOb = ResponseObj(message: MsgState.loading, data: []);
    movieDetailController.sink.add(responseOb);
    getRequest(endUrl: endUrl).then((receive) {
      if (receive.message == MsgState.data) {
        Map<String, dynamic> getResult = json.decode(receive.data);
        if (getResult.isNotEmpty) {
          MovieDetailModel upComingMovieModel =
          MovieDetailModel.fromJson(getResult);
          responseOb.data = upComingMovieModel;
          responseOb.message = MsgState.data;
          movieDetailController.sink.add(responseOb);
        } else {
          MovieDetailModel upComingMovieModelErr =
          MovieDetailModel.fromJson(getResult);
          responseOb.data = upComingMovieModelErr;
          responseOb.message = MsgState.error;
          movieDetailController.sink.add(responseOb);
        }
      }
    });
  }
  void disposeMoviesDetailBloc() {
    movieDetailController.close();
  }
}