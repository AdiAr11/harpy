import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:harpy/api/api.dart';
import 'package:harpy/components/components.dart';

/// Builds the [TweetList] for the [TweetSearchScreen].
class TweetSearchList extends StatelessWidget {
  const TweetSearchList();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final bloc = context.watch<TweetSearchBloc>();
    final state = bloc.state;

    return ScrollDirectionListener(
      child: ScrollToStart(
        child: TweetList(
          state is TweetSearchResult ? state.tweets : <TweetData>[],
          enableScroll: state.hasResults,
          beginSlivers: [
            TweetSearchAppBar(text: state.searchQuery),
          ],
          endSlivers: [
            if (state.showLoading)
              const TweetListLoadingSliver()
            else if (state.showNoResults)
              const SliverFillInfoMessage(
                primaryMessage: Text('no tweets found'),
                secondaryMessage: Text(
                  'only tweets of the last 7 days can be retrieved',
                ),
              )
            else if (state.showSearchError)
              SliverFillLoadingError(
                message: const Text('error searching tweets'),
                onRetry: () => bloc.add(const RetryTweetSearch()),
              ),
            SliverToBoxAdapter(
              child: SizedBox(height: mediaQuery.padding.bottom),
            ),
          ],
        ),
      ),
    );
  }
}
