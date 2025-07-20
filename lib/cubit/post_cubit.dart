import 'package:flutter_bloc/flutter_bloc.dart';

enum PostTriggerState { none, togglePlayer, toggleSound }

class PostCubit extends Cubit<PostTriggerState> {
  PostCubit() : super(PostTriggerState.none);

  void togglePlayer() => emit(PostTriggerState.togglePlayer);

  void toggleSound() => emit(PostTriggerState.toggleSound);
}
