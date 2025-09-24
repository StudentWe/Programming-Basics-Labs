PROGRAM CountWords;

USES
  FileUtils, TreeUtils;

CONST
  InputFileName = 'Input.txt';
  OutputFileName = 'Output.txt';

VAR
  InputFile, OutputFile: TEXT;
  Root: TreeNodePointer = NIL;

BEGIN
  WRITELN('���� ', InputFileName, ' ������ �� ������');
  ASSIGN(InputFile, InputFileName);
  ASSIGN(OutputFile, OutputFileName);

  ProcessFile(InputFile, OutputFile, Root);
  
  CLOSE(InputFile);
  WRITELN('���� ', InputFileName, ' ������');

  IF Root <> NIL 
  THEN
    SaveTreeToFile(Root, OutputFile);

  CLOSE(OutputFile);
  FreeTree(Root);
  WRITELN('���������� ��������� � ', OutputFileName)
END.
