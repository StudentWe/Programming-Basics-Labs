PROGRAM BubbleSort(INPUT, OUTPUT);
VAR
  F1: TEXT;

PROCEDURE CopyFile(VAR InFile, OutFile: TEXT);
VAR
  Ch: CHAR;
BEGIN
  REWRITE(OutFile);
  RESET(InFile);
  WHILE NOT EOLN(InFile)
  DO
    BEGIN
      READ(InFile, Ch);
      WRITE(OutFile, Ch)
    END;
  WRITELN(OutFile)
END;

BEGIN
  CopyFile(INPUT, F1);
  CopyFile(F1, OUTPUT)
END.
