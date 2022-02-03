import 'dart:convert';

import 'package:code_management_app/data/network/base_request.dart';
import 'package:code_management_app/util/response_obj.dart';
import 'package:rxdart/rxdart.dart';

import 'upcoming_model.dart';

class HomeUpcomingBloc extends BaseRequest{
  PublishSubject<ResponseObj> fetchUpcomingMoviesController = PublishSubject();

  Stream<ResponseObj> fetchUpcomingMoviesStream() => fetchUpcomingMoviesController.stream;

  fetchUpComingMovies(String endUrl){
    ResponseObj responseOb = ResponseObj(message: MsgState.loading, data: []);
    fetchUpcomingMoviesController.sink.add(responseOb);
    getRequest(endUrl: endUrl).then((receive) {
      if (receive.message == MsgState.data) {
        Map<String, dynamic> getResult = json.decode(receive.data);
        if (getResult['results'] != null) {
          UpComingMovieModel upComingMovieModel =
          UpComingMovieModel.fromJson(getResult);
          responseOb.data = upComingMovieModel.results;
          responseOb.message = MsgState.data;
          fetchUpcomingMoviesController.sink.add(responseOb);
        } else {
          UpComingMovieModel upComingMovieModelErr =
          UpComingMovieModel.fromJson(getResult);
          responseOb.data = upComingMovieModelErr.results;
          responseOb.message = MsgState.error;
          fetchUpcomingMoviesController.sink.add(responseOb);
        }
      }
    });
  }



  void disposeFetchUpComingMoviesBloc() {
    fetchUpcomingMoviesController.close();
  }
}