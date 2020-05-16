{ ============================================
  Software Name : 	M4Server
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Report;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RLReport, Data.DB, RLFilters,
  RLPDFFilter, Data.Win.ADODB, frxClass;

type
  TfrmReport = class(TForm)
    RLReport1: TRLReport;
    DataSource1: TDataSource;
    RLBand1: TRLBand;
    RLBand2: TRLBand;
    RLBand3: TRLBand;
    RLBand4: TRLBand;
    RLSystemInfo1: TRLSystemInfo;
    RLLabel1: TRLLabel;
    RLSystemInfo2: TRLSystemInfo;
    RLSystemInfo3: TRLSystemInfo;
    RLSystemInfo4: TRLSystemInfo;
    RLDBText1: TRLDBText;
    RLDBText2: TRLDBText;
    RLDBText3: TRLDBText;
    RLDBText4: TRLDBText;
    RLDBText5: TRLDBText;
    RLLabel2: TRLLabel;
    RLLabel3: TRLLabel;
    RLLabel4: TRLLabel;
    RLLabel5: TRLLabel;
    RLLabel6: TRLLabel;
    RLPDFFilter1: TRLPDFFilter;
    frxReport1: TfrxReport;
    frxUserDataSet1: TfrxUserDataSet;
    ADOTable1: TADOTable;
    ADOTable1WorkIDGrp: TWideMemoField;
    ADOTable1Raum: TWideStringField;
    ADOTable1NameEvent: TWideStringField;
    ADOTable1IntervalEvent: TWideMemoField;
    ADOTable1DateEvent: TDateTimeField;
    ADOTable1Duration: TIntegerField;
    ADOTable1DesEvent: TWideMemoField;
    RLDBText6: TRLDBText;
    RLLabel7: TRLLabel;
    procedure RLReport1BeforePrint(Sender: TObject; var PrintIt: Boolean);
    procedure frxUserDataSet1First(Sender: TObject);
    procedure frxUserDataSet1GetValue(const VarName: string;
      var Value: Variant);
    procedure frxUserDataSet1Next(Sender: TObject);
    procedure frxUserDataSet1Prior(Sender: TObject);
    procedure frxUserDataSet1CheckEOF(Sender: TObject; var Eof: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    Procedure CreateMeetingReport;
  end;

var
  frmReport: TfrmReport;

implementation

uses
  ModuleSrv;

{$R *.dfm}


Procedure TfrmReport.RLReport1BeforePrint(Sender: TObject;
  var PrintIt: Boolean);
begin
  DMModuleSrv.qrMeetingEvent.Close;
  DMModuleSrv.qrMeetingEvent.Open();
end;



procedure TfrmReport.frxUserDataSet1CheckEOF(Sender: TObject;
  var Eof: Boolean);
begin
  Eof := ADOTable1.Eof;
end;



Procedure TfrmReport.frxUserDataSet1First(Sender: TObject);
begin
  ADOTable1.First;
end;

procedure TfrmReport.frxUserDataSet1Next(Sender: TObject);
begin
  ADOTable1.Next;
end;



Procedure TfrmReport.frxUserDataSet1Prior(Sender: TObject);
begin
  ADOTable1.Prior;
end;

procedure TfrmReport.frxUserDataSet1GetValue(const VarName: String;
  var Value: Variant);
begin
  if VarName = 'WorkIDGrp' then
    Value := ADOTable1.FieldByName('WorkIDGrp').AsString
  else if VarName = 'Raum' then
    Value := ADOTable1.FieldByName('Raum').AsString
  else if VarName = 'NameEvent' then
    Value := ADOTable1.FieldByName('NameEvent').AsString
  else if VarName = 'IntervalEvent' then
    Value := ADOTable1.FieldByName('IntervalEvent').AsString
  else if VarName = 'DateEvent' then
    Value := ADOTable1.FieldByName('DateEvent').AsDateTime
  else if VarName = 'Duration' then
    Value := ADOTable1.FieldByName('Duration').AsInteger
  else if VarName = 'DesEvent' then
    Value := ADOTable1.FieldByName('DesEvent').AsString;
end;




Procedure TfrmReport.CreateMeetingReport;
Begin
  frxUserDataSet1.Fields.Clear;
  frxUserDataSet1.Fields.Add('WorkIDGrp');
  frxUserDataSet1.Fields.Add('Raum');
  frxUserDataSet1.Fields.Add('NameEvent');
  frxUserDataSet1.Fields.Add('IntervalEvent');
  frxUserDataSet1.Fields.Add('DateEvent');
  frxUserDataSet1.Fields.Add('Duration');
  frxUserDataSet1.Fields.Add('DesEvent');
  ADOTable1.Active := False;
{$IFNDEF CPUX64}
  ADOTable1.ConnectionString :=
    'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=MeetingEvent.mdb';
{$ELSE}
  ADOTable1.ConnectionString :=
    'Provider=Microsoft.ACE.OLEDB.12.0;Data Source=MeetingEvent.mdb';
{$ENDIF}
  ADOTable1.Active := True;
  frxReport1.PrepareReport(True);
  // frxPDFExport1.ExportToFile(frxReport1, 'MeetingReport', TgtxOutputFormat.PDF);

End;


END.
