import 'package:flutter/material.dart';

import 'custom_book_item.dart';

class SimilerBooksListView extends StatelessWidget {
  const SimilerBooksListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .15,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(right: 10),
            child: CustomBookImage(
                imageUrl:
                    'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.as-motor.com%2F&psig=AOvVaw3nVVPjndIoBJt6iaChL909&ust=1676385254038000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCID8ru7bkv0CFQAAAAAdAAAAABAF'),
          );
        },
      ),
    );
  }
}
