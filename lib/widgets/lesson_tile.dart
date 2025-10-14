import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class LessonTile extends StatefulWidget {
  final String title;
  final String description;
  final String fileType;
  final String fileUrl;
  final VoidCallback onOpen;

  const LessonTile({
    super.key,
    required this.title,
    required this.description,
    required this.fileType,
    required this.fileUrl,
    required this.onOpen,
  });

  @override
  State<LessonTile> createState() => _LessonTileState();
}

class _LessonTileState extends State<LessonTile> {
  Uint8List? _thumbnail;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  Future<void> _generateThumbnail() async {
    if (widget.fileType == 'video') {
      final thumb = await VideoThumbnail.thumbnailData(
        video: widget.fileUrl,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 200,
        quality: 75,
      );
      setState(() {
        _thumbnail = thumb;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        tileColor: Colors.amberAccent,
        leading: _buildThumbnail(),
        title: Text(widget.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(widget.description, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: IconButton(
          icon: const Icon(Icons.open_in_new),
          onPressed: widget.onOpen,
        ),
      ),
    );
  }

  Widget _buildThumbnail() {
    if (widget.fileType == 'image') {
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(widget.fileUrl, width: 70, height: 70, fit: BoxFit.cover),
      );
    } else if (widget.fileType == 'video') {
      return Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: _thumbnail != null
                ? Image.memory(_thumbnail!, width: 70, height: 70, fit: BoxFit.cover)
                : Container(
                    width: 70,
                    height: 70,
                    color: Colors.grey[300],
                    child: const Center(child: Icon(Icons.videocam, color: Colors.grey)),
                  ),
          ),
          const Icon(Icons.play_circle_fill, color: Colors.white, size: 28),
        ],
      );
    } else {
      return const Icon(Icons.picture_as_pdf, size: 40, color: Colors.redAccent);
    }
  }
}
