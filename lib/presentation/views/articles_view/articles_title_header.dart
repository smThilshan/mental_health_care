import 'package:flutter/material.dart';

class ArticlesTitleHeader extends StatefulWidget {
  const ArticlesTitleHeader({Key? key}) : super(key: key);

  @override
  State<ArticlesTitleHeader> createState() => _ArticlesTitleHeaderState();
}

class _ArticlesTitleHeaderState extends State<ArticlesTitleHeader> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Text('Articles',
            style: TextStyle(
              color: Colors.black,
              fontWeight:FontWeight.bold,
              fontSize: 30,
            ),
          ),
          Spacer(),
          // IconButton(onPressed: (){}, icon: Icon(Icons.search,size: 30,)),
        ],
      ),
    );
  }
}
