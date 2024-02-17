import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wave/common/layout/default_layout.dart';
import 'package:wave/country/component/donate_countries_card.dart';
import 'package:wave/country/model/donate_country_model.dart';
import 'package:wave/country/provider/donate_country_provider.dart';
import 'package:wave/loading/loading_screen.dart';

import '../model/donate_country_detail_model.dart';
import 'package:skeletons/skeletons.dart';

class DonateCountryDetailScreen extends ConsumerStatefulWidget {
  static String get routeName => 'donateCountryDetail';

  final int id;

  const DonateCountryDetailScreen({required this.id, super.key});

  @override
  ConsumerState<DonateCountryDetailScreen> createState() =>
      _DonateCountryDetailScreenState();
}

class _DonateCountryDetailScreenState
    extends ConsumerState<DonateCountryDetailScreen> {
  final ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    print(widget.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(donateCountryDetailNotifierProvider(widget.id));
    if (state.isLoading) {
      print(state.isLoading);
      print(state.data);
      return const LoadingScreen();
    }

    print(state);

    if (state.error != null) {
      return Scaffold(
        body: Center(
          child: Text(state.error!.message), /// 지금은 에러날 것
        ),
      );
    }

    final model = state.data!;

    print(state);
    print(model.detailImageTitle);

    return DefaultLayout(
      isSingleChildScrollViewNeeded: true,
      child: CustomScrollView(
        controller: controller,
        slivers: [
          renderTop(
            model: model,
          ),
          if(state is! DonateCountryDetailModel) renderLoading(),
          if(state is DonateCountryDetailModel) renderDetail(model: model),
        ],
      ),
    );
  }

  SliverPadding renderDetail({
    required DonateCountryDetailModel model,
  }) {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          [
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: Text(
                model.detailImageTitle, ///test
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverToBoxAdapter renderTop({
    required DonateCountryModel model,
  }) {
    return SliverToBoxAdapter(
      child: DonateCountryCard.fromModel(
        model: model,
        isDetail: true,
      ),
    );
  }

  SliverPadding renderLoading() {
    return SliverPadding(
      padding: EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 16.0,
      ),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          List.generate(
            3,
                (index) => Padding(
              padding: const EdgeInsets.only(bottom: 32.0),
              child: SkeletonParagraph(
                style: const SkeletonParagraphStyle(
                  lines: 5,
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
