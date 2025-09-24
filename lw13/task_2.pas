PROGRAM BubbleSort(INPUT, OUTPUT);
VAR
  F1, F2: TEXT;
  Sorted: CHAR;

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

PROCEDURE CopyAndSwap(VAR F1, F2: TEXT; VAR Sorted: CHAR);
VAR
  Ch1, Ch2: CHAR;
BEGIN
  REWRITE(F2);
  RESET(F1);
  Sorted := 'Y';
  
  IF NOT EOLN(F1) 
  THEN
    BEGIN
      READ(F1, Ch1);
      WHILE NOT EOLN(F1) 
      DO
        BEGIN
          READ(F1, Ch2);
          IF Ch1 <= Ch2 
          THEN
            BEGIN
              WRITE(F2, Ch1);
              Ch1 := Ch2
            END
          ELSE
            BEGIN
              WRITE(F2, Ch2);
              Sorted := 'N'
            END
        END;
      WRITE(F2, Ch1)
    END;
  WRITELN(F2)
END;

BEGIN
  CopyFile(INPUT, F1);
  CopyAndSwap(F1, F2, Sorted);
  WRITELN('Отсортирован ли список: ', Sorted);
  WRITELN('Список после одного цикла сортировки: ');
  CopyFile(F2, OUTPUT)
END.
