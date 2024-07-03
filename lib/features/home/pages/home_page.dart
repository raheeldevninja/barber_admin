import 'dart:io';

import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/extension/context.dart';
import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/model/staff.dart';
import 'package:barber_admin/core/ui/barber_service_item.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/features/auth/widgets/staff_item.dart';
import 'package:barber_admin/features/home/all_services_screen.dart';
import 'package:barber_admin/features/home/all_staffs_screen.dart';
import 'package:barber_admin/features/home/contact_details_screen.dart';
import 'package:barber_admin/features/home/business_details_screen.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<BarberService> _servies = [];
  List<Staff> _staffs = [];

  @override
  void initState() {
    super.initState();

    _initServices();
    _initStaff();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Shop Details',
        onBackPressed: () {},
        shouldShowBack: false,
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          //rounded corner banner
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
                Images.barberShopImage,
                fit: BoxFit.cover,
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //shop name
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Barber Shop',
                      style: context.textTheme.titleMedium,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const BusinessDetailsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                //owner name
                Text(
                  'Owner: John Doe',
                  style: context.textTheme.labelLarge,
                ),

                const SizedBox(height: 4),

                //shop timing
                Text(
                  'Timing: 10:00 AM - 8:00 PM',
                  style: context.textTheme.labelLarge,
                ),

                const SizedBox(height: 20),

                //working days
                Text(
                  'Working Days:',
                  style: context.textTheme.titleMedium,
                ),

                const SizedBox(height: 4),

                //working days
                const Wrap(
                  spacing: 8,
                  children: [
                    Chip(
                      label: Text('Mon'),
                    ),
                    Chip(
                      label: Text('Tue'),
                    ),
                    Chip(
                      label: Text('Wed'),
                    ),
                    Chip(
                      label: Text('Thu'),
                    ),
                    Chip(
                      label: Text('Fri'),
                    ),
                    Chip(
                      label: Text('Sat'),
                    ),
                    Chip(
                      label: Text('Sun'),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contact Details:',
                      style: context.textTheme.titleMedium,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ContactDetailsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                //email
                Text(
                  'Email: johndoe@gmail.com',
                  style: context.textTheme.labelLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  'Phone: +1234567890',
                  style: context.textTheme.labelLarge,
                ),

                const SizedBox(height: 4),
                Text(
                  'Address: 123, Main Street, City, Country',
                  style: context.textTheme.labelLarge,
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Services',
                      style: context.textTheme.titleMedium,
                    ),

                    //view all services button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllServicesScreen(),
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                //services listview
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _servies.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final service = _servies[index];
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: BarberServiceItem(service),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Staff',
                      style: context.textTheme.titleMedium,
                    ),

                    //view all staff button
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AllStaffsScreen(),
                          ),
                        );
                      },
                      child: const Text('View All'),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                //staff listview
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: _staffs.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final staff = _staffs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: StaffItem(
                        staff,
                        onPressed: () {},
                        onDismissed: () {
                          //remove staff
                          setState(() {
                            _staffs.removeAt(index);
                          });
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _initServices() {
    _servies.add(
      BarberService(
        image: Images.haircutImage,
        serviceName: 'Hair Cut',
        price: 5,
        duration: 30,
      ),
    );

    _servies.add(
      BarberService(
        image: Images.beardTrimImage,
        serviceName: 'Beard Trim',
        price: 3,
        duration: 15,
      ),
    );

    _servies.add(
      BarberService(
        image: Images.haircutImage,
        serviceName: 'Hair Cut',
        price: 5,
        duration: 30,
      ),
    );

    _servies.add(
      BarberService(
        image: Images.beardTrimImage,
        serviceName: 'Beard Trim',
        price: 3,
        duration: 15,
      ),
    );

    _servies.add(
      BarberService(
        image: Images.haircutImage,
        serviceName: 'Hair Cut',
        price: 5,
        duration: 30,
      ),
    );

    _servies.add(
      BarberService(
        image: Images.beardTrimImage,
        serviceName: 'Beard Trim',
        price: 3,
        duration: 15,
      ),
    );

    _servies.add(
      BarberService(
        image: Images.haircutImage,
        serviceName: 'Hair Cut',
        price: 5,
        duration: 30,
      ),
    );

    _servies.add(
      BarberService(
        image: Images.beardTrimImage,
        serviceName: 'Beard Trim',
        price: 3,
        duration: 15,
      ),
    );
  }

  _initStaff() {
    _staffs.add(Staff(name: 'Bob Wheeler', image: File('')));
    _staffs.add(Staff(name: 'Lara', image: File('')));
    _staffs.add(Staff(name: 'Smith', image: File('')));
  }
}
