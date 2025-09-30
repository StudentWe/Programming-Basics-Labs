## 16.1 [#20]
Из приведенных ниже разделов проекта соберите модуль DateIO, который содержит описания типа Month и процедуры ввода вывода для этого типа. Разработайте программу SortMonth, используя модуль DateIO, которая сравнивает введенные значения месяцев.
 
Пример: 
```
INPUT:  APRJUL OUTPUT: Apr предшествует Jul 
```
```
INPUT:  AprJul OUTPUT: Входные данные записаны неверно 
```
```
INPUT:  JULAPR OUTPUT: Jul следует за Apr 
```
```
INPUT:  DECDEC OUTPUT: Оба месяца DEC 
```

## 16.2 [#20]
Соберите программу SarahRevere c использованием процедур и переменных типа BOOLEAN из приведенных ниже разделов проекта.


### Разделы проекта для модуля DateIO


```
TYPE
  Month = (NoMonth, JAN, FEB, MAR, APR, MAY, JUN,
                    JUL, AUG, SEP, OCT, NOV, DEC);
  
PROCEDURE ReadMonth(VAR FIn: TEXT; VAR Mo: Month);
VAR
  Ch1,Ch2,Ch3 : CHAR;
BEGIN{ReadMonth}
  READ(FIn,Ch1,Ch2,Ch3);{FIn содержит хотя бы 3 символа}
  IF (Ch1='J')AND (Ch2='A')AND (Ch3='N') THEN Mo:=JAN ELSE
  IF (Ch1='F')AND (Ch2='E')AND (Ch3='B') THEN Mo:=FEB ELSE
  IF (Ch1='M')AND (Ch2='A')AND (Ch3='R') THEN Mo:=MAR ELSE
  IF (Ch1='A')AND (Ch2='P')AND (Ch3='R') THEN Mo:=APR ELSE
  IF (Ch1='M')AND (Ch2='A')AND (Ch3='Y') THEN Mo:=MAY ELSE
  IF (Ch1='J')AND (Ch2='U')AND (Ch3='N') THEN Mo:=JUN ELSE
  IF (Ch1='J')AND (Ch2='U')AND (Ch3='L') THEN Mo:=JUL ELSE
  IF (Ch1='A')AND (Ch2='U')AND (Ch3='G') THEN Mo:=AUG ELSE
  IF (Ch1='S')AND (Ch2='E')AND (Ch3='P') THEN Mo:=SEP ELSE
  IF (Ch1='O')AND (Ch2='C')AND (Ch3='T') THEN Mo:=OCT ELSE
  IF (Ch1='N')AND (Ch2='O')AND (Ch3='V') THEN Mo:=NOV ELSE
  IF (Ch1='D')AND (Ch2='E')AND (Ch3='C') THEN Mo:=DEC
     ELSE Mo:= NoMonth
END;{ReadMonth}


PROCEDURE WriteMonth(VAR FOut: TEXT; VAR Mo: Month);
VAR
  Ch1,Ch2,Ch3 : CHAR;
BEGIN {WriteMonth}
  IF Mo=JAN THEN WRITE('JAN') ELSE
  IF Mo=FEB THEN WRITE('FEB') ELSE
  IF Mo=MAR THEN WRITE('MAR') ELSE
  IF Mo=APR THEN WRITE('APR') ELSE
  IF Mo=MAY THEN WRITE('MAY') ELSE
  IF Mo=JUN THEN WRITE('JUN') ELSE
  IF Mo=JUL THEN WRITE('JUL') ELSE
  IF Mo=AUG THEN WRITE('AUG') ELSE
  IF Mo=SEP THEN WRITE('SEP') ELSE
  IF Mo=OCT THEN WRITE('OCT') ELSE
  IF Mo=NOV THEN WRITE('NOV') ELSE
  IF Mo=DEC THEN WRITE('DEC')
     ELSE WRITE( 'NoMonth')
END;{WriteMonth}
```



### Разделы проекта для SarahRevere с переменными типа BOOLEAN 
``` 
PROGRAM SarahRevere(INPUT, OUTPUT); 
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN; 
 
BEGIN {SarahRevere}   
  {Инициализация}
  WHILE Looking AND NOT (Land OR Sea)   
  DO
    BEGIN
      {движение окна}
      {проверка окна на land}
      {проверка окна на sea}
    END;
  {создание сообщения Sarah}
END.  {SarahRevere} 
 
 
{проверка окна на land}        
Land := (W1 = ‘l’) AND (W2 = ‘a’) AND (W3 = ‘n’) AND (W4 = ‘d’) 
 
{проверка окна на sea}
Sea := (W1 = ‘s’) AND (W2 = ‘e’) AND (W3 = ‘a’)
```
