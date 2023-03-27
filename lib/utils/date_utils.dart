
import 'package:intl/intl.dart';

class MyDateUtils {

  static getFormatterDate(DateTime date)
  {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    final String formatted = formatter.format(date);
    return formatted; // something like 2013-04-20
  }

  static getSelectedYYYYDDMM(DateTime date)
  {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(date);
    return formatted; // something like 2013-04-20
  }
}