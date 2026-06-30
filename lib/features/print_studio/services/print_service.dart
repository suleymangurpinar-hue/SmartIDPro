import '../models/printer_info.dart';

class PrinterService {
  static Future<List<PrinterInfo>> load() async {
    return const [
      PrinterInfo(
        name: 'System Default Printer',
        online: true,
      ),
    ];
  }
}