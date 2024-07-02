import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/model/appointment.dart';
import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/model/customer.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/features/home/widgets/appointment_item.dart';
import 'package:flutter/material.dart';

class AppointmentsPage extends StatefulWidget {
  const AppointmentsPage({super.key});

  @override
  State<AppointmentsPage> createState() => _AppointmentsPageState();
}

class _AppointmentsPageState extends State<AppointmentsPage> {
  List<Appointment> appointments = [];

  @override
  void initState() {
    super.initState();

    _initAppointments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Appointments',
        onBackPressed: () {},
        shouldShowBack: false,
      ),
      body: ListView.builder(
        shrinkWrap: true,
        padding: const EdgeInsets.all(8),
        itemCount: appointments.length,
        itemBuilder: (context, index) {
          return AppointmentItem(appointments[index]);
        },
      ),
    );
  }

  _initAppointments() {
    appointments.add(
      Appointment(
        id: '234511',
        date: 'June 22, 2024',
        time: '10:00 am',
        customer: Customer(
          image: Images.userImage,
          name: 'Jim',
          phone: '1234567890',
          email: 'jim@gmail.com',
        ),
        service: [
          BarberService(
            image: Images.haircutImage,
            serviceName: 'Hair Cut',
            price: 20,
            duration: 15,
          ),
          BarberService(
            image: Images.haircutImage,
            serviceName: 'Hair Color',
            price: 15,
            duration: 45,
          ),
        ],
      ),
    );

    appointments.add(
      Appointment(
        id: '234512',
        date: 'June 22, 2024',
        time: '10:30 am',
        customer: Customer(
          image: Images.userImage,
          name: 'Bob',
          phone: '1234567890',
          email: 'bob@gmail.com',
        ),
        service: [
          BarberService(
            image: Images.beardTrimImage,
            serviceName: 'Beard Trim',
            price: 5,
            duration: 15,
          ),
        ],
      ),
    );
  }
}
