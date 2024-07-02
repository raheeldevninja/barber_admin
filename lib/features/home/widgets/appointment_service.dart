import 'package:barber_admin/core/model/barber_service.dart';
import 'package:flutter/material.dart';

class AppointmentService extends StatelessWidget {
  const AppointmentService(
    this.service, {
    required this.appointmentDate,
    required this.appointmentTime,
    required this.isLastService,
    super.key,
  });

  final BarberService service;
  final String appointmentDate;
  final String appointmentTime;
  final bool isLastService;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              service.serviceName!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '\$${service.price!}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),

        Row(
          children: [
            Text(
              '${service.duration} minutes',
              style: const TextStyle(
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),

        const SizedBox(height: 4),

        //date and time row
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 20),
            const SizedBox(width: 4),
            Text(
              appointmentDate,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const Spacer(),
            const Icon(Icons.timelapse, size: 20),
            const SizedBox(width: 4),
            Text(
              appointmentTime,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
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
        if (!isLastService) ...[
          const Divider(
            color: Colors.grey,
            thickness: 1,
          ),
        ],
      ],
    );
  }
}
