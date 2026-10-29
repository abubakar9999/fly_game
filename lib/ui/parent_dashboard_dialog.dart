import 'package:flutter/material.dart';

import '../app/strings.dart';
import '../services/storage_service.dart';

/// Parent Corner dialog with a gentle child-lock gate, learning progress stats, and screen-time tips.
class ParentDashboardDialog extends StatefulWidget {
  final StorageService storageService;

  const ParentDashboardDialog({super.key, required this.storageService});

  @override
  State<ParentDashboardDialog> createState() => _ParentDashboardDialogState();
}

class _ParentDashboardDialogState extends State<ParentDashboardDialog> {
  bool _isUnlocked = false;
  final int _correctAnswer = 5; // Gate question: 2 + 3 = 5

  int _totalStickers = 0;
  int _totalStars = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final stickers = await widget.storageService.getUnlockedStickers();
    final stars = await widget.storageService.getTotalStars();
    if (mounted) {
      setState(() {
        _totalStickers = stickers.length;
        _totalStars = stars;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBn = GameStrings.currentLanguage == AppLanguage.bn;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
      child: Container(
        padding: const EdgeInsets.all(22.0),
        decoration: BoxDecoration(
          color: const Color(0xFF131926).withValues(alpha: 0.98),
          borderRadius: BorderRadius.circular(28.0),
          border: Border.all(color: const Color(0xFF64B5F6), width: 2.5),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF64B5F6).withValues(alpha: 0.25),
              blurRadius: 20.0,
              spreadRadius: 2.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(width: 32.0),
                Text(
                  isBn ? '👨‍👩‍👧 অভিভাবক কর্নার' : '👨‍👩‍👧 Parent Dashboard',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded, color: Colors.white70),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 12.0),

            if (!_isUnlocked) ...[
              // Parent verification gate so young kids don't enter accidentally
              Text(
                isBn ? 'অভিভাবক যাচাই: ২ + ৩ = কত?' : 'Parents Only Gate: What is 2 + 3 = ?',
                style: const TextStyle(color: Color(0xFFFFD54F), fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 14.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [4, 5, 6].map((number) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E2638),
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Color(0xFF64B5F6)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.0)),
                      ),
                      onPressed: () {
                        if (number == _correctAnswer) {
                          setState(() {
                            _isUnlocked = true;
                          });
                        }
                      },
                      child: Text('$number', style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold)),
                    ),
                  );
                }).toList(),
              ),
            ] else ...[
              // Unlocked Parent Dashboard Content
              if (_isLoading)
                const Center(child: CircularProgressIndicator())
              else
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatTile(
                      icon: '🔤',
                      title: isBn ? 'শেখা অক্ষর ও সংখ্যা' : 'Mastered Letters & Numbers',
                      value: '$_totalStickers',
                    ),
                    const SizedBox(height: 10.0),
                    _buildStatTile(
                      icon: '⭐',
                      title: isBn ? 'মোট সংগৃহীত মহাকাশ তারা' : 'Total Cosmic Stars',
                      value: '$_totalStars',
                    ),
                    const SizedBox(height: 16.0),
                    Container(
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.favorite_rounded, color: Color(0xFFFF5252), size: 26.0),
                          const SizedBox(width: 10.0),
                          Expanded(
                            child: Text(
                              isBn
                                  ? '১০০% শিশুবান্ধব ও বিজ্ঞাপনমুক্ত শিক্ষামূলক পরিবেশ।'
                                  : '100% kid-safe, ad-free educational environment.',
                              style: TextStyle(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontSize: 13.0,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildStatTile({required String icon, required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2638),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.white12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(icon, style: const TextStyle(fontSize: 22.0)),
              const SizedBox(width: 10.0),
              Text(title, style: const TextStyle(color: Colors.white, fontSize: 15.0)),
            ],
          ),
          Text(
            value,
            style: const TextStyle(color: Color(0xFF00E676), fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
