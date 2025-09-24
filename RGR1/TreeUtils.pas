UNIT TreeUtils;

INTERFACE

USES
  Word;

TYPE
  TreeNodePointer = ^TreeNode;
  TreeNode = RECORD
               Word: WordType;
               Count: INTEGER;
               Left, Right: TreeNodePointer
             END;

PROCEDURE InsertWordInTree(VAR Node: TreeNodePointer; CONST W: WordType);
PROCEDURE TraverseAndSave(Node: TreeNodePointer; VAR F: TEXT);
PROCEDURE FreeTree(Node: TreeNodePointer);

IMPLEMENTATION

PROCEDURE InsertWordInTree(VAR Node: TreeNodePointer; CONST W: WordType);
BEGIN
  IF Node = NIL
  THEN
    BEGIN
      NEW(Node);
      Node^.Word := W;
      Node^.Count := 1;
      Node^.Left := NIL;
      Node^.Right := NIL
    END
  ELSE 
    IF W < Node^.Word
    THEN
      InsertWordInTree(Node^.Left, W)
  ELSE 
    IF W > Node^.Word
    THEN
      InsertWordInTree(Node^.Right, W)
  ELSE
    Node^.Count := Node^.Count + 1
END;

PROCEDURE TraverseAndSave(Node: TreeNodePointer; VAR F: TEXT);
BEGIN
  IF Node <> NIL
  THEN
    BEGIN
      TraverseAndSave(Node^.Left, F);
      WriteWord(F, Node^.Word);
      WRITELN(F, ' ', Node^.Count);
      TraverseAndSave(Node^.Right, F)
    END
END;

PROCEDURE FreeTree(Node: TreeNodePointer);
BEGIN
  IF Node <> NIL
  THEN
    BEGIN
      FreeTree(Node^.Left);
      FreeTree(Node^.Right);
      DISPOSE(Node)
    END
END;

END.
