import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoleComponent extends StatefulWidget {
  const RoleComponent({super.key});

  @override
  State<RoleComponent> createState() => _RoleComponentState();
}

class _RoleComponentState extends State<RoleComponent> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late Stream<QuerySnapshot> _allRoles;
  String _showEdit = "";
  final _nameUpdateTextController = TextEditingController();
  final _nameUpdateFocusNode = FocusNode();
  final _lvlUpdateTextController = TextEditingController();
  final _lvlUpdateFocusNode = FocusNode();
  final _nameTextController = TextEditingController();
  final _nameFocusNode = FocusNode();
  final _lvlTextController = TextEditingController();
  final _lvlFocusNode = FocusNode();

  Future<void> addRole(String _name, int _lvl) async {
    String id = firestore.collection("roles").doc().id;
    try {
      await firestore.collection("roles").doc(id).set({
        'name': _name,
        'lvl': _lvl,
      }).whenComplete(() => print('Role added.'));
    } catch (e) {
      print('Error adding role: $e');
    }
  }

  Future<void> updateRole(String _id, String _name, int _lvl) async {
    try {
      await firestore.collection("roles").doc(_id).update({
        'name': _name,
        'lvl': _lvl,
      }).whenComplete(() => print('Role updated.'));
    } catch (e) {
      print('Error updating role: $e');
    }
  }

  Future<void> deleteRole(String _id) async {
    try {
      await firestore
          .collection("roles")
          .doc(_id)
          .delete()
          .whenComplete(() => print('Role deleted.'));
    } catch (e) {
      print('Error deleting role: $e');
    }
  }

  @override
  void initState() {
    _allRoles = FirebaseFirestore.instance
        .collection('roles')
        .snapshots(); //get all roles
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _allRoles,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Looking for roles!");
          }

          return Column(
            children: [
              ListView.builder(
                physics: const ScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: [
                      _showEdit == snapshot.data?.docs[index]['_id']
                          ? Form(
                              child: ListTile(
                              title: TextFormField(
                                initialValue: snapshot.data?.docs[index]
                                    ['name'],
                                autocorrect: false,
                                controller: _nameUpdateTextController,
                                focusNode: _nameUpdateFocusNode,
                              ),
                              subtitle: TextFormField(
                                initialValue: snapshot.data?.docs[index]['lvl'],
                                autocorrect: false,
                                controller: _lvlUpdateTextController,
                                keyboardType: TextInputType.number,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.digitsOnly
                                ],
                                focusNode: _lvlUpdateFocusNode,
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    updateRole(
                                        snapshot.data?.docs[index]['_id'],
                                        _nameTextController.text,
                                        _lvlTextController.value as int);
                                  },
                                  icon: Icon(Icons.add_box_rounded)),
                            ))
                          : ListTile(
                              leading: IconButton(
                                  onPressed: () {}, icon: Icon(Icons.edit)),
                              title: Text(
                                  'Role: ${snapshot.data?.docs[index]['name']}'),
                              subtitle: Text(
                                  'Lvl: ${snapshot.data?.docs[index]['lvl']}'),
                              trailing: IconButton(
                                  onPressed: () {
                                    deleteRole(
                                        snapshot.data?.docs[index]['_id']);
                                  },
                                  icon: Icon(Icons.delete)),
                            ),
                    ],
                  );
                },
              ),
              Form(
                  child: ListTile(
                title: TextFormField(
                  autocorrect: false,
                  controller: _nameTextController,
                  focusNode: _nameFocusNode,
                  decoration: InputDecoration(labelText: "Role Name"),
                ),
                subtitle: TextFormField(
                  autocorrect: false,
                  controller: _lvlTextController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  focusNode: _lvlFocusNode,
                  decoration: InputDecoration(labelText: "LVL"),
                ),
                trailing: IconButton(
                    onPressed: () {
                      addRole(_nameTextController.text,
                          _lvlTextController.value as int);
                    },
                    icon: Icon(Icons.add_box_rounded)),
              ))
            ],
          );
        },
      ),
    );
  }
}
