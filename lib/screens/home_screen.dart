import 'package:fluid/models/post_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/post_cubit.dart';
import '../main.dart';
import '../widgets/fluid_app_bar.dart';
import '../widgets/music_post_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: BlocProvider.value(
        value: sl<PostCubit>(),
        child: Scaffold(
          backgroundColor: Colors.white,
          body: CustomScrollView(
            slivers: [
              SliverPersistentHeader(
                pinned: true,
                delegate: FluidAppBar(_controller),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate((_, index) {
                  final post = posts[index];
                  return MusicPostItem(post);
                }, childCount: posts.length),
              ),
              SliverToBoxAdapter(
                child: SafeArea(top: false, child: SizedBox()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
