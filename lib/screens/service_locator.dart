
import 'package:get_it/get_it.dart';

import 'dashboard/feed_model/feed_view_model.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<FeedViewModel>(FeedViewModel());
}