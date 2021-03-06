{
MySimpleToDo - A simple ToDo Manager for you, based of ToDo.TXT
Copyright (C) 2014 Matteo Salvi

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
}

unit main;

{$mode delphi}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  StdCtrls, EditBtn, ExtCtrls, Buttons, VirtualTrees, TodoTXTManager,
  {$IFDEF WINDOWS}ActiveX{$ELSE}FakeActiveX{$ENDIF}, filechannel, sharedloggerlcl,
  UniqueInstance, SearchEdit, Clipbrd, ColorUtils, TrayMenu, LCLType, ActnList,
  StdActns, Settings, extypes;

type

  TSortType = (stDeadLineDate, stPriority, stText);

  { TfrmMain }

  TfrmMain = class(TForm)
    actAddTodo: TAction;
    actCopy: TAction;
    actDelete: TAction;
    actSort: TAction;
    actProperties: TAction;
    actArchive: TAction;
    actDeadLine: TAction;
    actPriority: TAction;
    actText: TAction;
    actUndo: TAction;
    actCut: TAction;
    Action8: TAction;
    actPaste: TAction;
    ActionList1: TActionList;
    ilSmallIcons: TImageList;
    MainMenu1: TMainMenu;
    mniUndo: TMenuItem;
    mniUndo2: TMenuItem;
    mniArchiveToDos2: TMenuItem;
    mniCopy2: TMenuItem;
    mniCut2: TMenuItem;
    mniDeadline2: TMenuItem;
    mniDelete2: TMenuItem;
    mniPaste2: TMenuItem;
    mniPriority2: TMenuItem;
    mniSep6: TMenuItem;
    mniSep9: TMenuItem;
    mniSort2: TMenuItem;
    mniText: TMenuItem;
    mniArchiveToDos: TMenuItem;
    mniDeadline: TMenuItem;
    mniPriority: TMenuItem;
    mniEdit: TMenuItem;
    mniSort: TMenuItem;
    mniNew: TMenuItem;
    mniAbout: TMenuItem;
    mniExit: TMenuItem;
    mniSep5: TMenuItem;
    mniOptions: TMenuItem;
    mniSep4: TMenuItem;
    mniExport: TMenuItem;
    mniImport: TMenuItem;
    mniSep3: TMenuItem;
    mniSep0: TMenuItem;
    mniLoad: TMenuItem;
    mniHelp: TMenuItem;
    mniFile: TMenuItem;
    mniPaste: TMenuItem;
    mniCopy: TMenuItem;
    mniCut: TMenuItem;
    mniSep1: TMenuItem;
    mniSep2: TMenuItem;
    mniDelete: TMenuItem;
    mniProperties: TMenuItem;
    mniProperties2: TMenuItem;
    mniSeparator1: TMenuItem;
    mniAddItem: TMenuItem;
    mniAddItem2: TMenuItem;
    mniText2: TMenuItem;
    OpenDialog1: TOpenDialog;
    pnlTop: TPanel;
    pmList: TPopupMenu;
    edtSearch: TSearchEdit;
    SaveDialog1: TSaveDialog;
    TrayIcon1: TTrayIcon;
    UniqueInstance1: TUniqueInstance;
    vstList: TVirtualStringTree;
    procedure actAddTodoExecute(Sender: TObject);
    procedure actArchiveExecute(Sender: TObject);
    procedure actArchiveUpdate(Sender: TObject);
    procedure actCopyExecute(Sender: TObject);
    procedure actCopyUpdate(Sender: TObject);
    procedure actCutExecute(Sender: TObject);
    procedure actCutUpdate(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actDeleteUpdate(Sender: TObject);
    procedure actPasteExecute(Sender: TObject);
    procedure actPasteUpdate(Sender: TObject);
    procedure actPropertiesExecute(Sender: TObject);
    procedure actPropertiesUpdate(Sender: TObject);
    procedure actSortUpdate(Sender: TObject);
    procedure actSortXyzExecute(Sender: TObject);
    procedure actUndoExecute(Sender: TObject);
    procedure actUndoUpdate(Sender: TObject);
    procedure edtSearchChange(Sender: TObject);
    procedure edtSearchKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormWindowStateChange(Sender: TObject);
    procedure mniAboutClick(Sender: TObject);
    procedure mniExitClick(Sender: TObject);
    procedure mniExportClick(Sender: TObject);
    procedure mniImportClick(Sender: TObject);
    procedure mniLoadClick(Sender: TObject);
    procedure mniNewClick(Sender: TObject);
    procedure TrayIcon1DblClick(Sender: TObject);
    procedure UniqueInstance1OtherInstance(Sender: TObject;
      ParamCount: Integer; Parameters: array of String);
    procedure vstListBeforeCellPaint(Sender: TBaseVirtualTree;
      TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
    procedure vstListChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstListCompareNodes(Sender: TBaseVirtualTree; Node1,
      Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
    procedure vstListDblClick(Sender: TObject);
    procedure vstListDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      const Pt: TPoint; var Effect: LongWord; Mode: TDropMode);
    procedure vstListDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; const Pt: TPoint; Mode: TDropMode;
      var Effect: LongWord; var Accept: Boolean);
    procedure vstListFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstListGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
    procedure vstListInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstListNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; const NewText: String);
    procedure vstListPaintText(Sender: TBaseVirtualTree;
      const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
      TextType: TVSTTextType);
  private
    { private declarations }
    FToDoManager: TToDoTXTManager;
    FSettings: TSettings;
    FTrayMenu: TTrayMenu;
    FShutDownTime: Boolean;
    FSortType: TSortType;
    FUndoList: TStringStack;
    procedure CopyToClipboard;
    procedure DeleteCheckedNodes(ATree: TBaseVirtualTree);
    procedure DeleteSelectedNodes(ATree: TBaseVirtualTree);
    function GetCheckedNodes(ATree: TBaseVirtualTree): TNodeArray;
    procedure PasteFromClipboard;
    function ShowProperty(ATree: TBaseVirtualTree; ANode: PVirtualNode): Boolean;
    procedure ShowMainForm(Sender: TObject);
    procedure HideMainForm;
    procedure FindNodeInTree(Sender: TBaseVirtualTree; Node: PVirtualNode;
                             Data: Pointer; var Abort: Boolean);
    procedure MoveItemUp(const ATree: TBaseVirtualTree);
    procedure MoveItemDown(const ATree: TBaseVirtualTree);
    procedure CloseCurrentToDoFile;
  public
    { public declarations }
    procedure ExitApp(Sender: TObject);
    procedure ShowApp(Sender: TObject);
    procedure AddNewToDoItem(ATree: TBaseVirtualTree; AQuickMode: Boolean);

    property Settings: TSettings read FSettings;
  end;

