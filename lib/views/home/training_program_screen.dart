import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/models/training_frame_model.dart';
import 'package:nlu_portal_app/providers/training_frame_provider.dart';
import 'package:nlu_portal_app/views/widgets/training_items_widget.dart';
import 'package:provider/provider.dart';

class TrainingProgramScreen extends StatefulWidget {
  const TrainingProgramScreen({super.key});

  @override
  State<TrainingProgramScreen> createState() =>
      _TrainingProgramScreenState();
}

class _TrainingProgramScreenState extends State<TrainingProgramScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TrainingFrameProvider>().loadTrainingFrames();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TrainingFrameProvider>();
    final majors = provider.majors;
    final frames = provider.frames;

    final major = majors.isNotEmpty ? majors.first : null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Chương trình đào tạo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : majors.isEmpty || frames.isEmpty
              ? const Center(child: Text('Không có dữ liệu'))
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),

                    _buildMajorHeading('Ngành:', major!.majorName),
                    const SizedBox(height: 5),
                    _buildMajorHeading('Mã ngành:', major.majorId),

                    const SizedBox(height: 10),

                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                        itemCount: frames.length,
                        itemBuilder: (context, index) {
                          return SemesterTile(
                            trainingSemester: frames[index],
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }

  // ================= HEADER =================

  Widget _buildMajorHeading(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.grey),
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ================= SEMESTER TILE =================

class SemesterTile extends StatefulWidget {
  final TrainingSemester trainingSemester;

  const SemesterTile({
    super.key,
    required this.trainingSemester,
  });

  @override
  State<SemesterTile> createState() => _SemesterTileState();
}

class _SemesterTileState extends State<SemesterTile>
    with TickerProviderStateMixin {
  bool isExpanded = false;

  void _toggle() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
          ),
        ],
      ),
      child: Column(
        children: [
          /// HEADER
          InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: _toggle,
            splashColor: Colors.white.withOpacity(0.15),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.trainingSemester.semesterName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  /// ICON ANIMATION
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    child: const Icon(
                      Icons.expand_more,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// CONTENT ANIMATION
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(12),
            ),
            child: AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: isExpanded
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                      child: TrainingItemsWidget(
                        trainingSemester: widget.trainingSemester,
                      ),
                    )
                  : const SizedBox(),
            ),
          ),
        ],
      ),
    );
  }
}