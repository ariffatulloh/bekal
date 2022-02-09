import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:shimmer/shimmer.dart';

class LoadingContent extends StatelessWidget {
  final Widget child;
  LoadingContent({required this.child});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Shimmer.fromColors(
        child: child,
        enabled: true,
        baseColor: Colors.white70,
        period: Duration(milliseconds: 1000),
        highlightColor: Colors.black38);
  }
}
