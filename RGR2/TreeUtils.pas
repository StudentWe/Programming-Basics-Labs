UNIT TreeUtils;

INTERFACE

USES
  WordType;

TYPE
  TreeNodePointer = ^TreeNode;
  TreeNode = RECORD
    Word: WordType.Word;
    Count: INTEGER;
    Left, Right: TreeNodePointer
  END;

PROCEDURE InsertWord(VAR Node: TreeNodePointer; CONST Word: WordType.Word);
FUNCTION FindWord(Node: TreeNodePointer; CONST W: WordType.Word; VAR Count: INTEGER): BOOLEAN;
FUNCTION FindWordNode(Node: TreeNodePointer; VAR FoundNode: TreeNodePointer; CONST W: WordType.Word): BOOLEAN;
FUNCTION GetFirstWord(Node: TreeNodePointer; VAR W: Word; VAR Count: INTEGER): BOOLEAN;
FUNCTION GetFirstWordNode(Node: TreeNodePointer; VAR FoundNode: TreeNodePointer): BOOLEAN;
PROCEDURE RemoveWordNode(VAR Root, Node: TreeNodePointer);
PROCEDURE SaveTreeToFile(Node: TreeNodePointer; VAR F: TEXT);
PROCEDURE FreeTree(VAR Node: TreeNodePointer);

IMPLEMENTATION

PROCEDURE InsertWord(VAR Node: TreeNodePointer; CONST Word: WordType.Word);
BEGIN
  IF Node = NIL
  THEN
    BEGIN
      NEW(Node);
      Node^.Word := Word;
      Node^.Count := 1;
      Node^.Left := NIL;
      Node^.Right := NIL
    END
  ELSE 
    IF Word < Node^.Word
    THEN
      InsertWord(Node^.Left, Word)
    ELSE 
      IF Word > Node^.Word
      THEN
        InsertWord(Node^.Right, Word)
      ELSE
        Node^.Count := Node^.Count + 1
END;

FUNCTION FindWord(Node: TreeNodePointer; CONST W: WordType.Word; VAR Count: INTEGER): BOOLEAN;
VAR
  FoundNode: TreeNodePointer;
BEGIN
  IF FindWordNode(Node, FoundNode, W)
  THEN
    BEGIN
      FindWord := TRUE;
      Count := FoundNode^.Count
    END
  ELSE
    FindWord := FALSE
END;

FUNCTION FindWordNode(Node: TreeNodePointer; VAR FoundNode: TreeNodePointer; CONST W: WordType.Word): BOOLEAN;
BEGIN
  IF Node = NIL
  THEN
    BEGIN
      FindWordNode := FALSE;
      FoundNode := NIL
    END
  ELSE 
    IF W < Node^.Word 
    THEN
      FindWordNode := FindWordNode(Node^.Left, FoundNode, W)
    ELSE 
      IF W > Node^.Word 
      THEN
        FindWordNode := FindWordNode(Node^.Right, FoundNode, W)
      ELSE 
        BEGIN
          FoundNode := Node;
          FindWordNode := TRUE
        END
END;

PROCEDURE SaveTreeToFile(Node: TreeNodePointer; VAR F: TEXT);
BEGIN
  IF Node <> NIL
  THEN
    BEGIN
      SaveTreeToFile(Node^.Left, F);
      WriteWord(F, Node^.Word);
      WRITELN(F, ' ', Node^.Count);
      SaveTreeToFile(Node^.Right, F)
    END
END;

PROCEDURE FreeTree(VAR Node: TreeNodePointer);
BEGIN
  IF Node <> NIL
  THEN
    BEGIN
      FreeTree(Node^.Left);
      FreeTree(Node^.Right);
      DISPOSE(Node)
    END
END;

PROCEDURE RemoveWordNode(VAR Root, Node: TreeNodePointer);
VAR
  Parent, Current, TempNode: TreeNodePointer;
  IsLeftChild: BOOLEAN;
