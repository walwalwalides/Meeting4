{ ============================================
  Software Name : 	M4Server
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit ModuleSrv;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI,Data.Win.ADODB,System.Variants,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.DataSet;

type
  TDMModuleSrv = class(TDataModule)
    ConnectionMain: TFDConnection;
    MySQLDriver: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDManager1: TFDManager;
    qrMeetingEvent: TFDQuery;
    procedure DataModuleCreate(Sender: TObject);
  private
    procedure CreateDabaseADO;
    function CreationBase(filename: string): string;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    function insertNewRaum(ARaumName: string): Boolean;
    function insertNewUser(AUsername: string; APosition: string;
      AWorkID: integer; AAdresse: string): Boolean;
  end;

var
  DMModuleSrv: TDMModuleSrv;

implementation
uses System.Win.ComObj;

{%CLASSGROUP 'FMX.Controls.TControl'}
{$R *.dfm}
{ TDMModuleSrv }



function TDMModuleSrv.CreationBase(filename: string): string;
var
  cat: OLEVariant;
begin
  result := '';
  try
    cat := CreateOleObject('ADOX.Catalog');
    cat.Create('Provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
      filename + ';');
    cat := NULL;
  except
    on E: Exception do
      result := E.Message;
  end;
end;

procedure TDMModuleSrv.CreateDabaseADO;
var
  // Deklaration String
  Name: string;
  ADOQuery: TADOQuery;
  Table1: string;
  Qstring1: string;
begin

  if FileExists('MeetingEvent.mdb') = False then
  begin
    Table1 := 'MeetingEvent';

    CreationBase('MeetingEvent.mdb');
    Qstring1 := 'CREATE TABLE   ' + Table1 + ' (' +
      'WorkIDGrp TEXT NOT NULL,' + 'Raum Text(40) NOT NULL,' +
      'NameEvent Text(255) NOT NULL,' + 'IntervalEvent TEXT NOT NULL,' +
      'DateEvent DATE NOT NULL,' + 'Duration Integer NOT NULL,' +
      'DesEvent TEXT NOT NULL)';

    try
      ADOQuery := TADOQuery.Create(nil);
      with ADOQuery do
      begin
        Close;
        ConnectionString := 'provider=Microsoft.Jet.OLEDB.4.0;Data Source=' +
          'MeetingEvent.mdb' + ';mode=readwrite;Persist Security Info=False' +
          ';Jet OLEDB:New Database Password="1234"';

        SQL.Add(Qstring1);

        ExecSQL;

      end;
    finally
      freeandnil(ADOQuery);
    end;
  end;
end;


procedure TDMModuleSrv.DataModuleCreate(Sender: TObject);
begin
  CreateDabaseADO;
end;




function TDMModuleSrv.insertNewRaum(ARaumName: string): Boolean;
var
  tmpQuery: TFDQuery;
begin
  result := false;
  try
    tmpQuery := TFDQuery.Create(nil);
    tmpQuery.Connection := ConnectionMain;
    tmpQuery.sql.Text := 'INSERT INTO tworkerraum (Name)VALUES(:Nam)ON DUPLICATE KEY UPDATE Name=Name';
    tmpQuery.ParamByName('Nam').AsString := ARaumName;
    try
      tmpQuery.ExecSQL;
    except
      FreeAndNil(tmpQuery);
      result := false;
      exit;
    end;

  finally
    tmpQuery.Close;
    FreeAndNil(tmpQuery);
    result := true;

  end;

end;

function TDMModuleSrv.insertNewUser(AUsername, APosition: string;
  AWorkID: integer; AAdresse: string): Boolean;
var
  tmpQuery: TFDQuery;
begin


 //insert value in tworkerstatus

  result := false;
  try
    tmpQuery := TFDQuery.Create(nil);
    tmpQuery.Connection := ConnectionMain;
    tmpQuery.sql.Text := 'INSERT INTO tworkerstatus (WorkID,nbHour,Position,Active)VALUES(:Wid,:NHr,:Pos,:Act)ON DUPLICATE KEY UPDATE WorkID=WorkID';
    tmpQuery.ParamByName('Wid').Asinteger := AWorkID;
    tmpQuery.ParamByName('NHr').asinteger := 0;
    tmpQuery.ParamByName('Pos').AsString := APosition;
    tmpQuery.ParamByName('Act').AsInteger := 0;

    try
      tmpQuery.ExecSQL;
    except
      FreeAndNil(tmpQuery);
      result := false;
      exit;
    end;

  finally
    tmpQuery.Close;
    FreeAndNil(tmpQuery);

  end;

 //insert value in tworkerinfo

  try
    tmpQuery := TFDQuery.Create(nil);
    tmpQuery.Connection := ConnectionMain;
    tmpQuery.sql.Text :=
      'INSERT INTO tworkerinfo (WorkID,Name,Adress)VALUES(:Wid,:Nam,:Adr)ON DUPLICATE KEY UPDATE WorkID=WorkID';
    tmpQuery.ParamByName('Wid').Asinteger := AWorkID;
    tmpQuery.ParamByName('Nam').AsString := AUsername;
    tmpQuery.ParamByName('Adr').AsString := AAdresse;

    try
      tmpQuery.ExecSQL;
    except
      FreeAndNil(tmpQuery);
      result := false;
      exit;
    end;

  finally
    tmpQuery.Close;
    FreeAndNil(tmpQuery);
    result := true;

  end;

end;

end.
