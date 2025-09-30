## 13.2 [#20]
Найдите и исправьте ошибки в процедуре Lexico. Процедура определяет меньшее из 2 слов (слова находятся в первой строке файла, отношение «меньше» определяется как в словаре). Например, строка ABC меньше строки ABD, а строка ABC меньше строки ABCD. 
Чтобы запустить процедуру Lexico, считайте первую строку из INPUT в F1, а вторую - в F2.

### Итоговое выполнение:
INPUT: 123
123
OUTPUT: Слова равны


INPUT: 123
12345
OUTPUT: Первое слово меньше второго

### Разделы

PROCEDURE Lexico(VAR F1, F2: TEXT; VAR Result: CHAR);
{Result 0, 1, 2 если лексикографический порядок F1 =, <, > чем F2       
соответственно. Фактические параметры, соответствующие F1 и F2,
должны быть различными}


VAR
  Ch1, Ch2: CHAR;
BEGIN {Lexico}
  RESET(F1);
  RESET(F2);
  Result := '0';
  WHILE (NOT EOLN(F1) AND NOT EOLN(F2)) AND (Result = '0')
  DO
    BEGIN
      READ(F1, Ch1);
      READ(F2, Ch2);
      IF (Ch1 < Ch2)
      THEN {Ch1 < Ch2 или F1 короче F2}
        Result := '1'
      ELSE
        IF (Ch1 > Ch2)
        THEN {Ch1 > Ch2 или F2 короче F1}
          Result := '2'
    END {WHILE}
END; {Lexico}
