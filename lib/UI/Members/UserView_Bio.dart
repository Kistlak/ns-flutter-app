import 'package:flutter/material.dart';

class UserViewBio extends StatelessWidget {
  const UserViewBio({Key? key, required this.data}) : super(key: key);

  final data;

  @override
  Widget build(BuildContext context) {

    print(data);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phone',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    data['mobileNo'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Birthday',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    data['birthDate'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    data['email'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Gender',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    data['gender'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'NIC',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    data['nic'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Country',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                      data['countryName'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Divider(thickness: 1),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Emergency Contact',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    data['emergencyOneName'],
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    data['emergencyOneContactNo'],
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  )
                ],
              ),
            ),
            Divider(thickness: 1),
          ],
        )
      ),
    );
  }
}
