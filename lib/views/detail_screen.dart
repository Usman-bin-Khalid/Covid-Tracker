import 'package:covid_tracker/views/world_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget{
   String name;
    String image;
    int totalCase, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

  DetailsScreen({super.key, required this.name, required this.image, required this.totalCase, required this.totalDeaths, required this.totalRecovered, required this.active, required this.critical, required this.todayRecovered, required this.test});


  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    var formatter = NumberFormat('#,##0');
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                 Padding(
                   padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                   child: Card(
                     child: Column(
                       children: [
                         SizedBox(height: MediaQuery.of(context).size.height * 0.06,),
                         ReusableRow(title: "Cases", value: formatter.format(widget.totalCase)),
                         ReusableRow(title: "Tests", value: formatter.format(widget.test)),
                         ReusableRow(title: "Recovered", value: formatter.format(widget.todayRecovered)),
                         ReusableRow(title: "Deaths", value: formatter.format(widget.totalDeaths)),
                         ReusableRow(title: "Active", value: formatter.format(widget.active)),
                         ReusableRow(title: "Critical", value: formatter.format(widget.critical)),
                         ReusableRow(title: "Today Recovered", value: formatter.format(widget.todayRecovered)),
                         ReusableRow(title: "Total Recovered", value: formatter.format(widget.totalRecovered)),
                       ],
                     ),
                   ),
                 ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}