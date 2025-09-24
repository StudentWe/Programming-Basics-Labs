PROGRAM CountWords;

USES
  FileUtils, TreeUtils, Word;

CONST
  InputFileName = 'Input.txt';
  OutputFileName = 'Output.txt';
  AlphabetFileName = 'Alphabet.txt';

VAR
  InputFile, OutputFile, AlphabetFile: TEXT;
  W: WordType;

BEGIN
  WRITELN('���� ', InputFileName, ' ������ �� ������');
  ASSIGN(InputFile, InputFileName);
  ASSIGN(OutputFile, OutputFileName);
  ASSIGN(AlphabetFile, AlphabetFileName);

  SetAlphabet(AlphabetFile);
  RESET(InputFile);
  WHILE ReadWord(InputFile, W)
  DO
    InsertWord(W);

  SaveToFile(OutputFile);

  CLOSE(InputFile);
  CLOSE(OutputFile);
  CLOSE(AlphabetFile);
  WRITELN('���� ', InputFileName, ' ������');
  WRITELN('���������� ��������� � ', OutputFileName)
END.
