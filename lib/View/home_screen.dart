import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:nerest_garage_finder/View/map_screen.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                              "https://i.pinimg.com/736x/53/68/13/536813a90bd83a47e5ba5dcfb1457706.jpg"),
                        ),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Text(
                        "Find Nearest Garage",
                        style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3471A1)),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF3471A1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        searchGarageBloc.add(
                                            NearestGarageSearchEvent(
                                                radius: 5));
                                      },
                                      icon: Icon(Icons.search,
                                          color: Colors.white)),
                                  Text(
                                    "5 km",
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF3471A1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        searchGarageBloc.add(
                                            NearestGarageSearchEvent(
                                                radius: 20));
                                      },
                                      icon: Icon(Icons.search,
                                          color: Colors.white)),
                                  Text(
                                    "20 km",
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            width: screenWidth * 0.3,
                            height: screenWidth * 0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xFF3471A1),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        searchGarageBloc.add(
                                            NearestGarageSearchEvent(
                                                radius: 50));
                                      },
                                      icon: Icon(Icons.search,
                                          color: Colors.white)),
                                  Text(
                                    "50 km",
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 16),
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: screenHeight * 0.05,
                      ),
                      Container(
                        width: screenWidth * 0.95,
                        height: screenWidth * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFF3471A1),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    searchGarageBloc
                                        .add(CallToGarageEvent("0771775703"));
                                  },
                                  child: Text(
                                    "Emergency Call",
                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),
                                  )),
                            ],
                          ),
                        ),
                      ),
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
                                        searchResultState.searchResult[index]
                                            ['garage']['name'],
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20)),
                                    subtitle: Text(
                                      "Distance: ${searchResultState.searchResult[index]['distance']} km",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16),
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      LatLng garageLocation = LatLng(
                                          searchResultState.searchResult[index]
                                              ['garage']['latitude'],
                                          searchResultState.searchResult[index]
                                              ['garage']['longitude']);
                                      LatLng userLocation = state.userLocation;
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => MapScreen(
                                                    garageLocation:
                                                        garageLocation,
                                                    userLocation: userLocation,
                                                  )));
                                    },
                                    child: Text("map")),
                                ElevatedButton(
                                    onPressed: () {
                                      searchGarageBloc.add(CallToGarageEvent(
                                          searchResultState.searchResult[index]
                                              ['garage']['phone']));
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