var
  frmMain: TfrmMain;

implementation

uses
  BaseNodeData, PropertyNode, Utility, About;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FUndoList := TStringStack.Create;
  FSortType := stText;
  FShutDownTime := False;
  FTrayMenu := TTrayMenu.Create(vstList, ilSmallIcons);
  TrayIcon1.PopUpMenu := FTrayMenu.PopupMenu;
  //Settings and logger
  FSettings := TSettings.Create;
  FSettings.LoadConfig;
  //TrayIcon1.Hint := ApplicationName + ' ' + VERSION;
  Logger.Channels.Add(TFileChannel.Create(FSettings.LogFilePath));
  //Load todo.txt
  FToDoManager := TToDoTXTManager.Create(vstList);
  FToDoManager.Load(FSettings.LastToDoFileName);
  //When user shutdown operating system, MySimpletodo call ExitApp
  Application.OnEndSession := ExitApp;
  //Set initial dir for open/save dialogs
  OpenDialog1.InitialDir := FSettings.ConfigDirPath;
  SaveDialog1.InitialDir := FSettings.ConfigDirPath;
end;

procedure TfrmMain.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
  FSettings.SaveConfig;
  CloseCurrentToDoFile;
  Log('Closing application', llInfo);
end;

procedure TfrmMain.edtSearchChange(Sender: TObject);
begin
  vstList.BeginUpdate;
  try
    vstList.IterateSubtree(nil, FindNodeInTree, PString(edtSearch.Text));
  finally
    vstList.EndUpdate;
  end;
end;

procedure TfrmMain.actArchiveExecute(Sender: TObject);
var
  sPath: string;
begin
  sPath := ChangeFileExt(FSettings.LastToDoFileName, '.archive.txt');
  FToDoManager.ArchiveToDos(sPath);
  DeleteCheckedNodes(vstList);
end;

procedure TfrmMain.actArchiveUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := Length(GetCheckedNodes(vstList)) > 0;
end;

procedure TfrmMain.actAddTodoExecute(Sender: TObject);
begin
  AddNewToDoItem(vstList, False);
end;

