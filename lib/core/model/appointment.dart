import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/model/customer.dart';

class Appointment {

  String? id;
  List<BarberService>? service;
  String? date;
  String? time;
  Customer? customer;

  Appointment({
    this.id,
    required this.service,
    required this.date,
    required this.time,
    required this.customer,
  });

  Appointment copyWith({
    String? id,
    List<BarberService>? service,
    String? date,
    String? time,
    Customer? customer,
  }) {
    return Appointment(
      id: id ?? this.id,
      service: service ?? this.service,
      date: date ?? this.date,
      time: time ?? this.time,
      customer: customer ?? this.customer,
    );
  }

}