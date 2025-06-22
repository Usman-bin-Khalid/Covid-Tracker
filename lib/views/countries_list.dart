import 'package:covid_tracker/services/states_services.dart';
import 'package:covid_tracker/views/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class CountriesList extends StatefulWidget{
  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    var formatter = NumberFormat('#,##0');
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value){
              setState(() {

              });
            },

            controller: searchController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
              hintText: 'Search with country name',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50.0),
              )
            ),
          ),
        ),
        Expanded(child:
        FutureBuilder(future: stateServices.countriesListApi(), builder: (context,
            AsyncSnapshot<List<dynamic>> snapshot){
          if(!snapshot.hasData){
            return ListView.builder(
                itemCount: 4,
                itemBuilder: (context, index){
                  return Shimmer.fromColors(child: Column(
                    children: [
                      ListTile(
                        leading:Container(height: 50, width: 50, color: Colors.white,),
                        title: Container(height: 10, width: 89, color: Colors.white,),
                        subtitle: Container(height: 10, width: 89, color: Colors.white,),
                      )
                    ],
                  ),
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100);
                });
          }else{
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index){
                  String name = snapshot.data![index]['country'];
                  if(searchController.text.isEmpty) {
                    return Column(
                      children: [
                        InkWell(
                          onTap : () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
                              name: snapshot.data![index]['country'],
                              image: snapshot.data![index]['countryInfo']['flag'],
                              totalCase: snapshot.data![index]['cases'],
                              totalRecovered: snapshot.data![index]['recovered'],
                              totalDeaths: snapshot.data![index]['deaths'],
                              active: snapshot.data![index]['active'],
                              critical: snapshot.data![index]['critical'],
                              test: snapshot.data![index]['tests'],
                              todayRecovered: snapshot.data![index]['todayRecovered'],

                            )

                            ));
                    },
                          child: ListTile(
                            leading: Image(
                                height : 50,
                                width: 50,
                                image: NetworkImage(

                                    snapshot.data![index]['countryInfo']['flag']
                                )),
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text( NumberFormat("#,##0").format(snapshot.data![index]['cases'])),
                          ),
                        )
                      ],
                    );
                  }else if(name.toLowerCase().contains(searchController.text.toLowerCase())) {
                    return Column(
                      children: [
                        InkWell(
                        onTap : () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
                            name: snapshot.data![index]['country'],
                            image: snapshot.data![index]['countryInfo']['flag'],
                            totalCase: snapshot.data![index]['cases'],
                            totalRecovered: snapshot.data![index]['recovered'],
                            totalDeaths: snapshot.data![index]['deaths'],
                            active: snapshot.data![index]['active'],
                            critical: snapshot.data![index]['critical'],
                            test: snapshot.data![index]['tests'],
                            todayRecovered: snapshot.data![index]['todayRecovered'],

                          )

                          ));
                    },
                          child: ListTile(
                            leading: Image(
                                height : 50,
                                width: 50,
                                image: NetworkImage(

                                    snapshot.data![index]['countryInfo']['flag']
                                )),
                            title: Text(snapshot.data![index]['country']),
                            subtitle: Text( NumberFormat("#,##0").format(snapshot.data![index]['cases'])),
                          ),
                        )
                      ],
                    );
                  }else{
                   return Container();
                  }
              return Column(
                children: [
                  ListTile(
                    leading: Image(
                        height : 50,
                        width: 50,
                        image: NetworkImage(

                      snapshot.data![index]['countryInfo']['flag']
                    )),
                    title: Text(snapshot.data![index]['country']),
                    subtitle: Text(snapshot.data![index]['cases'].toString()),
                  )
                ],
              );
            });
          }

          
        }))
      ],)),
    );
  }
}