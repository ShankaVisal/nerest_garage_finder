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
    searchGarageBloc.add(InitialEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchGarageBloc, SearchGarageState>(
        bloc: searchGarageBloc,
        builder: (context, state) {
          switch (state.runtimeType) {
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
                          onPressed: () {
                            searchGarageBloc.add(NearestGarageSearchEvent());
                          },
                          child: Text('Search Nearest Garage')),
                      ElevatedButton(
                          onPressed: () {
                            searchGarageBloc.add(CallToGarageEvent("0771775703"));
                          },
                          child: Text('Call to Garage'))
                    ],
                  ),
                ),
              );
            case SearchInProgressState:
              return Scaffold(
                appBar: AppBar(
                  title: Text('Search in Progress'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          searchGarageBloc.add(InitialEvent());
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            case SearchResultState:
              SearchResultState searchResultState = state as SearchResultState;
              return Scaffold(
                appBar: AppBar(
                  title: Text("Seach Result"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          searchGarageBloc.add(InitialEvent());
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                body: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return Card(
                            color: Color(0xFF3471A1),
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(
                                      searchResultState.searchResult[index]['garage']['name'],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                          )),
                                    subtitle: Text(
                                      "Distance: ${searchResultState.searchResult[index]['distance']} km",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16
                                        ),
                                      ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      searchGarageBloc.add(CallToGarageEvent(searchResultState.searchResult[index]['garage']['phone']));
                                    },
                                    child: Text('Call'))
                              ],
                            ),
                          );
                        },
                        childCount: searchResultState.searchResult.length,
                      ),
                    )
                  ],

                  // child: Center(
                  //   child: Text(searchResultState.searchResult.toString()),
                  // ),
                ),
              );
            case CallToGarageState:
              return Scaffold(
                appBar: AppBar(
                  title: Text("Call to Garage"),
                  actions: [
                    IconButton(
                        onPressed: () {
                          searchGarageBloc.add(InitialEvent());
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                body: Center(
                  child: Text("Call to Garage"),
                ),
              );
            default:
              return Scaffold(
                appBar: AppBar(
                  title: Text('Home Screen'),
                  actions: [
                    IconButton(
                        onPressed: () {
                          searchGarageBloc.add(InitialEvent());
                        },
                        icon: Icon(Icons.close))
                  ],
                ),
                body: Center(
                  child: Text('Unknown state'),
                ),
              );
          }
        },
        listener: (context, state) {});
  }
}
