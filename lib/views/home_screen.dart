import 'dart:ffi';

import 'package:covid_tracker_app/Model/world_states_model.dart';
import 'package:covid_tracker_app/services/world_states_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'dart:math' as math;

import '../common_widgets/resuable_Text.dart';
import 'track_countries_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  List<Color> colorsList = [Colors.orange, Colors.green, Colors.red];

  @override
  Widget build(BuildContext context) {
    WolrdStatesServies worldStates = WolrdStatesServies();
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      // backgroundColor: Colors.black38,
      body: SafeArea(
          child: Column(
        children: [
          FutureBuilder(
              future: worldStates.fetchWorldStates(),
              builder: (context, AsyncSnapshot<WolrdStatesModel> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(
                      child: SpinKitFadingCircle(
                    controller: _controller,
                    color: Colors.black87,
                    size: 50,
                  ));
                } else {
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * .3,
                        child: PieChart(
                          legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left),
                          chartType: ChartType.ring,
                          animationDuration: const Duration(seconds: 2),
                          colorList: colorsList,
                          dataMap: {
                            "Total":
                                double.parse(snapshot.data!.cases.toString()),
                            "Recovered": double.parse(
                                snapshot.data!.recovered.toString()),
                            "Death":
                                double.parse(snapshot.data!.deaths.toString())
                          },
                          chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true),
                          chartRadius: MediaQuery.of(context).size.width / 2.5,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * .45,
                          child: Card(
                            elevation: 3,
                            child: Column(
                              children: [
                                //  -------------------> Reusable widget <---------------   //
                                textWidget(
                                    title: "Total",
                                    value: snapshot.data!.cases.toString()),
                                textWidget(
                                    title: "Recovered",
                                    value: snapshot.data!.recovered.toString()),
                                textWidget(
                                    title: "Death",
                                    value: snapshot.data!.deaths.toString()),
                                textWidget(
                                    title: "TodayCases",
                                    value:
                                        snapshot.data!.todayCases.toString()),
                                textWidget(
                                    title: "TodayDeaths",
                                    value:
                                        snapshot.data!.todayDeaths.toString()),
                                textWidget(
                                    title: "TodayRecovered",
                                    value: snapshot.data!.todayRecovered
                                        .toString()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }),

          //      ---------------------> Button Design <---------------------      //
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return TrackCountriesScreen();
                }));
              },
              child: Container(
                height: MediaQuery.of(context).size.height * .07,
                width: double.infinity,
                decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    "Track Countires",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
