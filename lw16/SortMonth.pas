PROGRAM SortMonth(INPUT, OUTPUT);
USES 
  DateIO;

VAR
  Mo1, Mo2: Month;

BEGIN
  ReadMonth(INPUT, Mo1);
  ReadMonth(INPUT, Mo2);
  
  IF (Mo1 = NoMonth) OR (Mo2 = NoMonth) 
  THEN
    WRITE(OUTPUT, '¬ходные данные записаны неверно')
  ELSE 
    IF Mo1 = Mo2 
    THEN
      BEGIN
        WRITE(OUTPUT, 'ќба мес€ца ');
        WriteMonth(OUTPUT, Mo1)
      END
    ELSE 
      IF Mo1 < Mo2 
      THEN
        BEGIN
          WriteMonth(OUTPUT, Mo1);
          WRITE(OUTPUT, ' предшествует ');
          WriteMonth(OUTPUT, Mo2)
        END
      ELSE
        BEGIN
          WriteMonth(OUTPUT, Mo1);
          WRITE(OUTPUT, ' следует за ');
          WriteMonth(OUTPUT, Mo2)
        END;
  WRITELN
END.
