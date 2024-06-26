import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({
    required this.service,
    super.key});

  final BarberService service;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Service Details',
        onBackPressed: () {
          Navigator.pop(context);
        },
        shouldShowBack: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          //service image
          Container(
            width: double.maxFinite,
            height: 160,
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                Images.haircutImage,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //service name
                Text(
                  service.serviceName!,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                //service price
                Text(
                  'Price: \$${service.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),


                Text(
                  'Duration: ${service.duration!.toString()} min',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
