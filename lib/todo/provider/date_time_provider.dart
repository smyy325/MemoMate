import 'package:flutter_riverpod/flutter_riverpod.dart';

final dateProvider=StateProvider<String>((ref){
  return "dd/mm/yy";
});

final timeProvider=StateProvider<String>((ref){
  return "hh : mm";
});

