class CongitiveEntry {
  final double meanrr;
  final double snsindex;
  final double rmssd;
  final double pnsindex;
  final double lfhfratio;
  const CongitiveEntry(
      {this.meanrr = 0,
      this.snsindex = 0,
      this.rmssd = 0,
      this.pnsindex = 0,
      this.lfhfratio = 0});

  double getValue(CongnitiveLoad type) {
    switch (type) {
      case CongnitiveLoad.meanrr:
        return meanrr;
      case CongnitiveLoad.snsindex:
        return snsindex;
      case CongnitiveLoad.rmssd:
        return rmssd;
      case CongnitiveLoad.pnsindex:
        return pnsindex;
      case CongnitiveLoad.lfhfratio:
        return lfhfratio;
    }
  }
}

enum CongnitiveLoad {
  lfhfratio(title: 'LF/HF Ratio'),
  meanrr(title: 'Mean RR'),
  pnsindex(title: 'PNS Index'),
  snsindex(title: 'SNS Index'),
  rmssd(title: 'RMSSD');

  const CongnitiveLoad({
    required this.title,
  });
  final String title;
}
