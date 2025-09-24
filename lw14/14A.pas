PROGRAM RecursiveSorting(INPUT, OUTPUT);
VAR
  F1: TEXT;
  Ch: CHAR;

PROCEDURE RecursiveSort(VAR F1: TEXT);
VAR 
  F2, F3: TEXT;
  Ch: CHAR;
  
PROCEDURE Split(VAR F1, F2, F3: TEXT);
{Разбивает F1 на F2, F3}
VAR 
  Ch, Switch: CHAR;
BEGIN {Split}
  RESET(F1);
  REWRITE(F2);
  REWRITE(F3); 
  Switch := '2';
  WHILE NOT (EOLN(F1))
  DO
    BEGIN
      READ(F1, Ch);
      IF (Switch = '2')
      THEN
        BEGIN
          WRITE(F2, Ch);
          Switch := '3';
        END
      ELSE
        BEGIN
          WRITE(F3, Ch);
          Switch := '2';
        END
    END;
  WRITELN(F2);
  WRITELN(F3);
END; {Split}

BEGIN {RecursiveSort} 
  RESET(F1);
  IF NOT (EOLN(F1))
  THEN
    BEGIN
      IF NOT (EOLN(F1))
      THEN {Файл имеет как минимум 2 символа}
        BEGIN
          Split(F1, F2, F3);
          RESET(F2);
          WHILE NOT EOLN (F2)
          DO
            BEGIN
              READ(F2, Ch);
              WRITE(OUTPUT, Ch)
            END;
          WRITELN(OUTPUT); 
          RESET(F3);
          WHILE NOT EOLN (F3)
          DO
            BEGIN
              READ(F3, Ch);
              WRITE(OUTPUT, Ch)
            END;
          WRITELN(OUTPUT);    
          {RecursiveSort(F2);
          RecursiveSort(F3);}
          {Merge(F1, F2, F3)}
        END
    END
END;   {RecursiveSort}

BEGIN
  REWRITE(F1);
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(INPUT, Ch);
      WRITE(F1, Ch)
    END;
  WRITELN(F1);
  RecursiveSort(F1)    
END.
