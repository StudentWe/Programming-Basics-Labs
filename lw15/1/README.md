## 15.1 
### a) [#15] (task_1)
Соберите модуль Count3. Откорректируйте модуль так, чтобы в нужных местах стояли абстрактные или конкретные комментарии к процедурам. Напишите программу, которая считает количество символов в INPUT. Составьте план тестирования модуля Count3 с помощью программы подсчёта символов.

#### Итоговое выполнение
```
INPUT:123321321
OUTPUT:Количество символов: 009
```

### b) [#15] (task_2)
Напишите программу с использованием модуля Count3 для подсчета реверсов в строке символов. Реверсом являются три последовательных символа, такие, что средний символ больше или меньше крайних.

#### Итоговое выполнение:
```
INPUT:1213453
OUTPUT:
Вход:1213453
Количество реверсов:003
```

Текст модуля Count3
```
UNIT Count3;
INTERFACE


VAR
  Ones, Tens, Hundreds: CHAR;


PROCEDURE Start;
PROCEDURE Bump;
PROCEDURE Value (VAR V100, V10, V1: CHAR);


IMPLEMENTATION


  PROCEDURE Start;
    {Сбрасывает счетчик в 0}
    BEGIN{Start}
      Ones      := '0';
      Tens      := '0';
      Hundreds  := '0'
    END;{Start}


  PROCEDURE Bump;
    {Увеличивает 3-цифровой счетчик определенный   Ones, Tens, Hundreds
     на единицу, если он находится в диапaзоне от 0 до 999 }
    PROCEDURE NextDigit(VAR Digit: CHAR);
      BEGIN {NextDigit}
        IF Digit = '0' THEN Digit :='1' ELSE
        IF Digit = '1' THEN Digit :='2' ELSE
        IF Digit = '2' THEN Digit :='3' ELSE
        IF Digit = '3' THEN Digit :='4' ELSE
        IF Digit = '4' THEN Digit :='5' ELSE
        IF Digit = '5' THEN Digit :='6' ELSE
        IF Digit = '6' THEN Digit :='7' ELSE
        IF Digit = '7' THEN Digit :='8' ELSE
        IF Digit = '8' THEN Digit :='9' ELSE
        IF Digit = '9' THEN Digit :='0'
      END;{NextDigit}
    BEGIN {Bump}
      NextDigit( Ones );
      IF  Ones = '0'
      THEN
        BEGIN
          NextDigit(Tens);
          IF Tens= '0'
          THEN
            BEGIN
              NextDigit(Hundreds);
              IF Hundreds= '0'
              THEN
                BEGIN
                  Ones      := '9';
                  Tens      := '9';
                  Hundreds  := '9'
                END
            END
        END
    END; {Bump}
    PROCEDURE Value (VAR V100, V10, V1: CHAR);
      {Возвращает содержимое счетчика}
      BEGIN {Value}
         V100  := Hundreds;
         V10   := Tens;
         V1    := Ones
      END {Value};
BEGIN
END. {UNIT Count3}
```
