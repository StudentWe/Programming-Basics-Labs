UNIT WordType;

INTERFACE

CONST
  MaxWordLength = 50;

TYPE
  Word = RECORD
    Chars: ARRAY[1..MaxWordLength] OF CHAR;
    Length: INTEGER
  END;

PROCEDURE AssignWord(VAR W: Word; CONST S: ARRAY OF CHAR; Size: INTEGER);
FUNCTION WordsEqual(CONST A, B: Word): BOOLEAN;
FUNCTION WordLess(CONST A, B: Word): BOOLEAN;
FUNCTION WordGreater(CONST A, B: Word): BOOLEAN;
PROCEDURE WriteWord(VAR F: TEXT; CONST W: Word);

OPERATOR = (A, B: Word) Result: BOOLEAN;
OPERATOR < (A, B: Word) Result: BOOLEAN;
OPERATOR > (A, B: Word) Result: BOOLEAN;

IMPLEMENTATION

PROCEDURE AssignWord(VAR W: Word; CONST S: array of Char; Size: INTEGER);
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

FUNCTION WordsEqual(CONST A, B: Word): BOOLEAN;
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

FUNCTION WordLess(CONST A, B: Word): BOOLEAN;
VAR
  I, MinLen: INTEGER;
  HasResult: BOOLEAN;
BEGIN
  MinLen := A.Length;
  IF B.Length < MinLen 
  THEN
    MinLen := B.Length;
  
  WordLess := FALSE;
  HasResult := FALSE;
  FOR I := 1 TO MinLen
  DO
    BEGIN
      IF NOT HasResult
      THEN
        IF A.Chars[I] < B.Chars[I]
        THEN
          BEGIN
            WordLess := TRUE;
            HasResult := TRUE
          END
        ELSE
          IF A.Chars[I] > B.Chars[I] 
          THEN
            BEGIN
              WordLess := FALSE;
              HasResult := TRUE
            END
    END;
  
  IF NOT HasResult
  THEN
    WordLess := (A.Length < B.Length)
END;

FUNCTION WordGreater(CONST A, B: Word): BOOLEAN;
BEGIN
  WordGreater := (NOT WordLess(A, B)) AND (NOT WordsEqual(A, B))
END;

PROCEDURE WriteWord(VAR F: TEXT; CONST W: Word);
VAR
  I: INTEGER;
BEGIN
  FOR I := 1 TO W.Length
  DO
    WRITE(F, W.Chars[I])
END;

OPERATOR = (A, B: Word) Result: BOOLEAN;
BEGIN
  Result := WordsEqual(A, B)
END;

OPERATOR < (A, B: Word) Result: BOOLEAN;
BEGIN
  Result := WordLess(A, B)
END;

OPERATOR > (A, B: Word) Result: BOOLEAN;
BEGIN
  Result := WordGreater(A, B)
END;

END.
