PROGRAM CountChars(INPUT, OUTPUT);
{������������ ���������� �������� �� ������� �����}
USES Count3;

VAR
  Ch: CHAR;
  H, T, O: CHAR;

BEGIN
  Start; {�������������� �������}
  
  WHILE NOT EOLN(INPUT)
  DO
    BEGIN
      READ(INPUT, Ch);
      Bump {����������� ������� �� 1 ��� ������� �������}
    END;
  
  {������� ���������}
  Value(H, T, O);
  WRITE('���������� ��������: ');
  WRITE(H);
  WRITE(T);
  WRITELN(O)
END.
