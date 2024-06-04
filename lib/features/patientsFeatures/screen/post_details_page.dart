import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinkaid/features/authentication/widget/appbar.dart';
import 'package:pinkaid/features/patientsFeatures/model/postModel.dart';
import 'package:pinkaid/theme/theme.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;
  const PostDetailsPage({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(post.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: double.infinity,
              // child: Image.network(
              //   post.postUrl, // Access postUrl from the post object
              //   fit: BoxFit.cover,
              // ),
              child: Image.asset(
                post.postUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: kSpaceScreenPadding,
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: kSpaceScreenPadding),
              child: Text(post.caption),
            )
          ],
        ),
      ),
    );
  }
}
