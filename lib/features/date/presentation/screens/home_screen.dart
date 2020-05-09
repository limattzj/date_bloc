import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:date_bloc/features/date/presentation/screens/add_date_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
              final dateBloc = BlocProvider.of<DateBloc>(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider.value(
                      value: dateBloc,
                      child: AddDateScreen(),
                    ),
                  ));
            },
          )
        ],
      ),
      body: BlocBuilder<DateBloc, DateState>(builder: (context, state) {
        if (state is DateLoaded) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  print('this is at position $index');
                },
                child: Container(
                  width: 300,
                  height: 100,
                  color: Colors.orangeAccent,
                  child: Column(
                    children: <Widget>[
                      Text(state.dates[index].message),
                      Text('${state.dates[index].targetDate}'),
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: state.dates.length,
          );
        }
        if (state is DateError) {
          return Center(
            child: Container(
              child: Text('error'),
            ),
          );
        }
        return Container(
          color: Colors.redAccent,
        );
      }),
    );
  }
}
