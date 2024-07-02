import 'dart:io';

import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/model/staff.dart';
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
                    const Text(
                      'Barber Shop',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ShopDetailsScreen(),
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
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 4),

                //shop timing
                Text(
                  'Timing: 10:00 AM - 8:00 PM',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                //working days
                const Text(
                  'Working Days:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
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
                    const Text(
                      'Contact Details:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Phone: +1234567890',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                SizedBox(height: 4),
                Text(
                  'Address: 123, Main Street, City, Country',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Services',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
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
                      return Container(
                        margin: const EdgeInsets.only(right: 8),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {},
                          child: Container(
                            width: 120,
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundImage: AssetImage(
                                    _servies[index].image!,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _servies[index].serviceName!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Price: \$${_servies[index].price!}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Duration: ${_servies[index].duration!} min',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontSize: 14,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Staff',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                      child: const Text(
                        'View All',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.blue,
                        ),
                      ),
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
