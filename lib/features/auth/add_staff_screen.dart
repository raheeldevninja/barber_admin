import 'dart:math';

import 'package:barber_admin/core/model/staff.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/dialgos.dart';
import 'package:barber_admin/core/ui/dissmissible_tile.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/features/auth/widgets/staff_item.dart';
import 'package:barber_admin/features/home/home_screen.dart';
import 'package:flutter/material.dart';

class AddStaffScreen extends StatefulWidget {
  const AddStaffScreen({super.key});

  @override
  State<AddStaffScreen> createState() => _AddStaffScreenState();
}

class _AddStaffScreenState extends State<AddStaffScreen> {
  List<Staff> _staffs = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Staff',
        shouldShowBack: false,
        onBackPressed: () {},
      ),
      body: _staffs.isEmpty
          ? const Center(child: Text('No Staff Added'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _staffs.length,
              itemBuilder: (context, index) {

                final staff = _staffs[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: DismissibleTile(
                    key: Key(Random().nextInt(100000).toString()),
                    onDeleteDismissed: () async {
                      //remove staff
                      setState(() {
                        _staffs.removeAt(index);
                      });
                    },
                    onDeleteConfirmDismiss: () {
                      return Future.value(true);
                    },
                    child: StaffItem(
                      staff: staff,
                      onPressed: () {
                        Dialogs.showAddEditStaffDialog(context, staff: staff).then((staff) {
                          if (staff != null) {
                            setState(() {
                              _staffs[index] = staff;
                            });
                          }
                        });
                      },
                      onDismissed: () {
                        //remove staff
                        setState(() {
                          _staffs.removeAt(index);
                        });
                      },
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Dialogs.showAddEditStaffDialog(context).then((staff) {
            if (staff != null) {
              setState(() {
                _staffs.add(staff);
              });
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: //next button
          Padding(
        padding: const EdgeInsets.all(16),
        child: SimpleButton(
          text: 'Next',
          //onPressed: _staffs.isEmpty ? null : () {
          onPressed: () {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ),
            );


          },
        ),
      ),
    );
  }
}
