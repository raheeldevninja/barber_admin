import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/model/appointment.dart';
import 'package:barber_admin/features/home/widgets/appointment_service.dart';
import 'package:flutter/material.dart';

class AppointmentItem extends StatelessWidget {
  const AppointmentItem(this.appointment, {super.key});

  final Appointment appointment;

  @override
  Widget build(BuildContext context) {
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
              const CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey,
                backgroundImage: AssetImage(Images.userImage),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${appointment.customer!.name}',
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
                        '${appointment.customer!.phone}',
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
                        '${appointment.customer!.email}',
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
            itemCount: appointment.service!.length,
            itemBuilder: (context, serviceIndex) {
              return  AppointmentService(
                appointment.service![serviceIndex],
                appointmentDate: appointment.date!,
                appointmentTime: appointment.time!,
                isLastService: serviceIndex == appointment.service!.length - 1,
              );
            },
          ),
        ],
      ),
    );
  }
}
