PROGRAM CountReverses(INPUT, OUTPUT);
{������������ ���������� �������� �� ������� ������}
USES Count3;

VAR
  Ch1, Ch2, Ch3: CHAR;
  H, T, O: CHAR;

BEGIN
  Start; {�������������� �������}
  WRITE(OUTPUT, '����:');

  {������ ������ ��� �������}
  IF NOT EOLN(INPUT)
  THEN
    BEGIN
      READ(INPUT, Ch1);
      IF NOT EOLN(INPUT)
      THEN
        BEGIN
          READ(INPUT, Ch2);
          IF NOT EOLN(INPUT)
          THEN
            BEGIN
              READ(INPUT, Ch3);
              {��������� ������ ��������� ������}
              IF ((Ch2 > Ch1) AND (Ch2 > Ch3)) OR ((Ch2 < Ch1) AND (Ch2 < Ch3))
              THEN
                Bump;
              
              {���������� �������� ��� ��������� ��������}
              Ch1 := Ch2;
              Ch2 := Ch3;
              WHILE NOT EOLN(INPUT)
              DO
                BEGIN
                  READ(INPUT, Ch3);
                  IF ((Ch2 > Ch1) AND (Ch2 > Ch3)) OR ((Ch2 < Ch1) AND (Ch2 < Ch3))
                  THEN
                    Bump;
                  Ch1 := Ch2;
                  Ch2 := Ch3
                END
            END
        END
    END;
  
  {������� ���������}
  Value(H, T, O);
  WRITE(OUTPUT, '���������� ��������:');
  WRITE(OUTPUT, H);
  WRITE(OUTPUT, T);
  WRITELN(OUTPUT, O)
END.
