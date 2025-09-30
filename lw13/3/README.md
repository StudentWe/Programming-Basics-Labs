## 13.3 [#20]
Произведите сборку программы Split из разделов проекта, приведенных ниже. Допишите недостающие разделы DP1.1. и DP1.2.1. Проверьте выполнение.

### Итоговое выполнение:
```
INPUT:
123456
789

OUTPUT:
135792468
```
### Разделы
```
DP1
PROGRAM Split(INPUT,OUTPUT);
  {Копирует INPUT в OUTPUT,сначала нечетные,а затем четные
   элементы}
VAR
  Ch,Next: CHAR;
  Odds,Evens: TEXT;
{PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);}


BEGIN
  {Разделяет INPUT в Odds и Evens}
  CopyOut(Odds,Ch);
  CopyOut(Evens,Ch);
  WRITELN
END.
```
```
DP1.1
PROCEDURE CopyOut(VAR F1: TEXT; VAR Ch: CHAR);
BEGIN
  {Копируем F1 в OUTPUT}
END;
```
```
DP1.2
{Разделяет INPUT в Odds и Evens}
  BEGIN
    REWRITE(Odds);
    REWRITE(Evens);
    Next := 'O';
    WHILE NOT EOF
    DO
      BEGIN
        WHILE NOT EOLN
        DO
          {Прочитать Ch, записать в файл, выбранный через
           Next,переключить Next}
        READLN;
        WRITELN(Odds);
        WRITELN(Evens)
      END;
    WRITELN(Odds);
    WRITELN(Evens)
  END;
```

```
DP1.2.1
{Прочитать Ch, записать в файл, выбранный через Next,  переключить Next}
```
