import 'package:flutter/material.dart';
import 'package:nlu_portal_app/core/theme/app_colors.dart';
import 'package:nlu_portal_app/models/semester_result_model.dart';
import 'package:nlu_portal_app/providers/result_provider.dart';
import 'package:nlu_portal_app/views/widgets/score_items_widget.dart';
import 'package:provider/provider.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ResultProvider>().loadResults();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ResultProvider>();
    final results = provider.results;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Điểm thi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: results.isEmpty || provider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: results.length,
              itemBuilder: (context, index) {
                final result = results[index];

                return _buildSemesterTile(semesterResult: result);
              },
            ),
    );
  }

  // Semester Heading
  Widget _buildSemesterTile({required SemesterResult semesterResult}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Theme(
          data: ThemeData().copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            title: Text(
              semesterResult.semesterName,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            iconColor: Colors.white,
            collapsedIconColor: Colors.white,
            backgroundColor: AppColors.primary,
            collapsedBackgroundColor: AppColors.primary,

            children: [ScoreItemsWidget(semesterResult: semesterResult)],
          ),
        ),
      ),
    );
  }
}
