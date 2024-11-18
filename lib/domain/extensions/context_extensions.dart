import 'package:dart_frog/dart_frog.dart';

import '../../l10n/generated/l10n.dart';

extension ContextExtensions on RequestContext {
  /// Provides dynamic texts
  Localization get texts => read<Localization>();
}
