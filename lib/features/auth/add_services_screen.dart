import 'dart:io';

import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/dialgos.dart';
import 'package:barber_admin/core/ui/simple_button.dart';
import 'package:barber_admin/features/auth/add_staff_screen.dart';
import 'package:flutter/material.dart';

class AddServicesScreen extends StatefulWidget {
  const AddServicesScreen({super.key});

  @override
  State<AddServicesScreen> createState() => _AddServicesScreenState();
}

class _AddServicesScreenState extends State<AddServicesScreen> {

  List<BarberService> _barberServices = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Add Services',
        shouldShowBack: false,
        onBackPressed: () {},
      ),
      body: _barberServices.isEmpty ? const Center(child: Text('No Services Added')) : GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.5,
        ),
        itemCount: _barberServices.length,
        itemBuilder: (context, index) {
          final service = _barberServices[index];
          return Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  border: Border.all(color: Colors.green),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 40,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.file(File(service.image!),
                              fit: BoxFit.cover)),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      service.serviceName!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        '\$ ${service.price.toString()}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${service.duration.toString()} min',
                      style: const TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),

              //delete
              Positioned(
                right: -24,
                top: -24,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _barberServices.remove(service);
                    });
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.4)),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Dialogs.showAddServiceDialog(context).then((service) {
            if (service != null) {
              setState(() {
                _barberServices.add(service);
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
          //onPressed: _barberServices.isEmpty ? null : () {
          onPressed: () {

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const AddStaffScreen(),
              ),
            );


          },
        ),
      ),
    );
  }
}
