import 'package:flutter/material.dart';
import 'package:loginandprofile/widgets/list_text.dart';
import '../services/api_handler.dart';

import '../model/users.dart';

class ProfileScreen extends StatefulWidget {
  int index;

  ProfileScreen(this.index);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('User Profile'),
      ),
      body: FutureBuilder<List<Users>>(
        future: ApiHandler().fetchUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.75,
                height: MediaQuery.of(context).size.height * 0.65,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 173, 197, 248),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: ListView(
                  children: [
                    ListText(
                      snapshot.data![widget.index].name.firstname,
                      'First Name : ',
                    ),
                    ListText(
                      snapshot.data![widget.index].name.lastname,
                      'Last Name : ',
                    ),
                    ListText(
                      snapshot.data![widget.index].email,
                      'Email : ',
                    ),
                    ListText(
                      snapshot.data![widget.index].phone,
                      'Phone Number : ',
                    ),
                    ListText(
                      snapshot.data![widget.index].address.city,
                      'City : ',
                    ),
                    ListText(
                      snapshot.data![widget.index].address.street,
                      'Street : ',
                    ),
                    ListText(
                      snapshot.data![widget.index].address.number.toString(),
                      'Number : ',
                    ),
                    ListText(
                      snapshot.data![widget.index].address.zipcode,
                      'Zip Code : ',
                    ),
                    ListText(
                      snapshot.data![widget.index].address.geolocation.lat,
                      'Geolocation Lat : ',
                    ),
                    ListText(
                      snapshot.data![widget.index].address.geolocation.long,
                      'Geolocation Long : ',
                    ),
                  ],
                ),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
