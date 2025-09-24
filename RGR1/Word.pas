UNIT Word;

INTERFACE

CONST
  MaxWordLength = 50;
  AlphabetMaxLength = 200;   
  Alphabet = ['a'..'z', 'A'..'Z', 'à'..'ÿ', 'À'..'ß', '¸', '¨', '-'];
  DependenceAlphabet = ['-'];

TYPE
  WordType = RECORD
              Chars: ARRAY[1 .. MaxWordLength] OF CHAR;
              Length: INTEGER
             END;

VAR
  AlphabetOrder: ARRAY[1..AlphabetMaxLength] OF CHAR;
  AlphabetOrderLength: INTEGER = 0;

PROCEDURE AssignWord(VAR W: WordType; CONST S: ARRAY OF CHAR; Size: INTEGER);
FUNCTION WordsEqual(CONST A, B: WordType): BOOLEAN;
FUNCTION WordLess(CONST A, B: WordType): BOOLEAN;
FUNCTION WordGreater(CONST A, B: WordType): BOOLEAN;
PROCEDURE WriteWord(VAR F: TEXT; CONST W: WordType);
PROCEDURE SetAlphabet(VAR AlphabetFile: TEXT);

OPERATOR = (A, B: WordType) Result: BOOLEAN;
OPERATOR < (A, B: WordType) Result: BOOLEAN;
OPERATOR > (A, B: WordType) Result: BOOLEAN;

IMPLEMENTATION

PROCEDURE AssignWord(VAR W: WordType; CONST S: ARRAY OF CHAR; Size: INTEGER);
VAR
  I: INTEGER;
BEGIN
  W.Length := Size;
  IF W.Length > MaxWordLength 
  THEN 
    W.Length := MaxWordLength;

  FOR I := 1 TO W.Length 
  DO
    W.Chars[I] := S[I-1]
END;

FUNCTION WordsEqual(CONST A, B: WordType): BOOLEAN;
VAR
  I: INTEGER;
BEGIN
  IF A.Length <> B.Length
  THEN
    WordsEqual := FALSE
  ELSE
    BEGIN
      WordsEqual := TRUE;
      FOR I := 1 TO A.Length 
      DO
        IF A.Chars[I] <> B.Chars[I] 
        THEN
          WordsEqual := FALSE
    END
END;

FUNCTION WordLess(CONST A, B: WordType): BOOLEAN;
VAR
  I, MinLen: INTEGER;
  PosA, PosB: INTEGER;
  J: INTEGER;
  FoundA, FoundB, IsSuccess: BOOLEAN;
BEGIN
  MinLen := A.Length;
  IF B.Length < MinLen 
  THEN
    MinLen := B.Length;
  
  FOR I := 1 TO MinLen 
  DO
  BEGIN
    PosA := 0;
    PosB := 0;
    FoundA := FALSE;
    FoundB := FALSE;
    
    FOR J := 1 TO AlphabetOrderLength 
    DO
      BEGIN
        IF NOT FoundA AND (AlphabetOrder[J] = A.Chars[I]) 
        THEN
          BEGIN
            PosA := J;
            FoundA := TRUE
          END;
        
        IF NOT FoundB AND (AlphabetOrder[J] = B.Chars[I]) 
        THEN
          BEGIN
            PosB := J;
            FoundB := TRUE
          END
      END;
    
    IsSuccess := FALSE;
    IF FoundA AND FoundB 
    THEN
      BEGIN
        IF PosA < PosB 
        THEN
          BEGIN
            WordLess := TRUE;
            IsSuccess := TRUE
          END
        ELSE IF PosA > PosB 
        THEN
          BEGIN
            WordLess := FALSE;
            IsSuccess := TRUE
          END
      END
    ELSE
    BEGIN
      IF A.Chars[I] < B.Chars[I] 
      THEN
        BEGIN
          WordLess := TRUE;
          IsSuccess := TRUE
        END
      ELSE IF A.Chars[I] > B.Chars[I] 
      THEN
        BEGIN
          WordLess := FALSE;
          IsSuccess := TRUE
        END
    END
  END;
  
  IF IsSuccess = FALSE
  THEN
    WordLess := (A.Length < B.Length)
END;

FUNCTION WordGreater(CONST A, B: WordType): BOOLEAN;
BEGIN
  WordGreater := (NOT WordLess(A, B)) AND (NOT WordsEqual(A, B))
END;

PROCEDURE WriteWord(VAR F: TEXT; CONST W: WordType);
VAR
  I: INTEGER;
BEGIN
  FOR I := 1 TO W.Length
  DO
    WRITE(F, W.Chars[I])
END;

PROCEDURE SetAlphabet(VAR AlphabetFile: TEXT);
VAR
  Ch: CHAR;
BEGIN
  AlphabetOrderLength := 0;
  RESET(AlphabetFile);
  WHILE NOT EOLN(AlphabetFile)
  DO
    BEGIN
      READ(AlphabetFile, Ch);
      AlphabetOrderLength := AlphabetOrderLength + 1;
      AlphabetOrder[AlphabetOrderLength] := Ch
    END
END;

OPERATOR = (A, B: WordType) Result: BOOLEAN;
BEGIN
  Result := WordsEqual(A, B)
END;

OPERATOR < (A, B: WordType) Result: BOOLEAN;
BEGIN
  Result := WordLess(A, B)
END;

OPERATOR > (A, B: WordType) Result: BOOLEAN;
BEGIN
  Result := WordGreater(A, B)
END;

BEGIN
END.
