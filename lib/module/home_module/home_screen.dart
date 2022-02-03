import 'package:code_management_app/module/detail_module/detail_screen.dart';
import 'package:code_management_app/module/home_module/popular_model.dart';
import 'package:code_management_app/util/api_path.dart';
import 'package:code_management_app/util/response_obj.dart';
import 'package:flutter/material.dart';

import 'home_upcoming_bloc.dart';
import 'home_popular_bloc.dart';
import 'upcoming_model.dart' as upComingResult;

class HomeScreen extends StatefulWidget {
  static String routeName = '/';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeUpcomingBloc homeBloc;
  late HomePopularBloc popularBloc;
  List<upComingResult.Result> upComingMovieList = [];
  List<Result> popularMovieList = [];

  @override
  void initState() {
    homeBloc = HomeUpcomingBloc();
    homeBloc.fetchUpComingMovies(UPCOMING_END_URL);
    homeBloc.fetchUpcomingMoviesStream().listen((res) {
      if (res.message == MsgState.data) {
        setState(() {
          upComingMovieList = res.data;
        });
      }
    });
    popularBloc = HomePopularBloc();
    popularBloc.fetchPopularMovies(POPULAR_END_URL);
    popularBloc.fetchPopularMoviesStream().listen((popularRes) {
      if (popularRes.message == MsgState.data) {
        setState(() {
          popularMovieList = popularRes.data;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Text(
            'Upcoming List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Container(
            height: 400,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: upComingMovieList
                  .map((e) => InkWell(
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  movieId: e.id.toString(),
                                ),
                              ),
                            );
                          });
                        },
                        child: Column(
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
                                e.posterPath.toString(),
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                      child: Center(
                                          child:
                                              Text('Cannot load poster yet.')));
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 10,
                              ),
                              child: Text(e.title.toString()),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
          Text(
            'Popular List',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 400,
            child: ListView(
              shrinkWrap: true,
              primary: false,
              scrollDirection: Axis.vertical,
              children: popularMovieList
                  .map((e) => InkWell(
                        onTap: () {
                          setState(() {
                            print('@@@@@ ${e.id}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  movieId: e.id.toString(),
                                ),
                              ),
                            );
                          });
                        },
                        child: Column(
                          children: [
                            Container(
                              margin:
                                  EdgeInsets.only(left: 10, right: 20, top: 20),
                              height: 300,
                              width: 400,
                              decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  border: Border.all(
                                    color: Colors.black,
                                  )),
                              child: Image.network(
                                e.posterPath.toString(),
                                errorBuilder: (context, error, stackTrace) {
                                  return Container(
                                      child: Center(
                                          child:
                                              Text('Cannot load poster yet.')));
                                },
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 10,
                              ),
                              child: Text(e.title.toString()),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
