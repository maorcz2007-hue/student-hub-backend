import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:student_hub/core/widgets/glass_card.dart';
import 'package:student_hub/app/theme/color_schemes.dart';

class FileManagerScreen extends StatelessWidget {
  const FileManagerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final files = [
      _File('Lecture Notes - Week 1.pdf', 'PDF', '2.3 MB', Iconsax.document_text, AppColorSchemes.primaryRed),
      _File('Assignment Template.docx', 'Word', '156 KB', Iconsax.document, AppColorSchemes.primaryBlue),
      _File('Grade Report.xlsx', 'Excel', '89 KB', Iconsax.chart_square, AppColorSchemes.primaryGreen),
      _File('Presentation.pptx', 'PPT', '4.1 MB', Iconsax.presention_chart, AppColorSchemes.primaryOrange),
      _File('Lab Photo.jpg', 'Image', '1.2 MB', Iconsax.gallery, AppColorSchemes.primaryPurple),
      _File('Project Demo.mp4', 'Video', '23 MB', Iconsax.video, AppColorSchemes.primaryPink),
    ];

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF000000) : const Color(0xFFF2F2F7),
      appBar: AppBar(title: const Text('Files'), backgroundColor: Colors.transparent,
        actions: [IconButton(icon: const Icon(Iconsax.search_normal), onPressed: () {})],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: files.length,
        itemBuilder: (context, index) {
          final f = files[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: GlassCard(
              padding: const EdgeInsets.all(14),
              child: Row(children: [
                Container(width: 44, height: 44, decoration: BoxDecoration(color: f.color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(12)),
                  child: Icon(f.icon, color: f.color, size: 22)),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(f.name, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text('${f.type} • ${f.size}', style: theme.textTheme.bodySmall),
                ])),
                PopupMenuButton(itemBuilder: (ctx) => [
                  const PopupMenuItem(child: Text('Download')),
                  const PopupMenuItem(child: Text('Share')),
                  const PopupMenuItem(child: Text('Delete')),
                ]),
              ]),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {}, child: const Icon(Iconsax.add)),
    );
  }
}

class _File { final String name, type, size; final IconData icon; final Color color; _File(this.name, this.type, this.size, this.icon, this.color); }
