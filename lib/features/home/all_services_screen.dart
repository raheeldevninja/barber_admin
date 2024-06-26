import 'package:barber_admin/core/app/images.dart';
import 'package:barber_admin/core/model/barber_service.dart';
import 'package:barber_admin/core/ui/custom_app_bar.dart';
import 'package:barber_admin/core/ui/dialgos.dart';
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
          ? const Center(child: Text('No Services Added'))
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

          return Stack(
            clipBehavior: Clip.none,
            children: [


              InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  //service details
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ServiceDetailsScreen(service: service),
                    ),
                  );*/

                  Dialogs.showAddServiceDialog(context, service: service).then((service) {
                    if (service != null) {
                      setState(() {
                        _servies.add(service);
                      });
                    }
                  });


                },
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
                          service.image!,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        service.serviceName!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Price: \$${service.price!}',
                        style: const TextStyle(
                          fontSize: 14,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Duration: ${service.duration!} min',
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

              //delete
              Positioned(
                right: -8,
                top: -8,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _servies.remove(service);
                    });
                  },
                  child: Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),


            ],
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
