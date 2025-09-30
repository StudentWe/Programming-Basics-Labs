PROGRAM XPrint(INPUT, OUTPUT);
CONST
  MatrixSize = 5;
  SymbolM = [1, 5, 6, 7, 9, 10, 11, 13, 15, 16, 20, 21, 25];
  SymbolO = [2, 3, 4, 6, 10, 11, 15, 16, 20, 22, 23, 24];
  SymbolX = [1, 5, 7, 9, 13, 17, 19, 21, 25];
TYPE
  Matrix = SET OF 0..(MatrixSize * MatrixSize);

PROCEDURE PrintSymbol(VAR FOut: TEXT; Symbol: Matrix);
VAR
  CurrentCell: INTEGER;
BEGIN
  FOR CurrentCell:= 1 TO (MatrixSize * MatrixSize)
  DO
    BEGIN
      IF (CurrentCell IN Symbol)
      THEN
        WRITE(FOut, 'X')
      ELSE 
        WRITE(FOut, ' ');
      IF (CurrentCell MOD MatrixSize = 0)
      THEN
        WRITELN(FOut)
    END
END;

FUNCTION ConvertToMatrix(Ch: CHAR): Matrix;
BEGIN
  IF Ch IN ['M', 'O', 'X']
  THEN
    CASE Ch OF
      'M': ConvertToMatrix := SymbolM;
      'O': ConvertToMatrix := SymbolO;
      'X': ConvertToMatrix := SymbolX
    END
  ELSE
    ConvertToMatrix := []
END;

PROCEDURE PrintSymbolLine(VAR FIn: TEXT; VAR FOut: TEXT);
VAR
  Ch: CHAR;
  Symbol: Matrix;
BEGIN
  WHILE NOT EOLN(FIn)
  DO
    BEGIN
      READ(Fin, Ch);
      Symbol := ConvertToMatrix(Ch);
      IF Symbol <> []
      THEN
        PrintSymbol(FOut, Symbol)
      ELSE
        WRITELN(FOut, 'Такой символ не поддерживается');
      WRITELN(FOut)
    END
END;

BEGIN
  PrintSymbolLine(INPUT, OUTPUT)
END.

