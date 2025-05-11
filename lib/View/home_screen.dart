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
    SliverPadding(
      padding: EdgeInsets.all(12),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final garageData = searchResultState.searchResult[index]['garage'];
            final distance = searchResultState.searchResult[index]['distance'];

            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: Color(0xFF3471A1),
              margin: EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Garage Name
                    Text(
                      garageData['name'],
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    SizedBox(height: 6),

                    // Distance
                    Text(
                      "Distance: ${distance} km",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),

                    // Garage Type
                    SizedBox(height: 6),
                    Text(
                      "Type: ${garageData['garageType']}",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),

                    // Address
                    SizedBox(height: 6),
                    Text(
                      "Address: ${garageData['address']}",
                      style: TextStyle(color: Colors.white70, fontSize: 16),
                    ),

                    // Services
                    SizedBox(height: 8),
                    Text(
                      "Services:",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 4),
                    Wrap(
                      spacing: 6,
                      runSpacing: 6,
                      children: List<Widget>.from(
                        garageData['services'].map<Widget>((service) => Chip(
                          label: Text(service, style: TextStyle(color: const Color.fromARGB(255, 0, 0, 0))),
                          backgroundColor: Colors.white24,
                        )),
                      ),
                    ),

                    // Action Buttons
                    SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton.icon(
                          onPressed: () {
                            LatLng garageLocation = LatLng(
                              garageData['latitude'],
                              garageData['longitude'],
                            );
                            LatLng userLocation = state.userLocation;

                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MapScreen(
                                garageLocation: garageLocation,
                                userLocation: userLocation,
                              ),
                            ));
                          },
                          icon: Icon(Icons.map),
                          label: Text("Map"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFF3471A1),
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            searchGarageBloc.add(
                              CallToGarageEvent(garageData['phone']),
                            );
                          },
                          icon: Icon(Icons.phone),
                          label: Text("Call"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Color(0xFF3471A1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
          childCount: searchResultState.searchResult.length,
        ),
      ),
    ),
  ],
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
