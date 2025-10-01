PROGRAM CountReverses(INPUT, OUTPUT);
{Подсчитывает количество реверсов во входной строке}
USES Count3;

VAR
  Ch1, Ch2, Ch3: CHAR;
  H, T, O: CHAR;

BEGIN
  Start; {Инициализируем счетчик}
  WRITE(OUTPUT, 'Вход:');

  {Читаем первые три символа}
  IF NOT EOLN(INPUT)
  THEN
    BEGIN
      READ(INPUT, Ch1);
      IF NOT EOLN(INPUT)
      THEN
        BEGIN
          READ(INPUT, Ch2);
          IF NOT EOLN(INPUT)
          THEN
            BEGIN
              READ(INPUT, Ch3);
              {Проверяем первый возможный реверс}
              IF ((Ch2 > Ch1) AND (Ch2 > Ch3)) OR ((Ch2 < Ch1) AND (Ch2 < Ch3))
              THEN
                Bump;
              
              {Продолжаем проверку для остальных символов}
              Ch1 := Ch2;
              Ch2 := Ch3;
              WHILE NOT EOLN(INPUT)
              DO
                BEGIN
                  READ(INPUT, Ch3);
                  IF ((Ch2 > Ch1) AND (Ch2 > Ch3)) OR ((Ch2 < Ch1) AND (Ch2 < Ch3))
                  THEN
                    Bump;
                  Ch1 := Ch2;
                  Ch2 := Ch3
                END
            END
        END
    END;
  
  {Выводим результат}
  Value(H, T, O);
  WRITE(OUTPUT, 'Количество реверсов:');
  WRITE(OUTPUT, H);
  WRITE(OUTPUT, T);
  WRITELN(OUTPUT, O)
END.
