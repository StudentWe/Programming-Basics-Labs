UNIT FileUtils;

INTERFACE

USES
  TreeUtils, Word;

FUNCTION CharToLower(C: CHAR): CHAR;
FUNCTION ReadWord(VAR F: TEXT; VAR W: WordType): BOOLEAN;
PROCEDURE SaveToFile(VAR OutputFile: TEXT);
PROCEDURE InsertWord(CONST W: WordType);

IMPLEMENTATION

VAR
  Root: TreeNodePointer = NIL;

FUNCTION CharToLower(C: CHAR): CHAR;
BEGIN
  CASE C OF
    'A'..'Z': CharToLower := CHR(ORD(C) + 32);
    'À'..'ß': CharToLower := CHR(ORD(C) + 32);
    '¨': CharToLower := '¸';
    ELSE CharToLower := C
  END
END;

FUNCTION ReadWord(VAR F: TEXT; VAR W: WordType): BOOLEAN;
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
      
      IF (C IN AlphabetOrder) AND (InWord OR NOT (C IN DependenceAlphabet))
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

PROCEDURE InsertWord(CONST W: WordType);
BEGIN
  InsertWordInTree(Root, W)
END;

PROCEDURE SaveToFile(VAR OutputFile: TEXT);
BEGIN
  IF Root <> NIL 
  THEN
    BEGIN               
      REWRITE(OutputFile);
      TraverseAndSave(Root, OutputFile)
    END;

  FreeTree(Root)
END;

BEGIN
END.
