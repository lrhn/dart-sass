// Copyright 2016 Google Inc. Use of this source code is governed by an
// MIT-style license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:source_span/source_span.dart';

import '../../visitor/css.dart';
import '../../utils.dart';
import 'node.dart';

class CssMediaQuery implements CssNode {
  final CssValue<String> modifier;

  final CssValue<String> type;

  final List<CssValue<String>> features;

  FileSpan get span {
    var components = <AstNode>[];
    if (modifier != null) components.add(modifier);
    if (type != null) components.add(type);
    components.addAll(features);
    return spanForList(components);
  }

  CssMediaQuery(this.type, {this.modifier,
      Iterable<InterpolationExpression> features})
      : features = features == null
            ? const []
            : new List.unmodifiable(features);

  CssMediaQuery.condition(Iterable<InterpolationExpression> features)
      : modifier = null,
        type = null,
        features = new List.unmodifiable(features);

  String toString() {
    var buffer = new StringBuffer();
    if (modifier != null) buffer.write("$modifier ");
    if (type != null) {
      buffer.write(type);
      if (features.isNotEmpty) buffer.write(" and ");
    }

    buffer.write(features.join(" and "));
    return buffer.toString();
  }
}