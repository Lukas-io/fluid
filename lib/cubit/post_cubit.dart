import 'package:flutter_bloc/flutter_bloc.dart';

enum PostTriggerState { show, hide }

class PostCubit extends Cubit<PostTriggerState> {
  PostCubit() : super(PostTriggerState.show);

  void showHeader() => emit(PostTriggerState.show);

  void hideHeader() => emit(PostTriggerState.hide);
}
