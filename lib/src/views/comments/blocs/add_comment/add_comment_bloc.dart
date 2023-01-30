import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feed_sdk/feed_sdk.dart';

part 'add_comment_event.dart';
part 'add_comment_state.dart';

class AddCommentBloc extends Bloc<AddCommentEvent, AddCommentState> {
  final FeedApi feedApi;
  AddCommentBloc({required this.feedApi}) : super(AddCommentInitial()) {
    on<AddComment>(
      (event, emit) async {
        await _mapAddCommentToState(
          addCommentRequest: event.addCommentRequest,
          emit: emit,
        );
      },
    );
  }

  FutureOr<void> _mapAddCommentToState(
      {required addCommentRequest,
      required Emitter<AddCommentState> emit}) async {
    emit(AddCommentLoading());
    AddCommentResponse? response = await feedApi.addComment(addCommentRequest);
    if (response == null) {
      emit(AddCommentError(message: "No data found"));
    } else {
      emit(AddCommentSuccess(addCommentResponse: response));
    }
  }
}
