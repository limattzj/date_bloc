import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:date_bloc/features/date/presentation/screens/date_controller_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final dateBloc = BlocProvider.of<DateBloc>(context);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          elevation: 0,
          //a clear all event in IconButton for testing purpose
          leading: IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              BlocProvider.of<DateBloc>(context).add(ClearDates());
            },
          ),
          title: Text('Days Clock'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: dateBloc,
                        child: DateControllerScreen(
                          message: null,
                          date: null,
                          index: null,
                        ),
                      ),
                    ));
              },
            )
          ],
        ),
      ),
      body: BlocBuilder<DateBloc, DateState>(builder: (context, state) {
        if (state is DateLoaded) {
          return ListView.separated(
            itemBuilder: (context, index) {
              return Dismissible(
                background: Container(color: Colors.red),
                key: Key(state.dates[index].message),
                onDismissed: (direction) {
                  BlocProvider.of<DateBloc>(context)
                      .add(DeleteDate(index: index));
                },
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlocProvider.value(
                        value: dateBloc,
                        child: DateControllerScreen(
                          message: state.dates[index].message,
                          date: state.dates[index].endDate,
                          index: index,
                        ),
                      ),
                    ),
                  ),
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        // TODO: How to make these tick?
                        Text('${state.dates[index]}'),
                      ],
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) => Divider(),
            itemCount: state.dates.length,
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
