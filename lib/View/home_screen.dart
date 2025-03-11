import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nerest_garage_finder/ViewModel/bloc/search_garage_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SearchGarageBloc searchGarageBloc = SearchGarageBloc();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SearchGarageBloc().add(
      InitialEvent()
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchGarageBloc, SearchGarageState>(
      bloc: searchGarageBloc,
      builder: (context, state){
        switch(state.runtimeType){
          case InitialState:
          return Scaffold(
            appBar: AppBar(
              title: Text('Home Screen'),
            ),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: (){
                      searchGarageBloc.add(
                        NearestGarageSearchEvent()
                      );
                    }, 
                    child: Text('Search Nearest Garage')
                  ),
                  ElevatedButton(
                    onPressed: (){
                      searchGarageBloc.add(
                        CallToGarageEvent()
                      );
                    }, 
                    child: Text('Call to Garage')
                  )
                ],
              ),
            ),
          );
          default:
            return Scaffold(
              appBar: AppBar(
                title: Text('Home Screen'),
              ),
              body: Center(
                child: Text('Unknown state'),
              ),
            );
        }
      },
      listener: (context, state){});
  }
}