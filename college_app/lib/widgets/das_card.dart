import 'package:flutter/material.dart';

class DashboardBard extends StatelessWidget {
  final String url;
  final String title;
  final String num;

  DashboardBard({
    required this.url,
    required this.title,
    required this.num,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: const Color.fromRGBO(255, 254, 254, 1),
        child: Container(
          height: MediaQuery.of(context).size.height / 6,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8),
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      num,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 38,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 50,
                    ),
                    const Spacer(),
                    Expanded(
                      // Adjusted the height of the image
                      child: Image.asset(
                        url,
                        fit: BoxFit
                            .contain, // Ensure image fits within its container
                        height: MediaQuery.of(context).size.height /
                            8, // Adjust as needed
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
