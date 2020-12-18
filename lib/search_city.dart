import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';

class CitySearchDelegate<String> extends SearchDelegate<String> {

  List list=['Ahmedabad','Mumbai','Udaipur','Delhi','Kolkata','Chennai','Hyderabad','New York','Paris',
    'London','Tokyo','Rome','Dubai','Moscow','Sydney','Hong Kong','Singapore','Beijing','Athens'
  ];
  @override
  List<Widget> buildActions(BuildContext context)=>[IconButton(icon: Icon(Icons.clear,),onPressed: ()=>query='',)];
  @override
  Widget buildLeading(BuildContext context)=>IconButton(icon: Icon(Icons.arrow_back),onPressed: () =>close(context,null));

  @override
  Widget buildResults(BuildContext context)=>Container();

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    List listToShow=query.isEmpty?list:list.where((e) => e.toLowerCase().startsWith(query.toLowerCase())).toList();
    return listToShow.isEmpty?Text('No results found...'):ListView.builder(
      itemCount: listToShow.length,
      itemBuilder: (context,index){
        var city=listToShow[index];
        return ListTile(
          onTap:()=>{
            close(context,city)
            },
          title: Text(city,
          style: TextStyle(
              fontSize: 18
          ),
          ),
        );
      },
    );
  }

}