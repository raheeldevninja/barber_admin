import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/model/appointment.dart';
import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/model/customer.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
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
          return Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //customer info
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.grey,
                      backgroundImage: AssetImage(Images.userImage),
                    ),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${appointments[index].customer!.name}',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.call, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '${appointments[index].customer!.phone}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.email, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              '${appointments[index].customer!.email}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                const Text(
                  'Order Services:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 20),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: appointments[index].service!.length,
                  itemBuilder: (context, serviceIndex) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              appointments[index].service![serviceIndex].serviceName!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              '\$${appointments[index].service![serviceIndex].price!}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                              ),
                            ),

                          ],
                        ),

                        Row(
                          children: [

                            Text(
                              '${appointments[index].service![serviceIndex].duration} minutes',
                              style: const TextStyle(
                                fontSize: 12,
                                fontStyle: FontStyle.italic,
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 4),

                        //date
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              appointments[index].date!,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),

                            const Spacer(),

                            const Icon(Icons.timelapse, size: 20),
                            const SizedBox(width: 4),
                            Text(
                              appointments[index].time!,
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),

                          ],
                        ),

                        //time
                        Row(
                          children: [

                          ],
                        ),

                        const SizedBox(height: 20),

                        //accept reject buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white,
                              ),
                              onPressed: () {},
                              child: const Text('Accept'),
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                              ),
                              child: const Text('Reject'),
                            ),
                          ],
                        ),

                        //divider
                        if(serviceIndex < appointments[index].service!.length -1) ...[
                          const Divider(
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ],


                      ],
                    );
                  },
                ),


              ],
            ),
          );
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
