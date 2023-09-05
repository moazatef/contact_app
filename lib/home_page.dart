import 'package:contact_app/user_info.dart';
import 'package:contact_app/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<UserModel> users = [
    const UserModel(
      name: "Gon Freecss",
      phone: "900600",
      id: "1",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    void settingModalBottomSheet(BuildContext context) {
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
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  TextFormField(
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
                              setState(() {
                                {
                                  UserModel newUser = UserModel(
                                    name: nameController.text,
                                    phone: phoneController.text,
                                    id: "${users.length + 1}",
                                  );
                                  users.add(newUser);
                                }
                              });
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
                              onPressed: () {},
                              icon: const Icon(
                                Icons.cancel,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    }

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
          separatorBuilder: (context, index) => Container(
              width: double.infinity, color: Colors.grey, height: 1.0),
          itemCount: users.length,
          itemBuilder: ((context, index) {
            final usermodel = users.elementAt(index);
            return UserInfo(
              id: usermodel.id,
              phone: usermodel.phone,
              name: usermodel.name,
            );
          })),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            settingModalBottomSheet(context);
          },
          child: const Icon(Icons.add)),
    );
  }
}

TextEditingController nameController = TextEditingController();
TextEditingController phoneController = TextEditingController();
