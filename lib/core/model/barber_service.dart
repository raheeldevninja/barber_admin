import 'dart:io';

class BarberService {

  String? image;
  String? serviceId;
  String? serviceName;
  double? price;
  int? duration;

  BarberService({
    this.serviceId,
    required this.image,
    required this.serviceName,
    required this.price,
    required this.duration,
  });

  BarberService copyWith({
    String? image,
    String? serviceId,
    String? serviceName,
    double? price,
    int? duration,
  }) {
    return BarberService(
      image: image,
      serviceId: serviceId ?? this.serviceId,
      serviceName: serviceName ?? this.serviceName,
      price: price ?? this.price,
      duration: duration ?? this.duration,
    );
  }

}