procedure TfrmMain.actCopyExecute(Sender: TObject);
begin
  CopyToClipboard;
end;

procedure TfrmMain.actCopyUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (vstList.SelectedCount > 0);
end;

procedure TfrmMain.actCutExecute(Sender: TObject);
begin
  CopyToClipboard;
  vstList.DeleteSelectedNodes;
end;

procedure TfrmMain.actCutUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (vstList.SelectedCount > 0);
end;

procedure TfrmMain.actDeleteExecute(Sender: TObject);
begin
  DeleteSelectedNodes(vstList);
end;

procedure TfrmMain.actDeleteUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (vstList.SelectedCount > 0);
end;

procedure TfrmMain.actPasteExecute(Sender: TObject);
begin
  PasteFromClipboard;
end;

procedure TfrmMain.actPasteUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (Clipboard.AsText <> '');
end;

procedure TfrmMain.actPropertiesExecute(Sender: TObject);
begin
  ShowProperty(vstList, vstList.FocusedNode);
end;

procedure TfrmMain.actPropertiesUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := (vstList.SelectedCount > 0);
end;

procedure TfrmMain.actSortUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := vstList.HasChildren[vstList.RootNode];
end;

procedure TfrmMain.actSortXyzExecute(Sender: TObject);
begin
  if Sender is TAction then
    FSortType := TSortType(TAction(Sender).Tag);
  vstList.SortTree(0, sdAscending);
end;

procedure TfrmMain.actUndoExecute(Sender: TObject);
var
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    StringList.Text := FUndoList.Pop;
    FToDoManager.StringsToNode(StringList);
    Log('Undo last deleted nodes', llInfo);
  finally
    StringList.Free;
  end;
end;

procedure TfrmMain.actUndoUpdate(Sender: TObject);
begin
  TAction(Sender).Enabled := FUndoList.Count > 0;
end;

procedure TfrmMain.edtSearchKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (edtSearch.Text <> '') and (Shift = [ssCtrl]) and (Ord(Key) = VK_RETURN) then
  begin
    vstList.BeginUpdate;
    try
      AddVSTNode(vstList, nil, edtSearch.Text);
    finally
      vstList.EndUpdate;
    end;
    Log('Added a ToDo item using search box', llInfo);
  end;
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose := FShutDownTime or not(FSettings.TrayIcon);
  //If user close window, hide form and taskbar icon
  if not (CanClose) then
    HideMainForm;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FUndoList.Free;
  FToDoManager.Free;
  FSettings.Free;
  FTrayMenu.Free;
end;

procedure TfrmMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Shift = [ssCtrl]) and (Ord(Key) = VK_UP) then
    MoveItemUp(vstList)
  else if (Shift = [ssCtrl]) and (Ord(Key) = VK_DOWN) then
    MoveItemDown(vstList);
end;

procedure TfrmMain.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if (Shift = [ssCtrl]) and (Ord(Key) = VK_N) then
    AddNewToDoItem(vstList, True)
  else if (Shift = [ssCtrl]) and (Ord(Key) = VK_F) then
    edtSearch.SetFocus;
end;

procedure TfrmMain.FormWindowStateChange(Sender: TObject);
begin
  if (WindowState = wsMinimized) and (FSettings.TrayIcon) then
  begin
    WindowState := wsNormal;
    HideMainForm;
  end;
end;

procedure TfrmMain.mniAboutClick(Sender: TObject);
begin
  ShowAboutDialog;
end;

procedure TfrmMain.mniExitClick(Sender: TObject);
begin
  FShutDownTime := True;
  Close;
end;

procedure TfrmMain.mniExportClick(Sender: TObject);
begin
  SaveDialog1.Title := 'Export ToDos in another *.txt';
  if SaveDialog1.Execute then
    FToDoManager.SaveAs(SaveDialog1.FileName);
end;

procedure TfrmMain.mniImportClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Import ToDos from a *.txt file';
  if OpenDialog1.Execute then
    FToDoManager.Load(OpenDialog1.FileName);
end;

procedure TfrmMain.mniLoadClick(Sender: TObject);
begin
  OpenDialog1.Title := 'Load another *.txt file';
  if OpenDialog1.Execute then
  begin
    CloseCurrentToDoFile;
    FSettings.LastToDoFileName := OpenDialog1.FileName;
    FToDoManager.Load(OpenDialog1.FileName);
  end;
end;

