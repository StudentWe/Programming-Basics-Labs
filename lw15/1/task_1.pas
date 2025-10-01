PROGRAM CountChars(INPUT, OUTPUT);
{Подсчитывает количество символов во входном файле}
USES Count3;

VAR
  Ch: CHAR;
  H, T, O: CHAR;

BEGIN
  Start; {Инициализируем счетчик}
  
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(INPUT, Ch);
      Bump {Увеличиваем счетчик на 1 для каждого символа}
    END;
  
  {Выводим результат}
  Value(H, T, O);
  WRITE('Количество символов: ');
  WRITE(H);
  WRITE(T);
  WRITELN(O)
END.
