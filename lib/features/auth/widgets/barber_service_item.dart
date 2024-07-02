import 'package:barber_admin/core/model/barber_service.dart';
import 'package:flutter/material.dart';

class BarberServiceItem extends StatelessWidget {
  const BarberServiceItem(
    this.service, {
    required this.onTapRemove,
    this.onTap,
    super.key,
  });

  final BarberService service;
  final VoidCallback onTapRemove;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
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
                  backgroundImage: AssetImage(
                    service.image!,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  service.serviceName!,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '${service.duration.toString()} min',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),

        //delete
        Positioned(
          right: -24,
          top: -24,
          child: GestureDetector(
            onTap: onTapRemove,
            child: Container(
              width: 30,
              height: 30,
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.4)),
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
  }
}
