import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

final radioProvider=StateProvider<int>((ref){
  return 0;
});