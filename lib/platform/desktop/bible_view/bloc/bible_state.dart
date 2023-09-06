part of 'bible_bloc.dart';

enum BibleViewStatus {
  init,
  loading,
  failure,
  success,
}

class BibleState extends Equatable {
  const BibleState({
    this.status = BibleViewStatus.init,
    this.bibleDataList = const [],
    this.currentChapter,
    this.verseList = const [],
  });
  final BibleViewStatus status;
  final List<BibleDataOld> bibleDataList;
  final BibleChapterOld? currentChapter;
  final List<BibleVerse> verseList;

  @override
  List<Object?> get props => [
        status,
        bibleDataList,
        currentChapter,
        verseList,
      ];

  BibleState copyWith({
    BibleViewStatus? status,
    List<BibleDataOld>? bibleDataList,
    BibleChapterOld? currentChapter,
    List<BibleVerse>? verseList,
  }) {
    return BibleState(
      status: status ?? this.status,
      bibleDataList: bibleDataList ?? this.bibleDataList,
      currentChapter: currentChapter ?? this.currentChapter,
      verseList: verseList ?? this.verseList,
    );
  }
}
