import 'package:contact_app/user_info.dart';
import 'package:contact_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final _formKey = GlobalKey<FormState>();

class _HomePageState extends State<HomePage> {
  late final TextEditingController nameController, phoneController;
  late final List<UserModel> users;
  @override
  void initState() {
    super.initState();
    users = [];
    nameController = TextEditingController(text: '');
    phoneController = TextEditingController(text: '');
  }

  void settingModalBottomSheet(BuildContext context,
      {UserModel? userModel, required void Function() onTapSave}) {
    if (userModel != null) {
      nameController.text = userModel.name;
      phoneController.text = userModel.phone;
    }
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Padding(
            padding: EdgeInsetsDirectional.only(
              top: 10,
              start: 10,
              end: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10,
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return "Please enter the name";
                      } else {
                        return null;
                      }
                    },
                    controller: nameController,
                    decoration: const InputDecoration(
                      label: Text('Name'),
                      prefixIcon: Icon(
                        Icons.drive_file_rename_outline,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  TextFormField(
                    validator: (phone) {
                      if (phone == null || phone.isEmpty) {
                        return "Please enter the phone number";
                      } else {
                        return null;
                      }
                    },
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      label: Text('Phone'),
                      prefixIcon: Icon(
                        Icons.phone,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(9.0)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FloatingActionButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                print(nameController.text);
                                print(phoneController.text);
                                setState(() {
                                  onTapSave();
                                });
                                nameController.clear();
                                phoneController.clear();
                                Navigator.pop(context);
                              }
                            },
                            child: const Icon(
                              Icons.done,
                            )),
                        const SizedBox(
                          width: 50.0,
                        ),
                        FloatingActionButton(
                          onPressed: () {},
                          child: IconButton(
                              onPressed: () {
                                nameController.clear();
                                phoneController.clear();
                                Navigator.pop(context);
                              },
                              icon: const Icon(
                                Icons.cancel,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget showAlertDialog(BuildContext context, int index) {
    Widget cancelBottom = TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'));
    Widget continueBottom = TextButton(
        onPressed: () {
          setState(() {
            users.removeAt(index);
          });
          Navigator.pop(context);
        },
        child: const Text('Continue'));
    AlertDialog alert = AlertDialog(
      title: const Text(
        'DO YOU WANT DELETE ?',
      ),
      content: const Text(
          'if you clicked in cancel button the contact removed from list !!'),
      actions: [
        cancelBottom,
        continueBottom,
      ],
    );
    return alert;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.8,
        leading: Transform.scale(
          scale: 1.5,
          child: IconButton(
            icon: SvgPicture.asset(
              'image/menu.svg',
              semanticsLabel: "Menu",
              colorFilter: const ColorFilter.mode(Colors.blue, BlendMode.srcIn),
            ),
            onPressed: () {},
          ),
        ),
        title: const Text(
          "Contacts",
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.blue,
              size: 30.0,
            ),
          ),
        ],
      ),
      body: ListView.separated(
          separatorBuilder: (_, __) => Container(
              width: double.infinity, color: Colors.grey, height: 1.0),
          itemCount: users.length,
          itemBuilder: ((_, index) {
            final usermodel = users.elementAt(index);
            return UserInfo(
              id: usermodel.id,
              phone: usermodel.phone,
              name: usermodel.name,
              onDeletePressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return showAlertDialog(context, index);
                    });
              },
              onEditPressed: () {
                final user = users.elementAt(index);
                settingModalBottomSheet(context, userModel: user,
                    onTapSave: () {
                  users.replaceRange(index, index + 1, [
                    UserModel(
                        name: nameController.text,
                        phone: phoneController.text,
                        id: user.id)
                  ]);
                });
              },
            );
          })),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            settingModalBottomSheet(context, onTapSave: () {
              UserModel newUser = UserModel(
                name: nameController.text,
                phone: phoneController.text,
                id: "${users.length + 1}",
              );
              users.add(newUser);
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
