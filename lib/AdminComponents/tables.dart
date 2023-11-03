import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TableComponent extends StatefulWidget {
  const TableComponent({super.key});

  @override
  State<TableComponent> createState() => _TableComponentState();
}

class _TableComponentState extends State<TableComponent> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> addTable(
      String _tableIdentifier, int _capacity, String _location) async {
    String id = firestore.collection("tables").doc().id;
    try {
      await firestore.collection("tables").doc(id).set({
        'tableIdentifier': _tableIdentifier,
        'capactiy': _capacity,
        'location': _location
      }).whenComplete(() => null);
    } catch (e) {
      print('Error adding table: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
