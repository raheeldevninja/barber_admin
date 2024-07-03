import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/ui/barber_service_item.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/dialgos.dart';
import 'package:barber_admin/core/ui/no_content_widget.dart';
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
      body: _barberServices.isEmpty ? const NoContentWidget('No Services Added') :
      GridView.builder(
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
          return BarberServiceItem(
            service,
            onTapRemove: () {
              setState(() {
                _barberServices.remove(service);
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Dialogs.showAddEditServiceDialog(context).then((service) {
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
