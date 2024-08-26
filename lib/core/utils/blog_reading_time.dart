int calculateBlogReadingTime(String content) {
  final trimmedContent = content.trim();

  if (trimmedContent.isEmpty) return 0;

  final totalWords = trimmedContent.split(RegExp(r'\b\w+\b')).length;

  final totalDuration = totalWords / 225;

  return totalDuration.ceil();
}
