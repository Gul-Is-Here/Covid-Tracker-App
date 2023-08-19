import 'package:covid_tracker_app/common_widgets/resuable_Text.dart';
import 'package:flutter/material.dart';

class CountryDetailScreen extends StatelessWidget {
  final String? countryName;
  final String? image;

  int cases,
      todayCases,
      deaths,
      todayDeaths,
      recovered,
      todayRecovered,
      active,
      critical;
  final String continent;
  CountryDetailScreen(
      {super.key,
      required this.image,
      required this.countryName,
      required this.continent,
      required this.cases,
      required this.active,
      required this.critical,
      required this.deaths,
      required this.recovered,
      required this.todayCases,
      required this.todayDeaths,
      required this.todayRecovered});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          countryName.toString(),
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .11),
                  child: Card(
                      child: Column(
                    children: [
                      textWidget(title: "Country", value: countryName),
                      textWidget(title: "continent", value: continent),
                      textWidget(title: "Cases", value: cases.toString()),
                      textWidget(title: "Active", value: active.toString()),
                      textWidget(title: "Critical", value: critical.toString()),
                      textWidget(
                          title: "todayCases", value: todayCases.toString()),
                      textWidget(title: "Deaths", value: deaths.toString()),
                      textWidget(
                          title: "Recovered", value: recovered.toString()),
                      textWidget(
                          title: "Today Recovered",
                          value: todayRecovered.toString()),
                    ],
                  )),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(image.toString()),
                )
              ],
            )
          ]),
    );
  }
}
