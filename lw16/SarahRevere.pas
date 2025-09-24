PROGRAM SarahRevere(INPUT, OUTPUT);
VAR
  W1, W2, W3, W4: CHAR;
  Looking, Land, Sea: BOOLEAN;

BEGIN 
  Looking := TRUE;
  Land := FALSE;
  Sea := FALSE;
  W1 := ' ';
  W2 := ' ';
  W3 := ' ';
  W4 := ' ';
         
  WHILE Looking AND NOT (Land OR Sea) AND NOT EOLN(INPUT)
  DO
    BEGIN
      W1 := W2;
      W2 := W3;
      W3 := W4;
      READ(W4);
      
      Land := (W1 = 'l') AND (W2 = 'a') AND (W3 = 'n') AND (W4 = 'd');
      
      Sea := (W1 = 's') AND (W2 = 'e') AND (W3 = 'a') AND (W4 = ' ');
      
      IF Land OR Sea 
      THEN
        Looking := FALSE
    END;       
    
  
  IF Land 
  THEN
    WRITELN(OUTPUT, 'The British are coming by land.')
  ELSE 
    IF Sea 
    THEN
        WRITELN(OUTPUT, 'The British are coming by sea.')
    ELSE
        WRITELN(OUTPUT, 'Sarah didn''t say anything.')
END.
