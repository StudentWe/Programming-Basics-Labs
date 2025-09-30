## 13.1 
Создайте процедуры с параметрами для программы RunBubbleSort из приведенных ниже разделов проекта. На каждом этапе разработки программы соберите одну процедуру и проверьте ее работу. На каждом этапе разработки должна быть рабочая версия BubbleSort. Сформируйте набор тестовых данных, одинаковый для всех этапов.

a) [#10]
```PROCEDURE CopyFile(VAR InFile, OutFile: TEXT)```
Открывайте и закрывайте файлы за пределами процедуры.

b) [#10]
```
PROCEDURE CopyAndSwap(VAR F1, F2: TEXT; VAR Sorted: CHAR)
{ Копируем F1 в F2,проверяя отсортированность
  и переставляя первые соседние символы по порядку}
```

c) [#10]
```PROCEDURE BubbleSort(VAR InFile, OutFile: TEXT)```

### Итоговое выполнение:
```
INPUT: 34251
OUTPUT: 12345
```
```
INPUT: 11523
OUTPUT: 11235
```
### Разделы проекта для BubbleSort
```
DP2
PROGRAM BubbleSort(INPUT, OUTPUT);
  { Сортируем первую строку INPUT в OUTPUT }
VAR
  Sorted, Ch, Ch1, Ch2:CHAR;
  F1, F2:TEXT;
BEGIN { BubbleSort }
  { Копируем INPUT в F1 }
  Sorted :='N';
  WHILE Sorted ='N'
  DO
    BEGIN
      { Копируем F1 в F2,проверяя отсортированность
       и переставляя первые соседние символы по порядку}
      { Копируем F2 в F1 }
    END;
  { Копируем F1 в OUTPUT }
END.{ BubbleSort }
```
```
DP2.1
                 {Выводим min(Ch1,Ch2) в F2, записывая
                  отсортированные символы}
                  IF Ch1 <= Ch2
                  THEN
                    BEGIN
                      WRITE(F2, Ch1);
                      Ch1:=Ch2
                    END
                  ELSE
                    BEGIN
                      WRITE(F2, Ch2);
                      Sorted := 'N'
                    END
```
```
DP2.2
  BEGIN { Копируем INPUT в F1 }
    REWRITE(F1);
    WHILE NOT EOLN
    DO
      BEGIN
        READ(Ch);
        WRITE(F1, Ch);
      END;
    WRITELN(F1)
  END;
```
```
DP2.3
  BEGIN { Копируем F1 в OUTPUT }
       .................
        (аналогично DP2.2)
  END
```
```
DP2.4
      BEGIN { Копируем F2 в F1 }
        .................
         (аналогично DP2.2)
      END
```
