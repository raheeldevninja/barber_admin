import 'package:barber_admin/core/extension/context.dart';
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
              style: context.textTheme.bodyMedium,
            ),
            Text(
              '\$${service.price!}',
              style: context.textTheme.titleSmall,
            ),
          ],
        ),

        Row(
          children: [
            Text(
              '${service.duration} minutes',
              style: context.textTheme.bodySmall?.copyWith(
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
              style: context.textTheme.bodyLarge,
            ),
            const Spacer(),
            const Icon(Icons.timelapse, size: 20),
            const SizedBox(width: 4),
            Text(
              appointmentTime,
              style: context.textTheme.bodyLarge,
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
                backgroundColor: context.colorScheme.tertiary,
                foregroundColor: context.colorScheme.onTertiary,
              ),
              onPressed: () {},
              child: const Text('Accept'),
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.error,
                foregroundColor: context.colorScheme.onError,
              ),
              child: const Text('Reject'),
            ),
          ],
        ),

        //divider
        if (!isLastService) ...[
          const Divider(),
        ],
      ],
    );
  }
}
