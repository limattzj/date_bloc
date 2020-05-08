import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class AddDateScreen extends StatefulWidget {
  @override
  _AddDateScreenState createState() => _AddDateScreenState();
}

class _AddDateScreenState extends State<AddDateScreen> {
  TextEditingController controller;
  DateTime date;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          Event(controller: controller),
          DateChooser(
              date: date,
              onConfirm: (time) {
                setState(() {
                  date = time;
                });
              }),
          FlatButton(
            onPressed: () {
              BlocProvider.of<DateBloc>(context).add(AddDateEvent(
                message: 'abc',
                date: date,
              ));
            },
            child: Text('Save'),
            color: Colors.orangeAccent,
          ),
        ],
      ),
    );
  }
}

class DateChooser extends StatelessWidget {
  final Function onConfirm;
  const DateChooser({
    Key key,
    @required this.date,
    this.onConfirm,
  }) : super(key: key);

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        child: date == null ? Text('${DateTime.now()}') : Text('${date}'),
      ),
      onTap: () {
        DatePicker.showDatePicker(
          context,
          onConfirm: onConfirm,
        );
      },
    );
  }
}

class Event extends StatefulWidget {
  final TextEditingController controller;
  const Event({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  _EventState createState() => _EventState();
}

class _EventState extends State<Event> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 10.0,
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.amberAccent,
              width: 0.8,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              color: Colors.amberAccent,
              width: 0.8,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
          hintText: 'Enter name of the event',
        ),
      ),
    );
  }
}
