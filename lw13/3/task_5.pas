PROGRAM Split(INPUT,OUTPUT);
  {Копирует INPUT в OUTPUT,сначала нечетные,а затем четные
   элементы}
VAR
  Ch: CHAR;
  Odds, Evens, TempFile: TEXT;

// DP1.1
PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);
BEGIN
  {Копируем F1 в OUTPUT}
  RESET(F1);
  WHILE NOT EOF(F1)
  DO
    BEGIN
      WHILE NOT EOLN(F1)
      DO
        BEGIN
          READ(F1, Ch);
          WRITE(Ch)
        END;
      READLN(F1);
      IF NOT EOF(F1)
      THEN
        WRITELN
    END
END;

// DP1.2
{Разделяет INPUT в Odds и Evens}
PROCEDURE SplitOddsAndEvens(VAR SourceFile: TEXT);
VAR
  Next: CHAR;
BEGIN
  RESET(SourceFile);
  REWRITE(Odds);
  REWRITE(Evens);
  Next := 'O';
  WHILE NOT EOF(SourceFile)
  DO
    BEGIN
      WHILE NOT EOLN(SourceFile)
      DO
        BEGIN
          READ(SourceFile, Ch);
          IF Next = 'O'
          THEN
            BEGIN
              WRITE(Odds, Ch);
              Next := 'E'
            END
          ELSE
            BEGIN
              WRITE(Evens, Ch);
              Next := 'O'
            END
        END;
      READLN(SourceFile);
      WRITE(Odds);
      WRITE(Evens);
      Next := 'O'
    END
END;

BEGIN
  {Создаем временный файл и копируем в него две первые строки INPUT}
  REWRITE(TempFile);
  IF NOT EOF(INPUT)
  THEN
    BEGIN
      WHILE NOT EOLN(INPUT)
      DO
        BEGIN
          READ(INPUT, Ch);
          WRITE(TempFile, Ch)
        END;
      READLN(INPUT);
      WRITELN(TempFile)
    END;
  IF NOT EOF(INPUT)
  THEN
    BEGIN
      WHILE NOT EOLN(INPUT)
      DO
        BEGIN
          READ(INPUT, Ch);
          WRITE(TempFile, Ch)
        END;
      READLN(INPUT);
      WRITELN(TempFile)
    END;  
  
  SplitOddsAndEvens(TempFile);
  CopyOut(Odds, Ch);
  CopyOut(Evens, Ch);
  WRITELN
END.
