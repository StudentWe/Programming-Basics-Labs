PROGRAM XPrint(INPUT, OUTPUT);
CONST
  MatrixSize = 5;
  StringLength = 10;
  StringSize = 250;
TYPE
  Matrix = SET OF 0..(MatrixSize * MatrixSize);
  MatrixString = SET OF 0..StringSize;

FUNCTION FindSymbol(VAR FIn: TEXT; Ch: CHAR) : Matrix;
VAR 
  Temp: CHAR;
  Num: INTEGER;
  SymbolSet: Matrix;
BEGIN
  RESET(FIn);
  SymbolSet := [];
  WHILE NOT EOF(FIn)
  DO
    BEGIN
      READ(FIn, Temp);
      IF Temp = Ch
      THEN
        WHILE NOT EOLN(FIn)
        DO
          BEGIN
            READ(FIn, Num);
            SymbolSet := SymbolSet + [Num]
          END
      ELSE
        READLN(FIn)
    END;  
  FindSymbol := SymbolSet                
END;


FUNCTION UpscaleSymbol(Symbol: Matrix; CurrentSymbol: INTEGER) : MatrixString;
VAR
  CurrentCell: INTEGER;
  Temp: INTEGER;
  NewSymbol: MatrixString;
BEGIN
  NewSymbol := [];
  FOR CurrentCell := 1 TO (MatrixSize * MatrixSize)
  DO
    BEGIN
      IF (CurrentCell IN Symbol)
      THEN
        BEGIN
          IF CurrentCell MOD MatrixSize = 0
          THEN
            Temp := ((MatrixSize * StringLength) * ((CurrentCell DIV MatrixSize) - 1)) + MatrixSize
          ELSE
            Temp := (((MatrixSize * StringLength) * (CurrentCell DIV MatrixSize)) + (CurrentCell MOD MatrixSize));
          NewSymbol := NewSymbol + [Temp + ((CurrentSymbol - 1) * MatrixSize)] 
        END 
    END;
  UpscaleSymbol := NewSymbol           
END;
  

FUNCTION ReadString(VAR FIn: TEXT) : MatrixString;
VAR
  CurrentSymbol: INTEGER;
  Ch: CHAR;
  Str: MatrixString;
  Symbol: MatrixString;
  Config: TEXT;
BEGIN
  ASSIGN(Config, 'Config.txt');
  Str := [];
  CurrentSymbol := 0;
  WHILE ((CurrentSymbol < StringLength) AND (NOT EOLN(FIn)))
  DO
    BEGIN
      CurrentSymbol := CurrentSymbol + 1;
      READ(FIn, Ch);
      Symbol := FindSymbol(Config, Ch);
      IF Symbol <> []
      THEN
        BEGIN
          UpscaleSymbol(Symbol, CurrentSymbol); 
          Str := Str + UpscaleSymbol(Symbol, CurrentSymbol)
        END
    END;
  ReadString := Str
END;


PROCEDURE PrintString(VAR FOut: TEXT; Str: MatrixString);
VAR
  CurrentCell: INTEGER;
BEGIN
  FOR CurrentCell:= 1 TO StringSize
  DO
    BEGIN
      IF(CurrentCell IN Str)
      THEN
        WRITE(FOut, 'X')
      ELSE 
        WRITE(FOut, ' ');
      IF (CurrentCell MOD MatrixSize = 0)
      THEN
        WRITE(FOut, ' ');    
      IF (CurrentCell MOD (MatrixSize * StringLength) = 0)
      THEN
        WRITELN(FOut) 
    END
END;


BEGIN
   PrintString(OUTPUT, ReadString(INPUT))
END.

