import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;

  const NetworkImageWidget({Key? key, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl!,
              fit: BoxFit.cover,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(
                    child: const Row(
                  children: [
                    Icon(Icons.error),
                    SizedBox(
                      width: 10,
                    ),
                    Text("Backend URL Issue")
                  ],
                ));
              },
            ),
          )
        : const Center(
            child: Text('URL is Null'),
          );
  }
}
