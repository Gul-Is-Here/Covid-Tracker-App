import 'package:covid_tracker_app/services/world_states_services.dart';
import 'package:covid_tracker_app/views/country_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class TrackCountriesScreen extends StatefulWidget {
  TrackCountriesScreen({super.key});

  @override
  State<TrackCountriesScreen> createState() => _TrackCountriesScreenState();
}

class _TrackCountriesScreenState extends State<TrackCountriesScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController searchContoller = TextEditingController();
    CountriesStatesServies countriesServies = CountriesStatesServies();
    return Scaffold(
      // backgroundColor: Colors.grey.shade600,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              cursorColor: Colors.white,
              controller: searchContoller,
              onChanged: (value) {
                setState(() {
                  value = searchContoller.text;
                });
              },
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade300,
                label: const Text(
                  "Search",
                  style: TextStyle(color: Colors.black),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: const BorderSide(color: Colors.white, width: 1),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.white)),
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder<List<dynamic>>(
                  future: countriesServies.fetchCountriesStates(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (!snapshot.hasData) {
                      return ListView.builder(
                          itemCount: 7,
                          itemBuilder: (context, index) {
                            return Shimmer.fromColors(
                              enabled: true,
                              direction: ShimmerDirection.ttb,
                              baseColor: Colors.grey,
                              highlightColor: Colors.white,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    subtitle: Container(
                                      height: 10,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                    leading: Container(
                                      height: 40,
                                      width: 89,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          });
                    } else {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                String name = snapshot.data![index]['country'];
                                if (searchContoller.text.isEmpty) {
                                  return Column(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return CountryDetailScreen(
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                countryName: snapshot
                                                    .data![index]['country'],
                                                continent: snapshot.data![index]
                                                    ['continent'],
                                                cases: snapshot.data![index]
                                                    ['cases'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                deaths: snapshot.data![index]
                                                    ['deaths'],
                                                recovered: snapshot.data![index]
                                                    ['recovered'],
                                                todayCases: snapshot
                                                    .data![index]['todayCases'],
                                                todayDeaths:
                                                    snapshot.data![index]
                                                        ['todayDeaths'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered']);
                                          }));
                                        },
                                        child: ListTile(
                                          title: Text(
                                            snapshot.data![index]['country'],
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          subtitle: Text(
                                            snapshot.data![index]['cases']
                                                .toString(),
                                            style: const TextStyle(
                                                color: Colors.black),
                                          ),
                                          leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else if (name.toLowerCase().contains(
                                    searchContoller.text.toLowerCase())) {
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return CountryDetailScreen(
                                                image: snapshot.data![index]
                                                    ['countryInfo']['flag'],
                                                countryName: snapshot
                                                    .data![index]['country'],
                                                continent: snapshot.data![index]
                                                    ['continent'],
                                                cases: snapshot.data![index]
                                                    ['cases'],
                                                active: snapshot.data![index]
                                                    ['active'],
                                                critical: snapshot.data![index]
                                                    ['critical'],
                                                deaths: snapshot.data![index]
                                                    ['deaths'],
                                                recovered: snapshot.data![index]
                                                    ['recovered'],
                                                todayCases: snapshot
                                                    .data![index]['todayCases'],
                                                todayDeaths:
                                                    snapshot.data![index]
                                                        ['todayDeaths'],
                                                todayRecovered:
                                                    snapshot.data![index]
                                                        ['todayRecovered']);
                                          }));
                                        },
                                        child: ListTile(
                                          title: Text(
                                              snapshot.data![index]['country']),
                                          subtitle: Text(snapshot.data![index]
                                                  ['cases']
                                              .toString()),
                                          leading: Image(
                                            height: 50,
                                            width: 50,
                                            image: NetworkImage(
                                              snapshot.data![index]
                                                  ['countryInfo']['flag'],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Container();
                                }
                              }),
                        ),
                      );
                    }
                  })),
        ],
      )),
    );
  }
}
