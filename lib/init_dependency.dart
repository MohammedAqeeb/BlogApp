import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/keys/app_keys.dart';

final serviceLocator = GetIt.instance();

Future<void> initDependendcy() async {
  final supabase = await Supabase.initialize(
    url: AppKeys.supabaseUrl,
    anonKey: AppKeys.anonKey,
  );
}