procedure TfrmMain.mniNewClick(Sender: TObject);
begin
  SaveDialog1.Title := 'Create a new *.txt file';
  if SaveDialog1.Execute then
  begin
    CloseCurrentToDoFile;
    FSettings.LastToDoFileName := SaveDialog1.FileName;
    Log('Create new ToDo.txt ' + SaveDialog1.FileName, llInfo);
  end;
end;

procedure TfrmMain.ShowMainForm(Sender: TObject);
begin
  ShowInTaskBar := stAlways;
  Show;
  Application.Restore;
end;

procedure TfrmMain.TrayIcon1DblClick(Sender: TObject);
begin
  ShowApp(Sender);
end;

procedure TfrmMain.UniqueInstance1OtherInstance(Sender: TObject;
  ParamCount: Integer; Parameters: array of String);
begin
  //In case of user execute another instance, restore application and show main form
  ShowMainForm(Sender);
end;

procedure TfrmMain.vstListBeforeCellPaint(Sender: TBaseVirtualTree;
  TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  CellPaintMode: TVTCellPaintMode; CellRect: TRect; var ContentRect: TRect);
var
  NodeData: PTreeNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData.Data) then
    TargetCanvas.GradientFill(CellRect, NodeData.Data.Color,
                              LighterColor(NodeData.Data.Color, 25), gdVertical);
end;

procedure TfrmMain.vstListChecked(Sender: TBaseVirtualTree; Node: PVirtualNode);
var
  NodeData: PTreeNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData.Data) then
    if (NodeData.Data.Checked <> (Sender.CheckState[Node] = csCheckedNormal)) then
    begin
      NodeData.Data.Checked := (Sender.CheckState[Node] = csCheckedNormal);
      Log(Format('Check item %s to %s', [NodeData.Data.Text, BoolToStr(NodeData.Data.Checked)]),
          llInfo);
    end;
end;

procedure TfrmMain.vstListCompareNodes(Sender: TBaseVirtualTree; Node1,
  Node2: PVirtualNode; Column: TColumnIndex; var Result: Integer);
var
  NodeData1, NodeData2: TBaseNodeData;
begin
  NodeData1 := PTreeNodeData(Sender.GetNodeData(Node1)).Data;
  NodeData2 := PTreeNodeData(Sender.GetNodeData(Node2)).Data;
  if (Not Assigned(NodeData1)) or (Not Assigned(NodeData2)) then
    Result := 0
  else begin
    case FSortType of
      stDeadLineDate: Result := CompareDeadLineDate(NodeData1, NodeData2);
      stText:         Result := CompareText(NodeData1, NodeData2);
      stPriority:     Result := ComparePriority(NodeData1, NodeData2);
    end;
  end;
end;

procedure TfrmMain.vstListDblClick(Sender: TObject);
var
  Tree: TVirtualStringTree;
begin
  if Sender is TVirtualStringTree then
  begin
    Tree := TVirtualStringTree(Sender);
    ShowProperty(Tree, Tree.FocusedNode);
  end;
end;

procedure TfrmMain.vstListDragDrop(Sender: TBaseVirtualTree; Source: TObject;
  DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
  const Pt: TPoint; var Effect: LongWord; Mode: TDropMode);
var
  AttachMode: TVTNodeAttachMode;
  Nodes: TNodeArray;
  I: integer;

  procedure DetermineEffect;
  begin
    // In the case the source is a Virtual Treeview we know 'move' is the default if dragging within
    // the same tree and copy if dragging to another tree. Set Effect accordingly.
    if Shift = [] then
    begin
      // No modifier key, so use standard action.
      if Source = Sender then
        Effect := DROPEFFECT_MOVE
      else
        Effect := DROPEFFECT_COPY;
    end
    else
    begin
      // A modifier key is pressed, hence use this to determine action.
      if (Shift = [ssAlt]) or (Shift = [ssCtrl, ssAlt]) then
        Effect := DROPEFFECT_LINK
      else
        if Shift = [ssCtrl] then
          Effect := DROPEFFECT_COPY
        else
          Effect := DROPEFFECT_MOVE;
    end;
  end;

  function CheckTargetNode: boolean;
  var
    J:Integer;
  begin
    //We must check if a selected nodes (and first previous node) is DropTargetNode
    //If it is true, we must abort Drag&Drop move
    Result := True;
    if High(Nodes) > 0 then
    begin
      if Sender.GetPrevious(Nodes[0]) = Sender.DropTargetNode then
        Exit(False);
      for J := 0 to High(Nodes) do
      begin
        if Nodes[J] = Sender.DropTargetNode then
          Exit(False);
      end;
    end;
  end;

