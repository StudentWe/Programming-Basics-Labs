UNIT FileUtils;

INTERFACE

CONST
  TempFileName = 'temp_file.txt';

USES
  TreeUtils, WordType;

CONST
  Alphabet = ['a'..'z', 'A'..'Z', 'а'..'я', 'А'..'Я', 'ё', 'Ё', '-'];
  DependenceAlphabet = ['-'];
  WordsPerBatch = 50000;

FUNCTION CharToLower(C: CHAR): CHAR;
FUNCTION IsWordChar(C: CHAR): BOOLEAN;
FUNCTION ReadWord(VAR F: TEXT; VAR W: Word): BOOLEAN;
PROCEDURE ProcessFile(VAR F, OutputFile: TEXT; VAR Root: TreeNodePointer);
PROCEDURE MergeFiles(VAR Root: TreeNodePointer; VAR TempFile, OutputFile: TEXT);

IMPLEMENTATION

FUNCTION CharToLower(C: CHAR): CHAR;
BEGIN
  CASE C OF
    'A'..'Z': CharToLower := CHR(ORD(C) + 32);
    'А'..'Я': CharToLower := CHR(ORD(C) + 32);
    'Ё': CharToLower := 'ё';
    ELSE CharToLower := C
  END
END;

FUNCTION IsWordChar(C: CHAR): BOOLEAN;
BEGIN
  IsWordChar := C IN Alphabet
END;

FUNCTION ReadWord(VAR F: TEXT; VAR W: Word): BOOLEAN;
VAR
  C: CHAR;
  Chars: ARRAY[1..MaxWordLength] OF CHAR;
  Pos: INTEGER;
  InWord, IsWordRead: BOOLEAN;
BEGIN
  Pos := 1;
  InWord := FALSE;
  IsWordRead := FALSE;
  
  WHILE (NOT EOF(F)) AND (NOT IsWordRead)
  DO
    BEGIN
      READ(F, C);
      C := CharToLower(C);
      
      IF (IsWordChar(C)) AND (InWord OR NOT (C IN DependenceAlphabet))
      THEN
        BEGIN
          InWord := TRUE;
          IF Pos <= MaxWordLength
          THEN
            BEGIN
              Chars[Pos] := C;
              Pos := Pos + 1
            END
        END
      ELSE 
        IF InWord
        THEN
          BEGIN
            AssignWord(W, Chars, Pos - 1);
            IsWordRead := TRUE
          END
    END;
  
  IF InWord
  THEN
    BEGIN
      AssignWord(W, Chars, Pos - 1);
      IsWordRead := TRUE
    END;

  ReadWord := IsWordRead
END;

PROCEDURE MergeFiles(VAR Root: TreeNodePointer; VAR TempFile, OutputFile: TEXT);
VAR
  CurrentWord, LastWord: Word;
  CurrentCount: INTEGER;
  I: INTEGER;
  C: CHAR;
  Node: TreeNodePointer = NIL;
BEGIN
  REWRITE(TempFile);
  RESET(OutputFile);
  I := 0;
  LastWord.Length := -1;

  WHILE NOT EOF(OutputFile) 
  DO
    BEGIN
      CurrentWord.Length := 0;
      I := 1;
      REPEAT
        READ(OutputFile, C);
        IF C <> ' ' 
        THEN
          BEGIN
            CurrentWord.Chars[I] := C;
            I := I + 1;
            CurrentWord.Length := CurrentWord.Length + 1
          END
      UNTIL (C = ' ') OR EOF(OutputFile);
      
      READLN(OutputFile, CurrentCount);

      IF Root <> NIL
      THEN
        BEGIN
          IF FindWordNode(Root, Node, CurrentWord)
          THEN
            BEGIN
              CurrentCount := CurrentCount + Node^.Count;
              RemoveWordNode(Root, Node)
            END
          ELSE
            BEGIN
              WHILE (GetFirstWordNode(Root, Node)) AND (CurrentWord > Node^.Word) 
              DO
                BEGIN
                  WriteWord(TempFile, Node^.Word);
                  WRITELN(TempFile, ' ', Node^.Count);

                  //IF LastWord >= CurrentWord
                  //THEN
                  //  BEGIN
                  //    READLN;
                  //    WRITELN('---');
                  //    WriteWord(OUTPUT, Node^.Word);
                  //    WriteWord(OUTPUT, Node^.Word);
                  //    WRITELN('---')
                  //  END;

                  RemoveWordNode(Root, Node)
                END;
            END
        END;
      
      //IF (LastWord.Length <> -1) AND (LastWord > CurrentWord)
      //THEN
      //  BEGIN
      //    WRITELN('---');
      //    WriteWord(OUTPUT, CurrentWord);
      //    WRITELN;
      //    WriteWord(OUTPUT, LastWord);
      //    WRITELN('---');
      //    READLN
      //  END;

      LastWord := CurrentWord;
      WriteWord(TempFile, CurrentWord);
      WRITELN(TempFile, ' ', CurrentCount)
    END;
  
  CLOSE(OutputFile);
  
  // Тут все хорошо (продебажил), остается обычно одно слово на 'я'
  IF Root <> NIL 
  THEN
    BEGIN
      //IF I >= 1
      //THEN
      //  BEGIN
      //    WRITELN('I: ', I);
      //    WRITELN('Остатки: ');
      //    SaveTreeToFile(Root, OUTPUT);
      //    READLN
      //  END
      //ELSE
      //  WRITELN('Первый прошел');
      SaveTreeToFile(Root, TempFile)
    END;
  
  CLOSE(TempFile);
  RESET(TempFile);
  REWRITE(OutputFile);
  WHILE NOT EOF(TempFile)
  DO
    BEGIN
      WHILE NOT EOLN(TempFile)
      DO
        BEGIN
          READ(TempFile, C);
          WRITE(OutputFile, C)
        END;
      READLN(TempFile);
      WRITELN(OutputFile)
    END;
  CLOSE(TempFile);
  CLOSE(OutputFile)
END;

PROCEDURE ProcessFile(VAR F, OutputFile: TEXT; VAR Root: TreeNodePointer);
VAR
  TempFile: TEXT;
  W: Word;
  WordCount: INTEGER;
BEGIN
  WordCount := 0;
  ASSIGN(TempFile, TempFileName);
  REWRITE(OutputFile);
  CLOSE(OutputFile);

  RESET(F);
  WHILE ReadWord(F, W)
  DO
    BEGIN
      InsertWord(Root, W);
      WordCount := WordCount + 1;
      
      IF WordCount MOD WordsPerBatch = 0 
      THEN
        BEGIN
          WRITELN('Начата запись батча');
          MergeFiles(Root, TempFile, OutputFile);
          FreeTree(Root);
          WRITELN('Записан один батч');
          Root := NIL
        END
    END;

  IF Root <> NIL
  THEN
    MergeFiles(Root, TempFile, OutputFile)
END;

END.
