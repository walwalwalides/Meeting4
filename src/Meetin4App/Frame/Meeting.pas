{ ============================================
  Software Name : 	Meeting4
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Meeting;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Objects, FMX.ListBox,
  FMX.Controls.Presentation, FMX.ScrollBox, FMX.Memo, FMX.TMSPlanner,
  FMX.TabControl, FMX.TMSBaseControl,
  FMX.TMSBaseGroup, FMX.TMSRadioGroup, FMX.Edit;

type
  TWorker = record
    name: string;
    ID: integer;

  end;

  TfraMeeting = class(TFrame)
    Rectangle1: TRectangle;
    Memo1: TMemo;
    cbPerson: TComboBox;
    cbRaum: TComboBox;
    Rectangle2: TRectangle;
    btnCrMeeting: TButton;
    btnBack: TButton;
    lblRaum: TLabel;
    btnDelete: TButton;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem2: TTabItem;
    TMSFMXRadioGroup1: TTMSFMXRadioGroup;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    cbColumns: TComboBox;
    cbGroupCheck: TCheckBox;
    cbBitmaps: TCheckBox;
    memDesEvent: TMemo;
    edtEventName: TEdit;
    lblEvent: TLabel;
    lblStatus: TLabel;
    btnReport: TButton;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure btnBackClick(Sender: TObject);
    procedure cbPersonChange(Sender: TObject);
    procedure cbRaumChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnCrMeetingClick(Sender: TObject);
    procedure cbColumnsChange(Sender: TObject);
    procedure btnReportClick(Sender: TObject);
  private
    FMeetingDate: TDate;
    FRaum: string;
    procedure initialCBPerson;
    procedure StartDateEditChanged(Sender: TObject);
    procedure SetColumns(nr: integer);
    procedure GenerateRadioGrpMeeting(AIndex: integer);
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure FirstShow;
    procedure ReleaseFrame;
    constructor initialCBRaum;
  end;

var
  fraMeeting: TfraMeeting;
  ArrWorker: Array of TWorker;
  ArrWChoice: Array of integer;
  ActualLength: integer = 0;

  FStartDateEdit: TTMSFMXPlannerDateEdit;

implementation

uses
  ClientModuleApp, System.JSON, uMain, System.dateutils,uOpenUtils
{$IFDEF ANDROID}
    , Androidapi.JNI.GraphicsContentViewText,
  FMX.Helpers.Android,
  Androidapi.JNI.JavaTypes
{$ENDIF}
    ;

{$R *.fmx}

{ TfraMeeting2 }
var
  sStringsMeeting: TStringList;
  sAllID: String;

procedure AddElement(const intInput: integer);
begin
  ArrWChoice[ActualLength] := intInput;
  inc(ActualLength);
end;

procedure TfraMeeting.btnBackClick(Sender: TObject);
begin
  if (TabControl1.TabIndex = 1) then
  Begin
    TabControl1.TabIndex := 0;
    btnCrMeeting.Text := 'Choose';
  End
  else
    ReleaseFrame;
end;

procedure Split(const Delimiter: Char; Input: string;
  const Strings: TStringList);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

procedure TfraMeeting.initialCBPerson;
var
  sInput: string;
  sStrings: TStringList;
  I: integer;
  ipos: integer;
  sMe: string;
begin
  // sInput:=TJSONValue.Create;

  sInput := ClientModule.ServerMethods1Client.GetAllWorkerID;
  SetLength(sInput, Length(sInput) - 1);

  if (sInput.IsEmpty) then
    exit;

  sStrings := TStringList.Create;
  Split(';', sInput, sStrings);
  // ----------------------------------- //
  SetLength(ArrWorker, sStrings.Count);

  // ----------------------------------- //
  for I := 0 to sStrings.Count - 1 do
  begin
    ipos := pos(',', sStrings[I]);
    sMe := Copy(sStrings[I], ipos + 1, Length(sStrings[I]));
    if (sMe = username) then
    begin
      ArrWorker[I].name := Copy(sStrings[I], ipos + 1, Length(sStrings[I])) +
        ' ( Me )';
    end
    else
      ArrWorker[I].name := Copy(sStrings[I], ipos + 1, Length(sStrings[I]));
    ArrWorker[I].ID := StrToInt(Copy(sStrings[I], 0, ipos - 1));

    cbPerson.Items.Add(ArrWorker[I].name);

  end;

  try

  finally
    FreeAndNil(sStrings);
  end;
end;

procedure TfraMeeting.SetColumns(nr: integer);
begin
  TMSFMXRadioGroup1.Columns := nr;

  // TMSFMXRadioGroupPicker1.Columns := cbColumns.ItemIndex + 1;
end;

procedure TfraMeeting.btnCrMeetingClick(Sender: TObject);
var
  sMeetingProp: string;

  inAskBool: Boolean;
  I: integer;
var
  it: TTMSFMXGroupItem;
  sInput: string;
  sRes: string;
  ANameEvent, AIntervalEvent, ADesEvent: String;
  stmp: string;
begin
  stmp := TMSFMXRadioGroup1.Items[TMSFMXRadioGroup1.Index].Text;
  AIntervalEvent := Copy(stmp, 4, Length(stmp) - 7);

  if (btnCrMeeting.Text = 'Create') then
  begin
    if (AIntervalEvent.IsEmpty) then
    Begin
      lblStatus.Text := 'No Meeting Selected';
      // MessageDlg('No Meeting Selected', TMsgDlgType.mtWarning,
      // [TMsgDlgBtn.mbOK], 0);
      exit;
    End;

    ANameEvent := edtEventName.Text;
    if (ANameEvent.IsEmpty) then
    Begin
      lblStatus.Text := 'Event name field is empty';
      // MessageDlg('Event name field is empty', TMsgDlgType.mtWarning,
      // [TMsgDlgBtn.mbOK], 0);
      exit;
    End;

    ADesEvent := memDesEvent.Text;
    if (ADesEvent.IsEmpty) then
    Begin
      lblStatus.Text := 'Event description field is empty';
      // MessageDlg('Event description field is empty', TMsgDlgType.mtWarning,
      // [TMsgDlgBtn.mbOK], 0);
      exit;
    End;
    FMeetingDate := FStartDateEdit.Date;
    sRes := ClientModule.ServerMethods1Client.CrMeetingEvent(sAllID, FRaum,
      ANameEvent, AIntervalEvent, datetostr(FMeetingDate), cbColumns.Index-1,
      ADesEvent);

    if (sRes = 'OK') then
    begin
      lblStatus.Text := 'New Event Meeting Added';
      // MessageDlg('New Event Meeting Added', TMsgDlgType.mtInformation,
      // [TMsgDlgBtn.mbOK], 0);
      fraMeeting.ReleaseFrame;
    end
    else
      lblStatus.Text := 'Error By Adding Event Meeting !';
    // MessageDlg('Error By Adding Event Meeting !', TMsgDlgType.mtWarning,
    // [TMsgDlgBtn.mbOK], 0);
  end
  else if (Memo1.Lines.Count > 0) then
  Begin
    if (cbRaum.ItemIndex > 0) then
      exit;
    btnCrMeeting.Text := 'Create';
    TabControl1.TabIndex := 1;

    inAskBool := (FRaum <> '') and (datetostr(FMeetingDate) <> '');
    sAllID := '';
    for I := Low(ArrWChoice) to High(ArrWChoice) do
      sAllID := sAllID + IntToStr(ArrWChoice[I]) + ',';

    SetLength(sAllID, Length(sAllID) - 1);

    if (inAskBool = true) then
      sMeetingProp := ClientModule.ServerMethods1Client.GetMeetingProposition
        (WorkerID, FRaum, datetostr(FMeetingDate), sAllID);

    SetLength(sMeetingProp, Length(sMeetingProp) - 2);

    if (sMeetingProp.IsEmpty) then
      exit
    else
      sInput := sMeetingProp;

    Split('+', sInput, sStringsMeeting);

    TMSFMXRadioGroup1.BeginUpdate;
    TMSFMXRadioGroup1.Width := 300;
    TMSFMXRadioGroup1.Height := 185;
    TMSFMXRadioGroup1.Text := 'Select Meeting';
    TMSFMXRadioGroup1.Items.Clear;
    for I := 0 to sStringsMeeting.Count - 1 do
    Begin
      if (sStringsMeeting[I] = '2/') then
      Begin
        if (TMSFMXRadioGroup1.Items.Count > 0) then
        Begin
          cbColumns.ItemIndex := 0;
          Break;
        End;
      End;
      if (sStringsMeeting[I] <> '1/') then
      Begin
        it := TMSFMXRadioGroup1.Items.Add;
        it.Text := '<b>' + sStringsMeeting[I] + '</b>';
      End;
    End;

    SetColumns(2);
    TMSFMXRadioGroup1.GroupCheckBoxType :=
      TTMSRadioGroupCheckBoxType.ctToggleEnabled;
    TMSFMXRadioGroup1.GroupCheckBoxChecked := true;
    TMSFMXRadioGroup1.ItemIndex := 0;
    TMSFMXRadioGroup1.EndUpdate;
  end;
end;

procedure TfraMeeting.btnDeleteClick(Sender: TObject);
begin
  if (Memo1.Lines.Count > 0) then
  Begin
    Memo1.Lines.Delete(Memo1.Lines.Count - 1);
    SetLength(ArrWChoice, ActualLength - 1);
    if (ActualLength >= 1) then
      Dec(ActualLength);

  End;
  if (Memo1.Text = '') then
    cbPerson.ItemIndex := -1;
end;

procedure TfraMeeting.btnReportClick(Sender: TObject);
var
  RelatorioStream: TStream;

  memoria: TMemoryStream;
  Buffer: PByte;
  BufSize: integer;
  BytesLido: integer;

  tamanho: int64;
 MeetingReportPDF : string;
begin

   {$IF DEFINED(IOS) or DEFINED(ANDROID)}
   MeetingReportPDF := TPath.GetDocumentsPath + PathDelim+Dir_PACKAGEDB+PathDelim
    + 'MeetingReport.pdf';
{$ELSE}
   MeetingReportPDF := ExtractFilePath(ParamStr(0)) + 'MeetingReport.pdf';
{$ENDIF}




  if FileExists(MeetingReportPDF) then
    DeleteFile(MeetingReportPDF);
  BufSize := 1024;
  try
    memoria := TMemoryStream.Create;
    GetMem(Buffer, BufSize);

    RelatorioStream := ClientModule.ServerMethods1Client.GetReportMeeting(tamanho);
    RelatorioStream.Position := 0;
    if tamanho <> 0 then
    begin
      repeat
        BytesLido := RelatorioStream.Read(pointer(Buffer)^, BufSize);
        if BytesLido > 0 then
          memoria.WriteBuffer(pointer(Buffer)^, BufSize);

        Application.ProcessMessages;
      until (BytesLido < BufSize);

      memoria.SaveToFile(MeetingReportPDF);
    end;

  finally
    FreeMem(Buffer,BufSize);
    FreeAndNil(memoria);
  end;

  if FileExists(MeetingReportPDF) then

//   ShellExecute(Handle, nil, PChar(MeetingReportPDF), nil,  nil, SW_SHOWNORMAL);
    TMisc.Open(MeetingReportPDF);


end;

function SerachName(AName: string): integer;
var
  I: longint; // Deine Laufvariable
begin
  I := 0;
  Result := 0;
  while (I <= Length(ArrWorker)) and (Result = 0) do
  begin
    if ArrWorker[I].name = AName then
      Result := ArrWorker[I].ID;
    inc(I)
  end;
end;

procedure TfraMeeting.GenerateRadioGrpMeeting(AIndex: integer);
var
  BoolFound: Boolean;
  I: integer;
  it: TTMSFMXGroupItem;
Begin
  BoolFound := false;
  TMSFMXRadioGroup1.BeginUpdate;
  TMSFMXRadioGroup1.Width := 300;
  TMSFMXRadioGroup1.Height := 185;
  TMSFMXRadioGroup1.Text := 'Select Meeting';
  TMSFMXRadioGroup1.Items.Clear;
  for I := 0 to sStringsMeeting.Count - 1 do
  Begin
    if (BoolFound = true) then
    Begin
      if (pos('/', sStringsMeeting[I]) > 0) then
        Break;
      it := TMSFMXRadioGroup1.Items.Add;
      it.Text := '<b>' + sStringsMeeting[I] + '</b>';
    End;

    if (sStringsMeeting[I] = IntToStr(AIndex + 1) + '/') then
    Begin
      BoolFound := true;
    End;

  End;

  SetColumns(2);
  TMSFMXRadioGroup1.GroupCheckBoxType :=
    TTMSRadioGroupCheckBoxType.ctToggleEnabled;
  TMSFMXRadioGroup1.GroupCheckBoxChecked := true;
  TMSFMXRadioGroup1.ItemIndex := 0;
  TMSFMXRadioGroup1.EndUpdate;

End;

procedure TfraMeeting.cbColumnsChange(Sender: TObject);
begin
  GenerateRadioGrpMeeting(cbColumns.ItemIndex);
end;

procedure TfraMeeting.cbPersonChange(Sender: TObject);
var
  sChoice: string;
  function alreadyExist(Asearch: string): Boolean;
  var
    lineNumber: integer;
  begin
    Result := false;
    for lineNumber := 0 to Memo1.Lines.Count - 1 do
    begin
      Result := pos(Asearch, Memo1.Lines[lineNumber]) > 0;
      if (Result = true) then
        exit;

    end;

  End;

begin
  if (cbPerson.ItemIndex = -1) then
    exit;

  sChoice := cbPerson.Items[cbPerson.ItemIndex];
  if ((sChoice <> '') and not(alreadyExist(sChoice))) then
  begin
    SetLength(ArrWChoice, ActualLength + 1);
    AddElement(SerachName(sChoice));

    Memo1.Lines.Add(sChoice);
  end;
end;

procedure TfraMeeting.cbRaumChange(Sender: TObject);
var
  sChoice: string;
begin
  sChoice := cbRaum.Items[cbRaum.ItemIndex];
  FRaum := sChoice;
  lblRaum.Text := 'Raum : ' + sChoice;
end;

constructor TfraMeeting.Create(AOwner: TComponent);
begin
  inherited;
  // cbRaum.Items.Clear;
  // cbPerson.Items.Clear;
  lblStatus.Text := '';
  lblStatus.TextSettings.FontColor := TAlphaColorRec.Red;
  initialCBRaum;
  initialCBPerson;
  TabControl1.TabIndex := 0;
  TabControl1.tabPosition := TTabPosition.None;
  btnCrMeeting.Text := 'Choose';
  FStartDateEdit := TTMSFMXPlannerDateEdit.Create(TabItem1);
  FStartDateEdit.OnChange := StartDateEditChanged;
  FStartDateEdit.Width := 100;
  FStartDateEdit.Position.X := lblRaum.Position.X + 245;
  FStartDateEdit.Position.Y := lblRaum.Position.Y - 30
  { -int((lblRaum.Height - FStartDateEdit.Height) / 2) };
  FStartDateEdit.Parent := TabItem1;
  sStringsMeeting := TStringList.Create;

  cbBitmaps.Visible := false;
  cbGroupCheck.Visible := false;
end;

procedure TfraMeeting.StartDateEditChanged(Sender: TObject);
var
  dt, dte: TDateTime;
begin
  if Assigned(FStartDateEdit) then
  begin
    dt := FStartDateEdit.Date;

    // if CompareDateTime(dt + IncMilliSecond(0, 1), dte) = GreaterThanValue then
    // FStartDateEdit.Date := FDialogStartDate
    // else
    FMeetingDate := FStartDateEdit.Date;
  end;
end;

constructor TfraMeeting.initialCBRaum;
var
  sInput: string;
  sStrings: TStringList;
begin
  inherited;

  sInput := ClientModule.ServerMethods1Client.GetWorkerRaum;
  SetLength(sInput, Length(sInput) - 1);

  if (sInput.IsEmpty) then
    exit;

  sStrings := TStringList.Create;
  Split(';', sInput, sStrings);

  try
    cbRaum.Items.Assign(sStrings);
  finally
    sStrings.Free;
  end;

  //
end;

destructor TfraMeeting.Destroy;
begin
  //
  FreeAndNil(sStringsMeeting);
  inherited;
end;

procedure TfraMeeting.FirstShow;
begin
  //

end;

procedure TfraMeeting.ReleaseFrame;
begin
  //
{$IF DEFINED(IOS) or DEFINED(ANDROID)}
  DisposeOf;
{$ELSE}
  Free;
{$ENDIF}
  fraMeeting := Nil;

end;

end.
