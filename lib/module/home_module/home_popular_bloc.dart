
import 'dart:convert';

import 'package:code_management_app/data/network/base_request.dart';
import 'package:code_management_app/util/response_obj.dart';
import 'package:rxdart/rxdart.dart';

import 'popular_model.dart';

class HomePopularBloc extends BaseRequest{
  PublishSubject<ResponseObj> fetchPopularMoviesController = PublishSubject();

  Stream<ResponseObj> fetchPopularMoviesStream() => fetchPopularMoviesController.stream;
  fetchPopularMovies(String endUrl){
    ResponseObj responseOb = ResponseObj(message: MsgState.loading, data: []);
    fetchPopularMoviesController.sink.add(responseOb);
    getRequest(endUrl: endUrl).then((receive) {
      if (receive.message == MsgState.data) {
        Map<String, dynamic> getResult = json.decode(receive.data);
        if (getResult['results'] != null) {
          PopularMovieModel popularMovieModel =
          PopularMovieModel.fromJson(getResult);
          responseOb.data = popularMovieModel.results;
          responseOb.message = MsgState.data;
          fetchPopularMoviesController.sink.add(responseOb);
        } else {
          PopularMovieModel popularMovieModel =
          PopularMovieModel.fromJson(getResult);
          responseOb.data = popularMovieModel.results;
          responseOb.message = MsgState.error;
          fetchPopularMoviesController.sink.add(responseOb);
        }
      }
    });
  }
  void disposeFetchUpComingMoviesBloc() {
    fetchPopularMoviesController.close();
  }
}