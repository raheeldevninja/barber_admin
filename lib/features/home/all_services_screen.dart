import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/ui/barber_service_item.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/dialgos.dart';
import 'package:barber_admin/core/ui/no_content_widget.dart';
import 'package:flutter/material.dart';

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({super.key});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  List<BarberService> _servies = [];

  @override
  void initState() {
    super.initState();

    _initServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'All Services',
        shouldShowBack: true,
        onBackPressed: () {
          Navigator.pop(context);
        },
      ),
      body: _servies.isEmpty
          ? const NoContentWidget('No Services Added')
          : GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _servies.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.5,
              ),
              itemBuilder: (context, index) {
                final service = _servies[index];

                return BarberServiceItem(
                  service,
                  onTap: () {
                    Dialogs.showAddServiceDialog(context, service: service)
                        .then((service) {
                      if (service != null) {
                        setState(() {
                          _servies.add(service);
                        });
                      }
                    });
                  },
                  onTapRemove: () {
                    setState(() {
                      _servies.remove(service);
                    });
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Dialogs.showAddServiceDialog(context).then((service) {
            if (service != null) {
              setState(() {
                _servies.add(service);
              });
            }
          });
        },
        child: const Icon(Icons.add),
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

}
