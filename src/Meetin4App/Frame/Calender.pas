{ ============================================
  Software Name : 	Meeting4
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Calender;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  Data.DB, Datasnap.DBClient, FMX.TMSPlanner,
  FMX.TMSPlannerItemEditorRecurrency, FMX.TMSPlannerDatabaseAdapter,
  FMX.TMSBaseControl, FMX.TMSPlannerBase, FMX.TMSPlannerData,
  FMX.TMSBitmapContainer, FMX.Controls.Presentation, System.ImageList,
  FMX.ImgList, FMX.Objects;

type
  TfraCalender = class(TFrame)
    Planner: TTMSFMXPlanner;
    PlannerDatabaseAdapter: TTMSFMXPlannerDatabaseAdapter;
    PlannerItemEditorRecurrency: TTMSFMXPlannerItemEditorRecurrency;
    Panel1: TPanel;
    btnBack: TButton;
    DataSource1: TDataSource;
    BitmapContainer: TTMSFMXBitmapContainer;
    Label2: TLabel;
    btnSaveCalender: TButton;
    ImageList1: TImageList;
    Rectangle1: TRectangle;
    ClientDataSetCalender: TClientDataSet;
    procedure btnBackClick(Sender: TObject);

    procedure PlannerDatabaseAdapterFieldsToItem(Sender: TObject;
      AFields: TFields; AItem: TTMSFMXPlannerItem);
    procedure PlannerDatabaseAdapterItemToFields(Sender: TObject;
      AItem: TTMSFMXPlannerItem; AFields: TFields);
    procedure PlannerIsDateTimeSub(Sender: TObject; ADateTime: TDateTime;
      var AIsSub: Boolean);
    procedure PlannerAfterNavigateToDateTime(Sender: TObject;
      ADirection: TTMSFMXPlannerNavigationDirection;
      ACurrentDateTime, ANewDateTime: TDateTime);
    procedure btnSaveCalenderClick(Sender: TObject);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure PlannerAfterInsertItem(Sender: TObject; AStartTime, AEndTime: TDateTime; APosition: Integer;
      AItem: TTMSFMXPlannerItem);
  private

    { Private declarations }
  public
    { Public declarations }
    procedure FirstShow;
    procedure ReleaseFrame;
  end;

var
  fraCalender: TfraCalender;

implementation

uses
  DateUtils, UIConsts, uGoFrame, ClientModuleApp, uMain, System.IOUtils;

{$R *.fmx}

procedure TfraCalender.btnBackClick(Sender: TObject);
begin
  ClientDataSetCalender.Active := not ClientDataSetCalender.Active;
  ClientDataSetCalender.Close;
  // if ClientDataSetCalender.Active then
  // btnBack.Text := 'Disconnect'
  // else
  // btnBack.Text := 'Connect';
  ReleaseFrame;
end;

constructor TfraCalender.Create(AOwner: TComponent);
var
  I: Integer;
  res: TTMSFMXPlannerResource;
  sxmlFile: string;
begin
  inherited;
  Label2.visible := False;
  // faCalender.
  Planner.BeginUpdate;
  Planner.DefaultItem.Color := $FF5EB3FE{claOrange};
  Planner.BitmapContainer := BitmapContainer;
  Planner.Interaction.UpdateMode := pumDialog;
  Planner.Interaction.TopNavigationButtons := [pnbPrevious, pnbNext];
  Planner.Interaction.MouseInsertMode := pmimAfterSelection;
  Planner.Interaction.KeyboardInsertMode := pkimSelection;
  Planner.DefaultItem.FontColor := claWhite;
  Planner.DefaultItem.TitleFontColor := claWhite;
  Planner.ModeSettings.StartTime := Now;
  Planner.Mode := pmDay;
  Planner.TimeLine.DisplayUnit := 60;
  Planner.TimeLine.DisplayUnitSize := 60;
  Planner.TimeLine.DisplayUnitFormat := 'dddd dd/mm';
  Planner.TimeLine.DisplaySubUnitFormat := 'hh:nn';
  Planner.TimeLine.DisplayEnd :=
    Round((MinsPerDay * 7) / Planner.TimeLine.DisplayUnit) - 1;
  Planner.PositionsAppearance.TopSize := 120;
  Planner.Resources.Clear;

  Planner.TimeLineAppearance.LeftSize := 110;
  Planner.PositionsAppearance.TopFont.Size := 10; // font size user name
  Planner.TimeLineAppearance.LeftFont.Size := 10;

  for I := 0 to 0 { TMSFMXBitmapContainer1.Items.Count - 1 } do
  begin
    res := Planner.Resources.Add;
    res.Name := BitmapContainer.Items[I].Name;
    res.Text := '<img width="80" src="' + res.Name +
      '"></img><br><p align="center">' + username+ '</p>';
      res.Name:=username;
  end;

  // Planner.Positions.Count := Planner.Resources.Count;
  Planner.Positions.Count := 1;
  Planner.EndUpdate;

  ClientDataSetCalender.FieldDefs.Add('Id', ftString, 255);
  ClientDataSetCalender.FieldDefs.Add('Resource', ftString, 10);
  ClientDataSetCalender.FieldDefs.Add('Title', ftString, 10);
  ClientDataSetCalender.FieldDefs.Add('Text', ftString, 255);
  ClientDataSetCalender.FieldDefs.Add('StartTime', ftDateTime);
  ClientDataSetCalender.FieldDefs.Add('EndTime', ftDateTime);
  ClientDataSetCalender.FieldDefs.Add('Recurrency', ftString, 255);
  ClientDataSetCalender.FieldDefs.Add('Color', ftLongWord);
  ClientDataSetCalender.CreateDataSet;

  Planner.Adapter := PlannerDatabaseAdapter;
  Planner.ItemEditor := PlannerItemEditorRecurrency;
  PlannerDatabaseAdapter.Item.AutoIncrementDBKey := False;
  PlannerDatabaseAdapter.Item.DataSource := DataSource1;
  PlannerDatabaseAdapter.Item.DBKey := 'Id';
  PlannerDatabaseAdapter.Item.StartTime := 'StartTime';
  PlannerDatabaseAdapter.Item.EndTime := 'EndTime';
  PlannerDatabaseAdapter.Item.Title := 'Title';
  PlannerDatabaseAdapter.Item.Text := 'Text';
  PlannerDatabaseAdapter.Item.Resource := 'Resource';
  PlannerDatabaseAdapter.Item.Recurrency := 'Recurrency';

  ClientDataSetCalender.Insert;
//   ClientDataSetCalender.FieldByName('Id').AsString := TGuid.NewGuid.ToString;
//   ClientDataSetCalender.FieldByName('StartTime').AsDateTime := Int(Now) +
//   EncodeTime(8, 0, 0, 0);
//   ClientDataSetCalender.FieldByName('EndTime').AsDateTime := Int(Now) +
//   EncodeTime(20, 0, 0, 0);
//   ClientDataSetCalender.FieldByName('Resource').AsInteger := 0;
//   ClientDataSetCalender.FieldByName('Title').AsString := 'Miami';
//   ClientDataSetCalender.FieldByName('Text').AsString := 'Dialy shoot at the beach';
//   ClientDataSetCalender.FieldByName('Recurrency').AsString := 'RRULE:FREQ=DAILY';
//   ClientDataSetCalender.FieldByName('Color').AsLongWord := claOrange;

  ClientDataSetCalender.Post;

{$IF DEFINED(IOS) or DEFINED(ANDROID)}
  sxmlFile := TPath.GetDocumentsPath + PathDelim + 'MyCalender.XML';
  if FileExists(sxmlFile) then
    ClientDataSetCalender.LoadFromFile(sxmlFile);
{$ELSE}
{$IFDEF UNICODE}
  sxmlFile := GetCurrentDir + '\MyCalender.XML';
  if FileExists(sxmlFile) then
    ClientDataSetCalender.LoadFromFile(sxmlFile);
{$ELSE}
  sxmlFile := gsAppPath + 'MyCalender.XML';
  if FileExists(sxmlFile) then
    ClientDataSetCalender.LoadFromFile(sxmlFile);
{$ENDIF}
{$ENDIF}
     ClientDataSetCalender.Edit;
      ClientDataSetCalender.Post;

  PlannerDatabaseAdapter.Active := True;
end;

procedure TfraCalender.FirstShow;
begin
  //
end;

procedure TfraCalender.ReleaseFrame;
begin
{$IF DEFINED(IOS) or DEFINED(ANDROID)}
  DisposeOf;
{$ELSE}
  Free;
{$ENDIF}
  fraCalender := Nil;



end;

destructor TfraCalender.Destroy;
begin
  //
  inherited;
end;

procedure DeleteLastChar(var aText: string; aLastChar: char); inline;
var
  len: {$IFDEF FPC}PSizeInt{$ELSE}PInteger{$ENDIF};
  achar, bChar: char;
begin
  achar := '.';
  bChar := ']';
  len := pointer(aText);
  if len <> nil then
  begin
    dec(len);

    if PChar(pointer(aText))[len^ - 1] = aLastChar then
    begin

      PChar(pointer(aText))[len^ - 1] := #0;
      dec(len^);
      aText := aText + achar;

    end
    else if PChar(pointer(aText))[len^ - 1] = bChar then
    begin
      aText := aText + achar;
    end;

  end;
end;

procedure TfraCalender.btnSaveCalenderClick(Sender: TObject);
var
  sChoiceDay: string;
  sChoiceHour: string;
  I: Integer;
  tmp: string;
  sStratTime: string;
  sEndTime: string;

begin

{$IF DEFINED(IOS) or DEFINED(ANDROID)}
  ClientDataSetCalender.SaveToFile(TPath.GetDocumentsPath + PathDelim +
    'MyCalender.XML', dfXML);
{$ELSE}
{$IFDEF UNICODE}
  ClientDataSetCalender.SaveToFile(GetCurrentDir + '\MyCalender.XML', dfXML);
{$ELSE}
  ClientDataSetCalender.SaveToFile(gsAppPath + 'MyCalender.XML', dfXML);
{$ENDIF}
{$ENDIF}
  //


  sChoiceDay := DateToStr(Planner.CellToDateTime(Planner.Selection.StartCell));
  // ShowMessage(sChoiceDateTime);

  sChoiceHour := '';
  for I := 0 to Planner.Items.Count - 1 do
  begin
    tmp := DateToStr(Planner.Items[I].StartTime);
    if (tmp = sChoiceDay) then
    Begin
      datetimetostring(sStratTime, 't', Planner.Items[I].StartTime);
      datetimetostring(sEndTime, 't', Planner.Items[I].EndTime);
      sChoiceHour := sChoiceHour {+ '['} + sStratTime + '-' + sEndTime {+ ']'};
      if (I < Planner.Items.Count - 1) then
        sChoiceHour := sChoiceHour + ',';
    End;

  end;
  DeleteLastChar(sChoiceHour, ',');
  sChoiceHour:= stringreplace(sChoiceHour, '00', '',[rfReplaceAll, rfIgnoreCase]);
  sChoiceHour:= stringreplace(sChoiceHour, ':', '',[rfReplaceAll, rfIgnoreCase]);

  // ShowMessage(sChoiceHour);

  ClientModule.ServerMethods1Client.UpdateWorkerCalender(WorkerID, Username,
    sChoiceDay, sChoiceHour);

  { TODO : Add new methode to update calender user }
    ClientDataSetCalender.Active := not ClientDataSetCalender.Active;
  ClientDataSetCalender.Close;

  ReleaseFrame;

end;

procedure TfraCalender.PlannerAfterInsertItem(Sender: TObject; AStartTime, AEndTime: TDateTime; APosition: Integer;
  AItem: TTMSFMXPlannerItem);
var
  k: integer;
begin
  k:=Planner.Items.Count;
end;

procedure TfraCalender.PlannerAfterNavigateToDateTime(Sender: TObject;
  ADirection: TTMSFMXPlannerNavigationDirection;
  ACurrentDateTime, ANewDateTime: TDateTime);
begin
  PlannerDatabaseAdapter.LoadItems;
end;

procedure TfraCalender.PlannerIsDateTimeSub(Sender: TObject;
  ADateTime: TDateTime; var AIsSub: Boolean);
begin
  AIsSub := HourOf(ADateTime) + MinuteOf(ADateTime) + SecondOf(ADateTime) +
    MilliSecondOf(ADateTime) > 0;
end;

procedure TfraCalender.PlannerDatabaseAdapterFieldsToItem(Sender: TObject;
  AFields: TFields; AItem: TTMSFMXPlannerItem);
var
  c: TAlphaColor;
begin
  c := AFields.FieldByName('Color').AsLongWord;
  if c <> 0 then
    AItem.Color := c
  else
    AItem.Color := Planner.DefaultItem.Color;

  if AItem.Color = claGhostwhite then
  begin
    AItem.TitleFontColor := claDarkGray;
    AItem.FontColor := claDarkGray;
  end;
end;

procedure TfraCalender.PlannerDatabaseAdapterItemToFields(Sender: TObject;
  AItem: TTMSFMXPlannerItem; AFields: TFields);
begin
  //
end;

end.