BEGIN
  Parent := NIL;
  Current := Root;
  IsLeftChild := FALSE;
  
  WHILE (Current <> NIL) AND (Current <> Node)
  DO
  BEGIN
    Parent := Current;
    IF Node^.Word < Current^.Word 
    THEN
      BEGIN
        Current := Current^.Left;
        IsLeftChild := TRUE
      END
    ELSE
      BEGIN
        Current := Current^.Right;
        IsLeftChild := FALSE
      END
  END;

  IF Current <> NIL
  THEN
    IF Node^.Left = NIL 
    THEN
      BEGIN
        IF Parent = NIL 
        THEN
          Root := Node^.Right
        ELSE 
          IF IsLeftChild 
          THEN
            Parent^.Left := Node^.Right
          ELSE
            Parent^.Right := Node^.Right;
        
        DISPOSE(Node)
      END
    ELSE
      IF Node^.Right = NIL 
      THEN
        BEGIN
          IF Parent = NIL 
          THEN
            Root := Node^.Left
          ELSE 
            IF IsLeftChild 
            THEN
              Parent^.Left := Node^.Left
            ELSE
              Parent^.Right := Node^.Left;
          
          DISPOSE(Node)
        END
      ELSE
        BEGIN
          //TempNode := Node^.Right;
          //Parent := TempNode;
          //WHILE TempNode^.Left <> NIL 
          //DO
          //  BEGIN
          //    Parent := TempNode;
          //    TempNode := TempNode^.Left;
          //  END;
          //
          //Node^.Word := TempNode^.Word;
          //Node^.Count := TempNode^.Count;
          //
          //IF TempNode^.Right <> NIL
          //THEN
          //  BEGIN
          //    // Добавить в самое левое
          //  END;
//
          //IF Parent <> TempNode
          //THEN
          //  Parent^.Left := NIL;
          //DISPOSE(TempNode);
          //TempNode := Node^.Right;
          //Node^.Right := Node^.Left;
          //Node^.Left := NIL;
//
          //Parent := Node^.Right;
          //WHILE TempNode <> Parent^.Right
          //DO
          //  BEGIN
          //    IF Parent^.Right <> NIL
          //    THEN
          //      Parent := Parent^.Right
          //    ELSE
          //      BEGIN
          //        Parent^.Right := TempNode
          //      END
          //  END


          // Old
          TempNode := Node^.Right;
          Parent := Node;
          WHILE TempNode^.Left <> NIL DO
          BEGIN
            Parent := TempNode;
            TempNode := TempNode^.Left;
          END;

          Node^.Word := TempNode^.Word;
          Node^.Count := TempNode^.Count;

          IF Parent = Node 
          THEN
            Parent^.Right := TempNode^.Right
          ELSE
            Parent^.Left := TempNode^.Right;
          
          DISPOSE(TempNode);

          //RemoveWordNode(Root, TempNode)
        END
END;

FUNCTION GetFirstWord(Node: TreeNodePointer; VAR W: Word; VAR Count: INTEGER): BOOLEAN;
BEGIN
  IF Node = NIL 
  THEN
    GetFirstWord := FALSE
  ELSE 
    IF Node^.Left = NIL 
    THEN
      BEGIN
        W := Node^.Word;
        Count := Node^.Count;
        GetFirstWord := TRUE
      END
    ELSE
      GetFirstWord := GetFirstWord(Node^.Left, W, Count)
END;

FUNCTION GetFirstWordNode(Node: TreeNodePointer; VAR FoundNode: TreeNodePointer): BOOLEAN;
BEGIN
  IF Node = NIL 
  THEN
    BEGIN
      GetFirstWordNode := FALSE;
      FoundNode := NIL
    END
  ELSE 
    IF Node^.Left = NIL 
    THEN
      BEGIN
        FoundNode := Node;
        GetFirstWordNode := TRUE
      END
    ELSE
      GetFirstWordNode := GetFirstWordNode(Node^.Left, FoundNode)
END;

END.
