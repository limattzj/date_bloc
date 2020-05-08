import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:date_bloc/features/date/presentation/screens/add_date_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../dependency_injector.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Days Clock'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddDateScreen(),
                  ));
            },
          )
        ],
      ),
      body: BlocBuilder<DateBloc, DateState>(builder: (context, state) {
        if (state is DateLoaded) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return Container(
                child: Column(
                  children: <Widget>[
                    Text(state.dates[index].message),
                    Text('${state.dates[index].targetDate}'),
                  ],
                ),
              );
            },
            itemCount: state.dates.length,
          );
        }
        if (state is DateError) {}
        return Container(
          color: Colors.redAccent,
        );
      }),
    );
  }
}
