import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:intl/intl.dart';

class PdfGenerator {
  static Future<void> generateAndSavePDF({
    required int householdKwh,
    required double estimatedBill,
    required double avgCostPerUnit,
    required String numPeople,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // Title
              pw.Text(
                'SmartWatt Energy Report',
                style: pw.TextStyle(
                  fontSize: 22,
                  color: PdfColor.fromHex('#2980b9'),
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
              pw.SizedBox(height: 8),

              // Subtitle / Date
              pw.Text(
                'Generated on: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
                style: const pw.TextStyle(fontSize: 10, color: PdfColors.grey),
              ),
              pw.SizedBox(height: 24),

              // Household Summary
              pw.Text(
                'Household Summary',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 12),
              
              pw.Table.fromTextArray(
                context: context,
                border: null,
                cellPadding: const pw.EdgeInsets.all(4),
                cellStyle: const pw.TextStyle(fontSize: 10),
                data: <List<String>>[
                  ['Household Size: $numPeople People', 'Season: SUMMER'], // Mocked Season for now
                  ['House Type: APARTMENT', 'Bi-Monthly Units: $householdKwh kWh'],
                  ['Estimated Bill: Rs.${estimatedBill.toInt()}', 'Avg Cost/Unit: Rs.${avgCostPerUnit.toStringAsFixed(2)}'],
                ],
              ),
              pw.SizedBox(height: 32),

              // Breakdown Table
              pw.Text(
                'Appliance Breakdown',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 12),

              pw.Table.fromTextArray(
                context: context,
                headerDecoration: pw.BoxDecoration(color: PdfColor.fromHex('#2980b9')),
                headerStyle: pw.TextStyle(color: PdfColors.white, fontWeight: pw.FontWeight.bold, fontSize: 10),
                cellStyle: const pw.TextStyle(fontSize: 10),
                cellPadding: const pw.EdgeInsets.all(6),
                headers: ['Appliance', 'Usage', 'Percentage', 'Cost'],
                data: <List<String>>[
                  // Mocked Data for demonstration, will be dynamic in production
                  ['Refrigerator', '100 kWh', '40.0%', 'Rs.500'],
                  ['Air Conditioner', '75 kWh', '30.0%', 'Rs.375'],
                  ['Lighting', '37.5 kWh', '15.0%', 'Rs.187'],
                  ['Others', '37.5 kWh', '15.0%', 'Rs.188'],
                  ['TOTAL', '$householdKwh kWh', '100%', 'Rs.${estimatedBill.toInt()}'],
                ],
              ),
              pw.SizedBox(height: 32),

              // Energy Saving Tips
              pw.Text(
                'Energy Saving Tips',
                style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 12),
              pw.Bullet(text: 'Use overhead tank water (sun-heated) instead of geyser.', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
              pw.SizedBox(height: 4),
              pw.Bullet(text: 'Utilize monsoon season for natural cooling to reduce AC usage.', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
              pw.SizedBox(height: 4),
              pw.Bullet(text: 'Run washing machine during off-peak hours.', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
              pw.SizedBox(height: 4),
              pw.Bullet(text: 'Install solar panels (Kerala has ~250 sunny days/year).', style: const pw.TextStyle(fontSize: 10, color: PdfColors.black)),
              
              pw.Spacer(),

              // Footer
              pw.Text(
                'SmartWatt AI - Kerala Energy Estimator',
                style: const pw.TextStyle(fontSize: 8, color: PdfColors.grey),
              ),
            ],
          );
        },
      ),
    );

    // Prompt user to save/print the PDF
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
      name: 'SmartWatt-Report',
    );
  }
}
