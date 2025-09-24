PROGRAM RecursiveSorting(INPUT, OUTPUT);
VAR
  F1: TEXT;
  Ch: CHAR;

PROCEDURE RecursiveSort(VAR F1: TEXT);
VAR 
  F2, F3: TEXT;
  Ch: CHAR;
PROCEDURE Split(VAR F1, F2, F3: TEXT);
{��������� F1 �� F2, F3}
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

PROCEDURE Merge(VAR F1, F2, F3: TEXT);
{������� F2, F3 � F1  � ������������� �������}
VAR 
  Ch2, Ch3: CHAR;
BEGIN {Merge}
  RESET(F2);
  RESET(F3);
  REWRITE(F1);
  Ch2 := '';
  Ch3 := '';
  IF NOT EOLN(F2)
  THEN 
    READ(F2, Ch2);
  IF NOT EOLN(F3)
  THEN         
    READ(F3, Ch3);        
  WHILE (NOT(EOLN(F2))) AND (NOT(EOLN(F3)))
  DO
    BEGIN
      IF Ch2 < Ch3
      THEN 
        BEGIN
          WRITE(F1, Ch2);
          READ(F2, Ch2)
        END
      ELSE
        BEGIN
          WRITE(F1, Ch3);
          READ(F3, Ch3)
        END
    END;
  IF Ch2 < Ch3
  THEN
    BEGIN
      WRITE(F1, Ch2);  
      WHILE NOT (EOLN(F2))
      DO
        BEGIN
          WRITE(F1, Ch2);
          READ(F2, Ch2)
        END;
      WRITE(F1, Ch3)
    END;  
  IF Ch2 >= Ch3
  THEN
    BEGIN 
      WRITE(F1, Ch3);     
      WHILE NOT (EOLN(F3))
      DO
        BEGIN
          WRITE(F1, Ch3);
          READ(F3, Ch3)
        END;
      WRITE(F1, Ch2)
    END;         
  WRITELN(F1);       
END; {Merge}

BEGIN {RecursiveSort} 
  RESET(F1);
  IF NOT (EOLN(F1))
  THEN
    BEGIN
      READ(F1, Ch);
      IF NOT (EOLN(F1))
      THEN {���� ����� ��� ������� 2 �������}
        BEGIN
          RESET(F1);
          Split(F1, F2, F3);
         { RESET(F2);
          WHILE NOT EOLN(F2)
          DO
            BEGIN
              READ(F2, Ch);
              WRITE(OUTPUT, Ch)
            END;
          WRITELN(OUTPUT); 
          RESET(F3);
          WHILE NOT EOLN(F3)
          DO
            BEGIN
              READ(F3, Ch);
              WRITE(OUTPUT, Ch)
            END;
          WRITELN(OUTPUT);  }  
          RecursiveSort(F2);
          RecursiveSort(F3);
          Merge(F1, F2, F3)  
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
  RecursiveSort(F1);
  RESET(F1);
  WHILE NOT EOLN(F1)
  DO 
    BEGIN
      READ(F1, Ch);
      WRITE(OUTPUT, Ch)
    END;
  WRITELN(OUTPUT)        
END.
