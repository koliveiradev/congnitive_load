String formatDuration(Duration duration) {
  return duration.toString().split('.').first.padLeft(8, "0").substring(0, 5);
}
