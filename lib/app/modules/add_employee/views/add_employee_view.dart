import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_employee_controller.dart';

class AddEmployeeView extends GetView<AddEmployeeController> {
  const AddEmployeeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddEmployeeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddEmployeeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