begin
  case Mode of
    dmAbove  : AttachMode := amInsertBefore;
    dmOnNode : AttachMode := amInsertAfter;
    dmBelow  : AttachMode := amInsertAfter;
  else
    AttachMode := amNowhere;
  end;
  DetermineEffect;
  Nodes := Sender.GetSortedSelection(True);
  if Effect = DROPEFFECT_COPY then
  begin
    //Copy nodes
    for I := 0 to High(Nodes) do
      CopyVSTNode(Sender, Sender.DropTargetNode, Nodes[I], AttachMode);
    Log(Format('Copied %d ToDo items by Drag&Drop', [High(Nodes) + 1]), llInfo);
  end
  else begin
    //If a selected nodes is DropTargetNode, we must abort drag & drop
    if CheckTargetNode then
    begin
      //Move nodes in new location
      for I := 0 to High(Nodes) do
        Sender.MoveTo(Nodes[I], Sender.DropTargetNode, AttachMode, False);
      Log(Format('Moved %d ToDo items by Drag&Drop', [High(Nodes) + 1]), llInfo);
    end;
  end;
end;

procedure TfrmMain.vstListDragOver(Sender: TBaseVirtualTree; Source: TObject;
  Shift: TShiftState; State: TDragState; const Pt: TPoint; Mode: TDropMode;
  var Effect: LongWord; var Accept: Boolean);
begin
  Accept := (Sender = Source);
end;

procedure TfrmMain.vstListFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode
  );
var
  NodeData: PTreeNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData.Data) then
    NodeData.Data.Free;
end;

procedure TfrmMain.vstListGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  NodeDataSize := SizeOf(rTreeNodeData);
end;

procedure TfrmMain.vstListGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: String);
var
  NodeData: PTreeNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData.Data) then
    CellText := NodeData.Data.Text;
end;

procedure TfrmMain.vstListInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
begin
  Sender.CheckType[Node] := ctCheckBox;
end;

procedure TfrmMain.vstListNewText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; const NewText: String);
var
  NodeData: PTreeNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData.Data) and (NewText <> '') then
    NodeData.Data.Text := NewText;
end;

procedure TfrmMain.vstListPaintText(Sender: TBaseVirtualTree;
  const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex;
  TextType: TVSTTextType);
var
  NodeData: PTreeNodeData;
begin
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData.Data) then
  begin
    if NodeData.Data.Color <> clNone then
      TargetCanvas.Font.Color := InvertColor(NodeData.Data.Color);
  end;
  if Sender.CheckState[Node] = csCheckedNormal then
    TargetCanvas.Font.Style := TargetCanvas.Font.Style + [fsStrikeOut];
end;

function TfrmMain.ShowProperty(ATree: TBaseVirtualTree; ANode: PVirtualNode): Boolean;
var
  NodeData: PTreeNodeData;
begin
  Result := False;
  if Assigned(ANode) then
  begin
    NodeData := ATree.GetNodeData(ANode);
    if Assigned(NodeData.Data) then
      Result := TfrmProperty.Execute(Self, NodeData.Data);
  end;
end;

procedure TfrmMain.CopyToClipboard;
var
  I: Integer;
  sTemp: string;
  Nodes: TNodeArray;
begin
  sTemp := '';
  //Convert selected nodes in string
  Nodes := vstList.GetSortedSelection(False);
  sTemp := FToDoManager.NodesToString(Nodes);
  //Set sTemp in clipboard
  if sTemp <> '' then
  begin
    Clipboard.AsText := sTemp;
    Log(Format('Copied ToDo item %s in clipboard',[QuotedStr(sTemp)]), llInfo);
  end;
end;

procedure TfrmMain.DeleteCheckedNodes(ATree: TBaseVirtualTree);
var
  Nodes : TNodeArray;
  I     : Integer;
begin
  Nodes := GetCheckedNodes(ATree);
  if Length(Nodes) > 0 then
  begin
    FUndoList.Push(FToDoManager.NodesToString(Nodes));
    //Delete all checked nodes
    for I := High(Nodes) downto 0 do
      ATree.DeleteNode(Nodes[I]);
  end;
end;

procedure TfrmMain.DeleteSelectedNodes(ATree: TBaseVirtualTree);
var
  Nodes: TNodeArray;
