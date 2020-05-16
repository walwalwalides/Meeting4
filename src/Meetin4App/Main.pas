{ ============================================
  Software Name : 	Meeting4
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Main;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.StdCtrls,
  FMX.Edit, FMX.Controls.Presentation, FMX.ListBox, FMX.ScrollBox, FMX.Memo,
  Data.DBXDataSnap, Data.DBXCommon, IPPeerClient, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, Data.SqlExpr, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt, Data.Bind.Components,
  Data.Bind.DBScope, System.ImageList, FMX.ImgList, System.Actions,
  FMX.ActnList, FMX.Menus, FMX.Layouts, FMX.Objects, BCLsMeetingEvent;

type
  TfrmMain = class(TForm)
    lblTitel: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    ComboBox2: TComboBox;
    Label3: TLabel;
    Edit2: TEdit;
    Memo1: TMemo;
    Label5: TLabel;
    Label6: TLabel;
    DurationTimer: TTimer;
    pnlMain: TPanel;
    UpdateInfoTimer: TTimer;
    ServerConnection: TSQLConnection;
    DSProviderConnection1: TDSProviderConnection;
    DriverStatusCDS: TClientDataSet;
    DriverStatusCDSid: TIntegerField;
    DriverStatusCDSname: TWideStringField;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkFillControlToField1: TLinkFillControlToField;
    RideStatusCDS: TClientDataSet;
    RideStatusCDSid: TIntegerField;
    RideStatusCDSname: TWideStringField;
    BindSourceDB2: TBindSourceDB;
    LinkFillControlToField2: TLinkFillControlToField;
    btnCalender: TButton;
    MMMain: TMainMenu;
    mItemFile: TMenuItem;
    mItemExit: TMenuItem;
    mItemInfo: TMenuItem;
    mItemAbout: TMenuItem;
    ActLstMain: TActionList;
    ActAbout: TAction;
    ilMain: TImageList;
    ActExit: TAction;
    loLoad: TLayout;
    aniLoad: TAniIndicator;
    RecMain: TRectangle;
    btnCrMeeting: TButton;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure DurationTimerTimer(Sender: TObject);
    procedure UpdateInfoTimerTimer(Sender: TObject);
    procedure btnCalenderClick(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox2Click(Sender: TObject);
    procedure ActAboutExecute(Sender: TObject);
    procedure ActExitExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCrMeetingClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FMeetingEvent: TmeetingEvent;
    TimeSec: integer;
    iactWorkID: integer;
    sAdress: string;
    boolAddpram: Boolean;
    procedure gotoCalender;
    procedure gotoMeeting;
    procedure gotoMeetingEvent;

  public
    { Public declarations }
    function CheeckUsername(AUsername: string; AFirst: Boolean): Boolean;
    procedure GoOnline;

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

uses ClientModuleApp, About, Calender, uMain, Meeting,
  System.Generics.Collections, MeetingEvent,  uOpenUtils;

{$R *.NmXhdpiPh.fmx ANDROID}

var
  BoolMeetingEvent: Boolean = false;

procedure TfrmMain.ActAboutExecute(Sender: TObject);
begin

  Application.CreateForm(TFrmAbout, FrmAbout);
  // frmAbout:=TfrmAbout.Create(nil);
  FrmAbout.Position := TFormPosition.MainFormCenter;
  try
    FrmAbout.ShowModal;

  finally
    FreeAndNil(FrmAbout);
  end;

end;

procedure TfrmMain.ActExitExecute(Sender: TObject);
begin
  Close;
end;

function TfrmMain.CheeckUsername(AUsername: string; AFirst: Boolean): Boolean;
begin
  try
    Result := ClientModule.ServerMethods1Client.GetWorkerID(AUsername,
      AFirst) > 0;
  except
    Result := false

  end;
end;

procedure TfrmMain.GoOnline;
begin
  TimeSec := 0;
  Label6.Text := '00:00';
  Label6.Visible := false;
  ComboBox2.ItemIndex := -1;
  boolAddpram := false;
  Label2.Text := '';
  Label3.Text := '';
  sAdress := '';
  pnlMain.Visible := false;
  ComboBox2.Enabled := false;
  if (username <> '') then
  begin
    pnlMain.Visible := True;

    iactWorkID := ClientModule.ServerMethods1Client.GetWorkerID(username);

    ComboBox1.ItemIndex := 0;

    if (iactWorkID > 0) then
    begin
      WorkerID := iactWorkID;
      pnlMain.Visible := True;
      ComboBox1.Items[0] := 'Work-ID : ' + iactWorkID.ToString;
      ComboBox2.Enabled := True;
      UpdateInfoTimer.Enabled := True;
      Label3.Text := ClientModule.ServerMethods1Client.GetWorkerPosition
        (iactWorkID);
      boolAddpram := True;
      mItemInfo.Visible := false;
    end
    else
    begin
      Memo1.Lines.Clear;
      ComboBox2.Items[0] := 'No Information';
      ComboBox2.ItemIndex := 0;
      pnlMain.Visible := True;
      ComboBox1.Items[0] := 'Work-ID not found ! ';
      ComboBox2.Enabled := false;
      UpdateInfoTimer.Enabled := false;

    end;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Button1.Visible := false;
  pnlMain.Visible := false;
  DurationTimer.Enabled := false;
  TimeSec := 0;
  ComboBox2.Enabled := false;
  Position := TFormPosition.MainFormCenter;
{$IFDEF MSWINDOWS}
  // frmMain.clientWidth:=359;
  // frmMain.clientHeight:=640;

  btnCrMeeting.Position.y := frmMain.Height - 120;
  btnCalender.Position.y := frmMain.Height - 120;
  self.Caption := Application.Title;
  // mItemInfo.Visible:=false;
{$ENDIF MSWINDOWS}
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  // FreeAndNil(FLstMeetingEvent);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  // mItemInfo.Visible:=True;
  fnGoFrame(Loading, Login);

end;

procedure TfrmMain.UpdateInfoTimerTimer(Sender: TObject);
var
  boolactWorkID: Boolean;
  sPosition: string;
  icount: integer;

  I: integer;
begin
  try
    if (boolAddpram = True) then
      boolactWorkID := ClientModule.ServerMethods1Client.GetWorkerActive
        (iactWorkID);
  except
    UpdateInfoTimer.Enabled := false;

  end;
  UpdateInfoTimer.Enabled := false;
  if (boolactWorkID = True) then
  begin
    if (sAdress = '') then
      sAdress := ClientModule.ServerMethods1Client.GetWorkerAddress(iactWorkID);
    Label6.TextSettings.FontColor := TAlphaColorRec.Green;
    Label2.TextSettings.FontColor := TAlphaColorRec.Green;
    Label2.Text := 'Online';
    Label6.Visible := True;
    // sPosition := ClientModule.ServerMethods1Client.GetWorkerPosition(iactWorkID);
    // for I := 0 to ComboBox2.Items.Count - 1 do
    // if ComboBox2.Items[I] = sPosition then
    // ComboBox2.ItemIndex := I;

    // sAdress := ClientModule.ServerMethods1Client.GetWorkerAddress(iactWorkID);
    if (sAdress = '') then
    begin
      ComboBox2.Items[0] := 'No Information';
      ComboBox2.ItemIndex := 0;
      ComboBox2.Enabled := false;
    end
    else
    begin
      if (boolAddpram = True) then
      begin
        // boolAddpram := False;
        ComboBox2.Items[0] := 'Adress';
        // ComboBox2.Items[1] := 'Adress';
        // ComboBox2.ItemIndex := 1;
        // ComboBox2.Enabled := true;

      end;

    end;
    // Memo1.Lines.Clear;
    // Memo1.Lines.Add(sAdress);

    // Edit2.Text :=
    // Memo1.Lines.Clear;
    // Memo1.Lines.Add(ClientModule.ServerMethods1Client.GetRideRequirement(iactWorkID));
   //   BoolMeetingEvent := true;//to avoid error by connection
    if (BoolMeetingEvent = false) then
    Begin
      FMeetingEvent := nil;
      try
        { TODO : add new field to decative display Event }

        FMeetingEvent := ClientModule.ServerMethods1Client.GetMeetingEvent
          (iactWorkID, 0, false);

        icount := FMeetingEvent.ID;
        if (icount > 0) then
        Begin
          BoolMeetingEvent := True;
        End;

      except

        raise Exception.Create('Connection Problem,request failed');

      end;

    End;


     DurationTimer.Enabled := True;
    if (BoolMeetingEvent = True) then
     gotoMeetingEvent;

  end
  else
  begin
    Memo1.Lines.Clear;
    Label6.Visible := false;
    Label6.TextSettings.FontColor := TAlphaColorRec.Red;
    Label2.TextSettings.FontColor := TAlphaColorRec.Red;
    Label2.Text := 'Offline';
    ComboBox2.ItemIndex := 0;
    ComboBox2.Items[0] := 'No Information Acess';
    ComboBox2.Enabled := false;
  end;

end;

procedure TfrmMain.gotoCalender;
begin
  try
    if Assigned(fraCalender) then
      fraCalender.Visible := True
    else
    begin
      fraCalender := TfraCalender.Create(frmMain);
      fraCalender.Parent := frmMain.pnlMain;
      fraCalender.Align := TAlignLayout.Contents;
      fraCalender.FirstShow;

    end;
  except

  end;
end;

procedure TfrmMain.gotoMeeting;
begin

  try
    if Assigned(fraMeeting) then
      fraMeeting.Visible := True
    else
    begin
      fraMeeting := TfraMeeting.Create(frmMain);
      fraMeeting.Parent := frmMain.pnlMain;
      fraMeeting.Align := TAlignLayout.Contents;
      fraMeeting.FirstShow;
    end;
  except

  end;
end;

procedure TfrmMain.gotoMeetingEvent;
begin

  try
    if Assigned(fraMeetingEvent) then
      fraMeetingEvent.Visible := True
    else
    begin
      fraMeetingEvent := TfraMeetingEvent.Create(frmMain);
      fraMeetingEvent.Parent := frmMain.pnlMain;
      fraMeetingEvent.Align := TAlignLayout.Contents;
      fraMeetingEvent.FirstShow;
    end;
  except

  end;
end;

procedure TfrmMain.btnCalenderClick(Sender: TObject);
begin
  // ClientModule.ServerMethods1Client.MoveRideToArchive(iactWorkID);
  // RideId := -1;
  // DurationTimer.Enabled := false;
  // TimeSec := 0;
  // Label6.Text := '00:00';
  // Memo1.Lines.Clear;
  // Edit2.Text := '';
  // ComboBox2.ItemIndex := -1;
  // ComboBox2.Enabled := false;

  gotoCalender;

  { TODO : Add more action using call methode }
end;

procedure TfrmMain.btnCrMeetingClick(Sender: TObject);
begin
  gotoMeeting
end;



procedure TfrmMain.Button1Click(Sender: TObject);
begin
  gotoMeetingEvent;
end;

procedure TfrmMain.ComboBox2Change(Sender: TObject);
begin
  if ((ComboBox2.ItemIndex = 0) and (ComboBox2.Items[0] = 'Adress')) then
  begin
    Memo1.Lines.Clear;
    Memo1.Lines.add(sAdress);

  end;

end;

procedure TfrmMain.ComboBox2Click(Sender: TObject);
begin
  if ((ComboBox2.ItemIndex = 0) and (ComboBox2.Items[0] = 'Adress')) then
  begin
    Memo1.Lines.Clear;
    Memo1.Lines.add(sAdress);

  end;
end;

procedure TfrmMain.DurationTimerTimer(Sender: TObject);
var
  mins, secs: string;
begin
  inc(TimeSec);

  if TimeSec mod 60 < 10 then
    secs := '0';
  secs := secs + IntToStr(TimeSec mod 60);

  mins := IntToStr(TimeSec div 60);

  Label6.Text := mins + ':' + secs;

end;

end.
