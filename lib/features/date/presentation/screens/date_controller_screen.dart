import 'package:date_bloc/core/convert_month.dart';
import 'package:date_bloc/features/date/presentation/bloc/date_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DateControllerScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // should override in ThemeData instead
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(44.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text(
            'Edit Event',
            style: TextStyle(
              fontSize: 17.0,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: DateControllerBody(),
    );
  }
}

class DateControllerBody extends StatefulWidget {
  @override
  _DateControllerBodyState createState() => _DateControllerBodyState();
}

class _DateControllerBodyState extends State<DateControllerBody> {
  bool isEditingTitle = false;
  bool isEditingDateAndTime = false;
  final controller = TextEditingController();
  // a custom FocusNode for keyboard
  final node = FocusNode();
  String titleLabel = '';
  String dateAndTime = '';

  @override
  void initState() {
    controller.addListener(() {
      print(controller.text);
    });

    node.addListener(() {
      print(node.hasFocus);
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    node.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DateBloc, DateState>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // event Textfield label, it is only visible when user taps Add Title
              Visibility(
                visible: isEditingTitle,
                child: Container(
                  child: TextField(
                    focusNode: node,
                    controller: controller,
                    onSubmitted: (value) {
                      setState(() {
                        isEditingTitle = !isEditingTitle;
                        titleLabel = value;
                      });
                    },
                  ),
                ),
              ),

              // event textLabel
              Visibility(
                visible: !isEditingTitle,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      isEditingTitle = true;
                      node.requestFocus();
                    });
                  },
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          titleLabel.isEmpty ? 'Add Title' : titleLabel,
                          style: TextStyle(
                            fontSize: 50.0,
                            fontWeight: FontWeight.w400,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              // date & time label
              GestureDetector(
                onTap: () {
                  setState(() {
                    isEditingDateAndTime = !isEditingDateAndTime;
                  });
                },
                child: Container(
                  child: Text(
                    dateAndTime.isEmpty ? 'Date and Time' : dateAndTime,
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: isEditingDateAndTime,
                child: SizedBox(
                  height: 150.0,
                  child: DatePickerWidget(
                    dateFormat: 'dd-MMM-yyyy',
                    pickerTheme: DateTimePickerTheme(
                      showTitle: false,
                      backgroundColor: Colors.black,
                      itemTextStyle: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onChange: (dateTime, selectedIndex) {
                      final month = getMonth(dateTime.month);
                      setState(() {
                        dateAndTime =
                            '${dateTime.day}-${month}-${dateTime.year}';
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: <Widget>[
                  Icon(Icons.photo_camera),
                  SizedBox(
                    width: 10,
                  ),
                  Text('Edit Photo'),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
