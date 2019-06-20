import 'package:acadamicConnect/Components/ReusableRoundedButton.dart';
import 'package:acadamicConnect/Components/TopBar.dart';
import 'package:acadamicConnect/Utility/constants.dart';
import 'package:acadamicConnect/pages/Profiles/GuardianProfile.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key key}) : super(key: key);

  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  DateTime dateOfBirth;
  bool isTeacher = false;
  String path = '';

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        initialDatePickerMode: DatePickerMode.day,
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        dateOfBirth = picked;
      });
    }
  }

  Future _openFileExplorer(FileType _pickingType) async {
    String _path = '';
    if (_pickingType != FileType.CUSTOM) {
      try {
        _path = await FilePicker.getFilePath(type: _pickingType);
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      }
      if (!mounted) return '';

      return _path;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(
        title: 'Profile',
        child: kBackBtn,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        backgroundColor: Colors.red,
        onPressed: () {},
        child: Icon(Icons.check),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            // fit: StackFit.loose,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),
                    child: Stack(
                      children: <Widget>[
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Image(
                            height: MediaQuery.of(context).size.width / 2.5,
                            width: MediaQuery.of(context).size.width / 2.5,
                            image: path == '' ? NetworkImage(
                                "https://cdn2.iconfinder.com/data/icons/random-outline-3/48/random_14-512.png",
                                ) : AssetImage(path),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: 45,
                            width: 45,
                            child: Card(
                              elevation: 5,
                              color: Colors.white70,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  bottomRight: Radius.circular(10),
                                ),
                              ),
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(
                                  Icons.camera_alt,
                                  color: Colors.black38,
                                  size: 25,
                                ),
                                onPressed: () async {
                                  String _path =
                                      await _openFileExplorer(FileType.IMAGE);
                                  setState(() {
                                    path = _path;
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: 'One which your parents gave',
                      labelText: 'Student/Teacher Name',
                      onChanged: (name) {},
                      initialText: '',
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: 'One which school gave',
                      labelText: 'Student/Teacher Id',
                      onChanged: (id) {},
                      initialText: '',
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ProfileFields(
                          labelText: 'Standard',
                          onChanged: (std) {},
                          hintText: '',
                          initialText: '',
                        ),
                        ProfileFields(
                          labelText: 'Division',
                          onChanged: (div) {},
                          hintText: '',
                          initialText: '',
                        ),
                      ],
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      hintText: 'Father/Mother Name',
                      labelText: 'Guardian Name',
                      onChanged: (guardianName) {},
                      initialText: '',
                    ),
                    Row(
                      // mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        ProfileFields(
                          onTap: () async {
                            await _selectDate(context);
                          },
                          labelText: 'DOB',
                          textInputType: TextInputType.number,
                          onChanged: (dob) {},
                          hintText: '',
                          initialText: dateOfBirth == null
                              ? ''
                              : dateOfBirth
                                  .toLocal()
                                  .toString()
                                  .substring(0, 10),
                        ),
                        ProfileFields(
                          // width: MediaQuery.of(context).size.width,
                          hintText: 'A +ve/O -ve',
                          labelText: 'Blood Group',
                          onChanged: (bg) {},
                          initialText: '',
                        ),
                      ],
                    ),
                    ProfileFields(
                      width: MediaQuery.of(context).size.width,
                      textInputType: TextInputType.number,
                      hintText: 'Your parents..',
                      labelText: 'Mobile No',
                      onChanged: (id) {},
                      initialText: '',
                    ),
                    Visibility(
                      visible: !isTeacher,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              'Guardian\'s Profile:',
                              style: ktitleStyle.copyWith(
                                fontWeight: FontWeight.w500,
                                // color: kmainColorParents.withOpacity(0.4),
                                fontSize: 18,
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              ReusableRoundedButton(
                                elevation: 5,
                                child: Text(
                                  'Mother',
                                  style: ktitleStyle.copyWith(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                onPressed: () {
                                  kopenPage(
                                    context,
                                    GuardianProfilePage(
                                      title: 'Mother',
                                    ),
                                  );
                                },
                                backgroundColor: kmainColorParents,
                                height: 40,
                              ),
                              ReusableRoundedButton(
                                elevation: 5,
                                child: Text(
                                  'Father',
                                  style: ktitleStyle.copyWith(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                onPressed: () {
                                  kopenPage(
                                    context,
                                    GuardianProfilePage(
                                      title: 'Father',
                                    ),
                                  );
                                },
                                backgroundColor: kmainColorParents,
                                // height: 50,
                              ),
                              ReusableRoundedButton(
                                elevation: 5,
                                child: Text(
                                  'Other',
                                  style: ktitleStyle.copyWith(
                                      color: Colors.white.withOpacity(0.8)),
                                ),
                                onPressed: () {
                                  kopenPage(
                                    context,
                                    GuardianProfilePage(
                                      title: 'Other',
                                    ),
                                  );
                                },
                                backgroundColor: kmainColorParents,
                                // height: 50,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileFields extends StatelessWidget {
  final String initialText;
  final String labelText;
  final String hintText;
  final Function onChanged;
  final double width;
  final Function onTap;
  final TextInputType textInputType;

  const ProfileFields(
      {this.initialText,
      @required this.labelText,
      this.hintText,
      @required this.onChanged,
      this.onTap,
      this.textInputType,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: width == null ? MediaQuery.of(context).size.width / 2.5 : width,
      child: TextField(
        onTap: onTap,
        controller: TextEditingController(text: initialText),
        onChanged: onChanged,
        keyboardType: textInputType ?? TextInputType.text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        decoration: kTextFieldDecoration.copyWith(
          hintText: hintText,
          labelText: labelText,
        ),
      ),
    );
  }
}