begin
  Nodes := ATree.GetSortedSelection(False);
  if Length(Nodes) > 0 then
  begin
    FUndoList.Push(FToDoManager.NodesToString(Nodes));
    ATree.DeleteSelectedNodes;
    Log(Format('Deleted %d selected ToDo Items', [Length(Nodes)]), llInfo);
  end;
end;

function TfrmMain.GetCheckedNodes(ATree: TBaseVirtualTree): TNodeArray;
var
  Node: PVirtualNode;
  I: Integer;
begin
  //Find all checked nodes
  I := 0;
  Node := vstList.GetFirst;
  while Assigned(Node) do
  begin
    if ATree.CheckState[Node] = csCheckedNormal then
    begin
      SetLength(Result, I + 1);
      Result[I] := Node;
      Inc(I);
    end;
    Node := vstList.GetNext(Node);
  end;
end;

procedure TfrmMain.AddNewToDoItem(ATree: TBaseVirtualTree; AQuickMode: Boolean);
var
  Node: PVirtualNode;
begin
  if AQuickMode then
    Log('Added new ToDo Item (quick mode)', llInfo)
  else
    Log('Added new ToDo Item', llInfo);
  ATree.BeginUpdate;
  try
    Node := AddVSTNode(ATree);
    //Quick mode
    if AQuickMode then
      ATree.EditNode(Node, -1)
    else begin
      if not(ShowProperty(ATree, Node)) then
        ATree.DeleteNode(Node);
    end;
  finally
    ATree.EndUpdate;
  end;
end;

procedure TfrmMain.ExitApp(Sender: TObject);
begin
  FShutDownTime := True;
  Close;
end;

procedure TfrmMain.ShowApp(Sender: TObject);
begin
  //Show or hide main form based of frmMain.Visible
  if Self.Visible then
    HideMainForm
  else
    ShowMainForm(Sender);
end;

procedure TfrmMain.HideMainForm;
begin
  //Hide frmMain and taskbar icon
  Hide;
  ShowInTaskBar := stNever;
end;

procedure TfrmMain.FindNodeInTree(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Data: Pointer; var Abort: Boolean);
var
  NodeData: PTreeNodeData;
  KeyWord: string;
begin
  Keyword  := string(Data);
  NodeData := Sender.GetNodeData(Node);
  if Assigned(NodeData.Data) then
    Sender.IsVisible[Node] := (pos(UpperCase(Keyword), UpperCase(NodeData.Data.Text)) <> 0) or
                              (Keyword = '');
end;

procedure TfrmMain.MoveItemUp(const ATree: TBaseVirtualTree);
var
  Nodes: TNodeArray;
  CurrentNode: PVirtualNode;
  I: Integer;
begin
  Nodes := ATree.GetSortedSelection(True);
  if Length(Nodes) > 0 then
  begin
    for I := Low(Nodes) to High(Nodes) do
    begin
      CurrentNode := ATree.GetPrevious(Nodes[I]);
      if Assigned(CurrentNode) then
        ATree.MoveTo(Nodes[I], CurrentNode, amInsertBefore, False)
      else
        ATree.MoveTo(Nodes[I], ATree.GetLast, amInsertAfter, False);
    end;
  end;
end;

procedure TfrmMain.MoveItemDown(const ATree: TBaseVirtualTree);
var
  Nodes: TNodeArray;
  CurrentNode: PVirtualNode;
  I: Integer;
begin
  Nodes := ATree.GetSortedSelection(True);
  if Length(Nodes) > 0 then
  begin
    for I := High(Nodes) downto Low(Nodes) do
    begin
      CurrentNode := ATree.GetNext(Nodes[I]);
      if Assigned(CurrentNode) then
        ATree.MoveTo(Nodes[I], CurrentNode, amInsertAfter, False)
      else
        ATree.MoveTo(Nodes[I], ATree.GetFirst, amInsertBefore, False);
    end;
  end;
end;

procedure TfrmMain.CloseCurrentToDoFile;
begin
  Log('Closing actual ToDo.txt', llInfo);
  FToDoManager.SaveAs(FSettings.LastToDoFileName);
  vstList.Clear;
end;

procedure TfrmMain.PasteFromClipboard;
var
  I: Integer;
  StringList: TStringList;
begin
  StringList := TStringList.Create;
  try
    StringList.Text := Clipboard.AsText;
    FToDoManager.StringsToNode(StringList);
    Log(Format('Paste text %s and create a new todo item', [QuotedStr(Clipboard.AsText)]), llInfo);
  finally
    StringList.Free;
  end;
end;

end.

