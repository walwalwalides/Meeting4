{ ============================================
  Software Name : 	Meeting4
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit MeetingEvent;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.Controls.Presentation, FMX.Objects;

type
  TfraMeetingEvent = class(TFrame)
    grpBoxEvent: TGroupBox;
    cbEvt2: TCheckBox;
    cbEvt1: TCheckBox;
    cbEvt3: TCheckBox;
    cbEvt4: TCheckBox;
    cbEvt5: TCheckBox;
    Rectangle1: TRectangle;
    Rectangle2: TRectangle;
    btnSaveCalender: TButton;
    btnBack: TButton;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure btnBackClick(Sender: TObject);
    procedure btnSaveCalenderClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure FirstShow;
    procedure ReleaseFrame;
  end;

var
  fraMeetingEvent: TfraMeetingEvent;
  BoolVisibleCombox: Boolean = false;

implementation

{$R *.fmx}

uses uMain, BClsMeetingEvent, System.Generics.Collections, ClientModuleApp;

var
  FLstMeetingEvent: TList<TMeetingEvent>;
  { TfraMeetingEvent }

procedure TfraMeetingEvent.btnBackClick(Sender: TObject);
begin
  ReleaseFrame;
end;

procedure TfraMeetingEvent.btnSaveCalenderClick(Sender: TObject);
var
  sInput: string;
  sRaum: string;
  sNameEvent: string;
  sDateEvent: TDate;
  sIntervalEvent: string;
begin
  //

  if (cbEvt1.IsChecked = true) then
  Begin
    sRaum := FLstMeetingEvent.Items[0].Raum;
    sNameEvent := FLstMeetingEvent.Items[0].NameEvent;
    sDateEvent := FLstMeetingEvent.Items[0].DateEvent;
    sIntervalEvent := FLstMeetingEvent.Items[0].IntervalEvent;
    sInput := ClientModule.ServerMethods1Client.SetAcceptMeeting
      (WorkerID.ToString, sRaum, sNameEvent, DateToStr(sDateEvent),
      sIntervalEvent);
  end;

  ReleaseFrame;
end;

constructor TfraMeetingEvent.Create(AOwner: TComponent);
var
  I: Integer;
  n: Integer;

begin
  inherited;

  cbEvt1.visible := false;
  cbEvt2.visible := false;
  cbEvt3.visible := false;
  cbEvt4.visible := false;
  cbEvt5.visible := false;

  cbEvt1.Text := '';
  cbEvt1.WordWrap := true;
  cbEvt2.Text := '';
  cbEvt3.Text := '';
  cbEvt4.Text := '';
  cbEvt5.Text := '';

  FLstMeetingEvent := GetMeetingEvent();

  for I := 0 to FLstMeetingEvent.Count - 1 do
  begin
    case I of

      0:
        begin
          if (FLstMeetingEvent.Items[I].NameEvent <> '') then
          Begin
            cbEvt1.Text := DateToStr(FLstMeetingEvent.Items[I].DateEvent) +
              ' | ' + FLstMeetingEvent.Items[I].IntervalEvent + ' | ' +
              FLstMeetingEvent.Items[I].Raum + ' | ' + FLstMeetingEvent.Items[I]
              .NameEvent + ' | ' + FLstMeetingEvent.Items[I].Participants;

            cbEvt1.visible := true;
          End;
        end;
      1:
        begin
          if (FLstMeetingEvent.Items[I].NameEvent <> '') then
          Begin

            cbEvt2.Text := DateToStr(FLstMeetingEvent.Items[I].DateEvent) +
              ' | ' + FLstMeetingEvent.Items[I].IntervalEvent + ' | ' +
              FLstMeetingEvent.Items[I].Raum + ' | ' + FLstMeetingEvent.Items[I]
              .NameEvent + ' | ' + FLstMeetingEvent.Items[I].Participants;
            cbEvt2.visible := true;
          End;
        end;

      2:
        begin
          if (FLstMeetingEvent.Items[I].NameEvent <> '') then
          Begin

            cbEvt3.Text := DateToStr(FLstMeetingEvent.Items[I].DateEvent) +
              ' | ' + FLstMeetingEvent.Items[I].IntervalEvent + ' | ' +
              FLstMeetingEvent.Items[I].Raum + ' | ' + FLstMeetingEvent.Items[I]
              .NameEvent + ' | ' + FLstMeetingEvent.Items[I].Participants;
            cbEvt3.visible := true;
          End;
        end;

      3:
        begin
          if (FLstMeetingEvent.Items[I].NameEvent <> '') then
          Begin

            cbEvt4.Text := DateToStr(FLstMeetingEvent.Items[I].DateEvent) +
              ' | ' + FLstMeetingEvent.Items[I].IntervalEvent + ' | ' +
              FLstMeetingEvent.Items[I].Raum + ' | ' + FLstMeetingEvent.Items[I]
              .NameEvent + ' | ' + FLstMeetingEvent.Items[I].Participants;
            cbEvt4.visible := true;
          End;
        end;

      4:
        begin
          if (FLstMeetingEvent.Items[I].NameEvent <> '') then
          Begin

            cbEvt5.Text := DateToStr(FLstMeetingEvent.Items[I].DateEvent) +
              ' | ' + FLstMeetingEvent.Items[I].IntervalEvent + ' | ' +
              FLstMeetingEvent.Items[I].Raum + ' | ' + FLstMeetingEvent.Items[I]
              .NameEvent + ' | ' + FLstMeetingEvent.Items[I].Participants;
            cbEvt5.visible := true;
          End;
        end;
    end;

  end;

end;

destructor TfraMeetingEvent.Destroy;
begin
  //

  FreeAndNil(FLstMeetingEvent);
  inherited;
end;

procedure TfraMeetingEvent.FirstShow;
begin
  //

  BoolVisibleCombox := (cbEvt1.visible = true) or (cbEvt2.visible = true) or
    (cbEvt3.visible = true) or (cbEvt4.visible = true) or
    (cbEvt5.visible = true);
  if not(BoolVisibleCombox) then
    ReleaseFrame;

end;

procedure TfraMeetingEvent.ReleaseFrame;
begin
  //
{$IF DEFINED(IOS) or DEFINED(ANDROID)}
  DisposeOf;
{$ELSE}
  Free;
{$ENDIF}
  fraMeetingEvent := Nil;
end;

end.
