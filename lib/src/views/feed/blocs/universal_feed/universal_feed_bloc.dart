import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:feed_sdk/feed_sdk.dart';

part 'universal_feed_event.dart';
part 'universal_feed_state.dart';

class UniversalFeedBloc extends Bloc<UniversalFeedEvent, UniversalFeedState> {
  final FeedApi feedApi;
  UniversalFeedBloc({required this.feedApi}) : super(UniversalFeedInitial()) {
    on<UniversalFeedEvent>((event, emit) async {
      if (event is GetUniversalFeed) {
        await _mapGetUniversalFeedToState(
            offset: event.offset, forLoadMore: event.forLoadMore, emit: emit);
      }
    });
  }

  bool hasReachedMax(UniversalFeedState state, bool forLoadMore) =>
      state is UniversalFeedLoaded && state.hasReachedMax && forLoadMore;

  FutureOr<void> _mapGetUniversalFeedToState(
      {required int offset,
      required bool forLoadMore,
      required Emitter<UniversalFeedState> emit}) async {
    // if (!hasReachedMax(state, forLoadMore)) {
    Map<String, PostUser> users = {};
    if (state is UniversalFeedLoaded) {
      users = (state as UniversalFeedLoaded).feed.users;
      emit(PaginatedUniversalFeedLoading(
          prevFeed: (state as UniversalFeedLoaded).feed));
    }
    emit(UniversalFeedLoading());
    UniversalFeedResponse? response =
        await feedApi.getUniversalFeed(UniversalFeedRequest(page: offset));

    if (response == null) {
      emit(UniversalFeedError(message: "No data found"));
    } else {
      response.users.addAll(users);
      emit(UniversalFeedLoaded(
          feed: response, hasReachedMax: response.posts.isEmpty));
    }
  }
}
