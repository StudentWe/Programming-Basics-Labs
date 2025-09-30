PROGRAM TestLexico;

PROCEDURE Lexico(VAR F1, F2: TEXT; VAR Result: CHAR);
{Result 0, 1, 2 если лексикографический пор€док F1 =, <, > чем F2       
соответственно. ‘актические параметры, соответствующие F1 и F2,
должны быть различными}

VAR
  Ch1, Ch2: CHAR;
BEGIN {Lexico}
  RESET(F1);
  RESET(F2);
  Result := '0';
  WHILE (NOT EOLN(F1)) AND (NOT EOLN(F2)) AND (Result = '0')
  DO
    BEGIN
      READ(F1, Ch1);
      READ(F2, Ch2);
      IF Ch1 < Ch2
      THEN
        Result := '1'
      ELSE
        IF Ch1 > Ch2
        THEN
          Result := '2'
    END; {WHILE}
  
  {ѕроверка случа€, когда строки разной длины}
  IF Result = '0'
  THEN
    BEGIN
      IF EOLN(F1) AND (NOT EOLN(F2))
      THEN
        Result := '1'  {F1 короче F2}
      ELSE
        IF (NOT EOLN(F1)) AND EOLN(F2)
        THEN
          Result := '2'  {F2 короче F1}
    END
END; {Lexico}

VAR
  F1, F2: TEXT;
  Res: CHAR;
  Ch: CHAR;

BEGIN
  REWRITE(F1);
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(INPUT, Ch);
      WRITE(F1, Ch)
    END;
  READLN(INPUT);

  REWRITE(F2);
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(INPUT, Ch);
      WRITE(F2, Ch)
    END;
  READLN(INPUT);
  
  Lexico(F1, F2, Res);
  
  IF Res = '0'
  THEN
    WRITELN(OUTPUT, '—лова равны')
  ELSE
    IF Res = '1'
    THEN
      WRITELN(OUTPUT, 'ѕервое слово меньше второго')
    ELSE
      WRITELN(OUTPUT, 'ѕервое слово больше второго');
      
  CLOSE(F1);
  CLOSE(F2)
END.
