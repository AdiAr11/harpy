import 'package:dart_twitter_api/api/tweets/tweet_search_service.dart';
import 'package:dart_twitter_api/twitter_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harpy/api/api.dart';
import 'package:harpy/core/core.dart';

part 'replies_event.dart';
part 'replies_state.dart';

class RepliesBloc extends Bloc<RepliesEvent, RepliesState> {
  RepliesBloc(this.originalTweet) : super(LoadingParentsState()) {
    add(const LoadRepliesEvent());
  }

  /// The tweet to load the replies for.
  final TweetData? originalTweet;

  final TweetService tweetService = app<TwitterApi>().tweetService;
  final TweetSearchService searchService = app<TwitterApi>().tweetSearchService;

  static RepliesBloc of(BuildContext context) => context.watch<RepliesBloc>();

  /// The parent tweet.
  ///
  /// If the original tweet is a reply itself, this will be the first tweet that
  /// is not a reply and has its replies as the [TweetData.replies].
  TweetData? tweet;

  /// The list of replies for this [tweet].
  List<TweetData> replies = <TweetData>[];

  /// The last tweet search response.
  RepliesResult? lastResult;

  /// Whether all replies have been loaded.
  bool get allRepliesLoaded => lastResult?.lastPage ?? true;

  /// Whether no replies exists for this [tweet].
  bool get noRepliesExists => state is LoadedRepliesState && replies.isEmpty;

  @override
  Stream<RepliesState> mapEventToState(
    RepliesEvent event,
  ) async* {
    yield* event.applyAsync(currentState: state, bloc: this);
  }
}
