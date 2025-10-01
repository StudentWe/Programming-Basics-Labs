## 15.2 [#30]
Проведите сборку и проверьте работу программы TestRemove. Тексты модуля и разделов проекта приведены ниже. 
В модуле восстановите процедуру AddQ.

#### Итоговое выполнение
```
INPUT:Hello    world   this   is   a   test
OUTPUT:Вход:Hello    world   this   is   a   test
Hello    world   this   is   a   test
Выход:Hello world this is a test
```

Разделы проекта программы TestRemove
```
PROGRAM TestRemove(INPUT,OUTPUT);
  {Читает строку из входа ,пропускает ее через RemoveExtraBlanks}
USES Queue;
VAR
  Ch: CHAR;
PROCEDURE RemoveExtraBlanks;
  {Удаляет лишниe пробелы между словами на одной строке}


BEGIN {TestRemove}
  EmptyQ;
  WRITE('Вход:');
  WHILE NOT EOLN
  DO
    BEGIN
      READ(Ch);
      WRITE(Ch);
      AddQ(Ch);
    END;
  WRITELN;
  RemoveExtraBlanks;
  WRITE('Выход:');
  HeadQ(Ch);
  WHILE Ch <> '#'
  DO
    BEGIN
      WRITE(Ch);
      DelQ;
      HeadQ(Ch)
    END;
  WRITELN
END. {TestRemove}


DP1
PROCEDURE RemoveExtraBlanks;
{Удаляет лишниe пробелы между словами на одной строке}
VAR
  Ch ,Blank, LineEnd: CHAR;
BEGIN {RemoveExtraBlanks}
  Blank := ' ';
  LineEnd :='$';
  AddQ(LineEnd); {помечаем конец текста в очереди}
  HeadQ(Ch);
  {удаляем пробелы}
  WHILE Ch <> LineEnd
  DO
    BEGIN
      {читаем слово}
      {удаляем пробелы}
      {Вставляем пробел между словами}
    END;
  DelQ {удаяем LineEnd из очереди}
END; {RemoveExtraBlanks}


DP1.1
{удаляем пробелы}
      WHILE Ch = Blank
      DO
        BEGIN
          DelQ;
          HeadQ(Ch)
        END;


DP1.2
{читаем слово}
       WHILE (Ch <> Blank) AND (Ch <> LineEnd)
       DO
         BEGIN
           AddQ(Ch);
           DelQ;
           HeadQ(Ch)
         END;


DP1.3
{Вставляем пробел между словами}
       IF Ch <> LineEnd
       THEN
         AddQ(Blank)
```

Модуль очереди
```
UNIT Queue;
INTERFACE
PROCEDURE EmptyQ;
PROCEDURE AddQ (VAR Elt : CHAR);
PROCEDURE DelQ;
PROCEDURE HeadQ(VAR Elt: CHAR);
PROCEDURE WriteQ;


IMPLEMENTATION
VAR
  Q, TEMP: TEXT;


PROCEDURE CopyOpen (VAR F1, F2 :TEXT);
 {Копирует строку из F1 в F2 без RESET или REWRITE;
  таким образом F1 должен быть готов для чтения,а F2 для записи,
  но прошлые строки у этих файлов могут быть не пусты }
VAR
  Ch: CHAR;
BEGIN {CopyOpen}
  WHILE NOT EOLN (F1)
  DO
    BEGIN
      READ(F1,Ch);
      WRITE(F2,Ch)
    END
END;{CopyOpen}


PROCEDURE EmptyQ;
{Q := <,/,R>}
BEGIN {EmptyQ}
  REWRITE(Q);
  WRITELN(Q);
  RESET(Q)
END{EmptyQ};


PROCEDURE AddQ (VAR Elt : CHAR);
  {Q = <,x/,R>,где x строка И Elt = a -->
   Q = <,xa/,R> }
BEGIN {AddQ}
  .....
END {AddQ};


PROCEDURE DelQ;
  {(Q = <,/,R> -->)|
   (Q = <,ax/,R>,где a символ и x строка  -->
     Q:= <,x/,R> }
VAR
  Ch: CHAR;
BEGIN {DelQ}
  {удаляем первый элемент из Q};


  READ(Q,Ch);
  IF NOT EOF (Q)
  THEN {не пустой}
    BEGIN
      REWRITE(Temp);
      CopyOpen(Q,Temp);
      WRITELN(Temp);
      {копируем Temp в Q}
      RESET(Temp);
      REWRITE(Q);
      CopyOpen(Temp,Q);
      WRITELN(Q);
    END;
  RESET(Q)
END {DelQ};


PROCEDURE HeadQ(VAR Elt: CHAR);
  {(Q = <,/,R> --> Elt := '#')|
   (Q = <,ax/,R>,где a символ и x строка  -->
     Elt:= 'a' }
BEGIN  {HeadQ}
  IF NOT EOLN(Q)
  THEN
    READ(Q,Elt)
  ELSE
    Elt := '#';
  RESET(Q)
END{HeadQ};


PROCEDURE WriteQ;
  { (Q = <,x/,R> и OUTPUT =<y,,W>,где y и x строка  -->
     OUTPUT := <y&x/,,W> }
BEGIN {WriteQ}
  CopyOpen(Q,OUTPUT);
  WRITELN(OUTPUT);
  RESET(Q)
END{WriteQ};


BEGIN
END.
```
