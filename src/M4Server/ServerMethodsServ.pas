{ ============================================
  Software Name : 	M4Server
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }



// U need to follow 2 steps before u can essay Debugging the project
// 1. Paste your libmysql.dll full path to VendorLib property of FDPhysMysqlDriverLink1 Component.
// 2. Create Database in my case the database name was  "mywalid"  (by changing the name of the Database you have to change All StoredProcName Propertys)
// Enjoy it !!!

unit ServerMethodsServ;

interface

uses System.SysUtils, System.Classes, System.Json,
  DataSnap.DSProviderDataModuleAdapter,
  DataSnap.DSServer, DataSnap.DSAuth, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.PG,
  FireDAC.Phys.PGDef, FireDAC.FMXUI.Wait, Data.DB, FireDAC.Comp.Client,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt,
  FireDAC.Comp.Script,
  FireDAC.Comp.DataSet, DataSnap.Provider, FireDAC.VCLUI.Wait,
  FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  FireDAC.Comp.UI, Data.FireDACJSONReflect, Winapi.Windows, Winapi.Messages,
  System.Variants, BClsMeetingEvent, Data.Win.ADODB;

type
  TServerMethods = class(TDSServerModule)
    ConnectionMain: TFDConnection;
    ProcGetActive: TFDStoredProc;
    ProcGetAdress: TFDStoredProc;
    FncgetriderequirementProc: TFDStoredProc;
    ProcGetPosition: TFDStoredProc;
    qrWorkerInfo: TFDQuery;
    qrWorkerStatus: TFDQuery;
    DSPWorkerInfo: TDataSetProvider;
    DSPWorkerStatus: TDataSetProvider;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    ProcGetWorkID: TFDStoredProc;
    ProcUpWorkCalender: TFDStoredProc;
    ProcGetRaum: TFDStoredProc;
    FDTable1: TFDTable;
    FDTable1WorkIDGrp: TMemoField;
    FDTable1Raum: TStringField;
    FDTable1NameEvent: TStringField;
    FDTable1IntervalEvent: TMemoField;
    FDTable1DateEvent: TDateField;
    FDTable1Duration: TIntegerField;
    FDTable1DesEvent: TMemoField;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CreateScript;
    procedure DeleteScript;

    procedure CreateTabWorkerStatus;
    procedure CreateTabWorkerInfo;
    procedure CreateTabWorkerCalender;
    procedure CreateTabWorkerRaum;
    procedure CreateTabAcceptMeeting;
    procedure CreateTabMeetingEvent;

    procedure BuildTable;
    procedure FullTable;
    // -------------------------------------------------------//
    procedure CreateFuncGetWorkID;
    procedure CreateFuncGetPosition;
    procedure CreateFuncGetActive;
    procedure CreateFuncGetAdress;

    // -------------------------------------------------------//

    procedure CreateData_Table;
    procedure DeleteAllProcFunc;
    procedure CreateFunc1;

    procedure CreateStoredProc;
    procedure CreateFuncUpCalenderWorker;
    function GetPlanDay(AWorkID: integer): string;
    function GetDosOutput(CommandLine: string; Work: string = 'C:\'): string;
    function GetNameWorker(AWorkID: integer): string;
    function getALLParticipants(AString: string): string;
    function GetDabaseName: string;
    function AddMeetingReport(AWorkIDGrp, ARaum, ANameEvent, AIntervalEvent,
      ADesEvent: string; ADateEvent: TDate; ADuration: integer): word;
    function BoolAcceptMeeting(AIDWork: integer; ADateEvent: TDate;
      AAcceptDay: string): Boolean;

  public
    { Public declarations }
    function GetWorkerID(AName: string; AFirst: Boolean): integer;
    function GetWorkerPosition(AWorkID: integer): string;

    function GetWorkerRaum: string;
    function GetAllWorkerID: string;

    function GetWorkerActive(AWorkID: integer): Boolean;
    function GetWorkerAddress(AWorkID: integer): string;

    function SetMeetingEvent(AllIDGrp, ARaum, ANameEvent, AIntervalEvent,
      ADateEvent: string; ADuration: integer; ADesEvent: string): string;

    function GetMeetingEvent(AIDWork: integer; AIndex: integer;
      ABoolLimit: Boolean): TMeetingEvent;

    function UpdateWorkerCalender(AIDWorker: integer;
      AName, ADateDay, APlanDay: string): integer;

    function GetMeetingProposition(AIDWorker: integer; ARaum: string;
      ADayDate: string; AllIDGrp: string): string;

    function SetAcceptMeeting(AIDWork, ARaum, ANameEvent, ADateEvent,
      AAcceptDay: string): string;


    // -------------------------------------------------------//

    function GetRideRequirement(AName: integer): string;
    procedure ChangeRideStatus(AName: integer; StatusId: integer);
    procedure MoveRideToArchive(AName: integer);
    function GetReportMeeting(out size: int64): TStream;
  end;

  tMettingProp = record
    ID: integer;
    PlanDay: string;
  end;

implementation

{ %CLASSGROUP 'FMX.Controls.TControl' }

{$R *.dfm}

uses System.StrUtils, System.AnsiStrings, IniFiles, Report;

const
  cDirRoport = 'Report\';

var
  ResCMDList: TStringlist;
  INIPath: string;

function TServerMethods.AddMeetingReport(AWorkIDGrp, ARaum, ANameEvent,
  AIntervalEvent, ADesEvent: string; ADateEvent: TDate;
  ADuration: integer): word;
var
  sSqlCmd: string;
  ADOQuery: TADOQuery;
begin
  sSqlCmd := 'INSERT INTO ' + 'MeetingEvent' + ' (';
  sSqlCmd := sSqlCmd + 'WorkIDGrp' + ',' + 'Raum' + ',' + 'NameEvent';
  sSqlCmd := sSqlCmd + ',' + 'IntervalEvent' + ',' + 'Duration' + ',' +
    'DateEvent';
  sSqlCmd := sSqlCmd + ',' + 'DesEvent';
  sSqlCmd := sSqlCmd + ') VALUES (';

  sSqlCmd := sSqlCmd + '"' + AWorkIDGrp + '"';
  sSqlCmd := sSqlCmd + ',"' + ARaum + '"';
  sSqlCmd := sSqlCmd + ',"' + ANameEvent + '"';
  sSqlCmd := sSqlCmd + ',"' + AIntervalEvent + '"';
  sSqlCmd := sSqlCmd + ',"' + inttostr(ADuration) + '"';
  sSqlCmd := sSqlCmd + ',"' + datetostr(ADateEvent) + '"';
  sSqlCmd := sSqlCmd + ',"' + ADesEvent + '"';
  sSqlCmd := sSqlCmd + ')';
  try
    ADOQuery := TADOQuery.Create(nil);
    ADOQuery.ConnectionString :=
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=MeetingEvent.mdb';
    try
      ADOQuery.SQL.Clear;
      ADOQuery.SQL.Add(sSqlCmd);
      result := ADOQuery.ExecSQL;
    except
      result := 0;
    end;
  finally
    freeandnil(ADOQuery);
  end;

end;

function TServerMethods.GetReportMeeting(out size: int64): TStream;
var
  sFilePDF: string;
begin
  ForceDirectories(ExtractFilePath(ParamStr(0)) + cDirRoport);
  frmReport.RLReport1.Prepare;

  sFilePDF := ExtractFilePath(ParamStr(0)) + cDirRoport + 'MeetingReport.pdf';
  frmReport.RLPDFFilter1.ShowProgress := false;
  frmReport.RLPDFFilter1.FileName := sFilePDF;
  frmReport.RLPDFFilter1.FilterPages(frmReport.RLReport1.Pages);

  result := TFileStream.Create(sFilePDF, fmOpenRead or fmShareDenyNone);
  size := result.size;
  result.Position := 0;
end;

function TServerMethods.GetDabaseName: string;
var
  INI: TIniFile;
begin
  result := '';
  INI := TIniFile.Create(INIPath + ChangeFileExt(ExtractFileName(ParamStr(0)
    ), '.ini'));
  try
    result := INI.ReadString('Connection', 'DataBase', 'MyDataBase');

  finally
    INI.Free;
  end;
end;

procedure TServerMethods.CreateFuncGetActive;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;

  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'GetActive';
      SQL.Add('DROP FUNCTION IF EXISTS GetActive;');
      SQL.Add('DELIMITER $$');
      SQL.Add('create function GetActive (AWorkID INT) RETURNS Boolean');
      SQL.Add('BEGIN');
      SQL.Add('DECLARE BAct BOOLEAN DEFAULT FALSE;');
      SQL.Add('SELECT Active into BAct from tWorkerStatus where WorkID = AWorkID;');
      SQL.Add('RETURN BAct;');
      SQL.Add('END$$');
      SQL.Add('DELIMITER;');

    end;

  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    ProcGetActive.StoredProcName := GetDabaseName + '.GetActive';
    tmpScript.Free;
  end;

end;

procedure TServerMethods.CreateFuncGetAdress;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;

  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'GetAdress';
      SQL.Add('DROP FUNCTION IF EXISTS GetAdress;');
      SQL.Add('DELIMITER $$');
      SQL.Add('create function GetAdress (AWorkID INT) RETURNS VARCHAR (255)');
      SQL.Add('BEGIN');
      SQL.Add('DECLARE AdrW VARCHAR (255);');
      SQL.Add('SELECT Adress into AdrW from tWorkerInfo where WorkID = AWorkID;');
      SQL.Add('RETURN AdrW;');
      SQL.Add('END$$');
      SQL.Add('DELIMITER;');
    end;
  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    ProcGetAdress.StoredProcName := GetDabaseName + '.GetAdress';
    tmpScript.Free;

  end;

end;

procedure TServerMethods.CreateFuncGetPosition;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'GetPosition';
      SQL.Add('DROP FUNCTION IF EXISTS GetPosition;');
      SQL.Add('DELIMITER $$');
      SQL.Add('create function GetPosition(AWorkID INT) RETURNS varchar(40)');
      SQL.Add('BEGIN');
      SQL.Add('DECLARE PosW VARCHAR (40);');
      SQL.Add('SELECT Position into PosW from tWorkerStatus where WorkID = AWorkID;');
      SQL.Add('RETURN PosW;');
      SQL.Add('END$$');
      SQL.Add('DELIMITER;');

    end;

  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally

    ProcGetPosition.StoredProcName := GetDabaseName + '.GetPosition';
    tmpScript.Free;
  end;

end;

{$REGION 'Test'}
// Create FUNCTION my_func(in_id INT(11), value INT(11))RETURNS INT(11)DETERMINISTIC RETURN in_id IN (SELECT id FROM table_name WHERE id = value);

{$ENDREGION}

procedure TServerMethods.CreateFuncGetWorkID;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;

  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'GetWorkID';
      SQL.Add('DROP FUNCTION IF EXISTS GetWorkID;');
      SQL.Add('DELIMITER $$');
      SQL.Add('create function GetWorkID(AName VARCHAR(40)) RETURNS INT');
      SQL.Add('BEGIN');
      // SQL.Add('select ' +char(39)+'YOUR MESSAGE HERE'+char(39));
      SQL.Add('DECLARE IDC INT DEFAULT 0;');
      SQL.Add('SELECT WorkID into IDC from tWorkerInfo where Name = AName;');
      SQL.Add('RETURN IDC;');
      SQL.Add('END$$');
      SQL.Add('DELIMITER;');
    end;
  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    ProcGetWorkID.StoredProcName := GetDabaseName + '.GetWorkID';
    tmpScript.Free;
  end;

end;

procedure TServerMethods.CreateFuncUpCalenderWorker;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'UpCalenderWorker';
      SQL.Add('DROP FUNCTION IF EXISTS UpCalenderWorker;');
      SQL.Add('DELIMITER $$');
      SQL.Add('create function UpCalenderWorker(AWorkID INT,AName VARCHAR(40),ADateDay Date,APlanDay Text) RETURNS INT');
      SQL.Add('BEGIN');
      // SQL.Add('select ' +char(39)+'YOUR MESSAGE HERE'+char(39));
      SQL.Add('DECLARE IDC INT DEFAULT 0;');
      SQL.Add('INSERT INTO tWorkerCalender (WorkID,Name,DateDay,PlanDay) VALUES (AWorkID,AName,ADateDay,APlanDay) ON DUPLICATE KEY UPDATE PlanDay=APlanDay ;');

      SQL.Add('RETURN IDC;');
      SQL.Add('END$$');
      SQL.Add('DELIMITER;');
    end;
  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    ProcUpWorkCalender.StoredProcName := GetDabaseName + '.UpCalenderWorker';
    tmpScript.Free;
  end;

end;

procedure TServerMethods.CreateFunc1;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'fncGetDriverId';
      SQL.Add('DROP FUNCTION IF EXISTS GetDriverId;');
      SQL.Add('DELIMITER $$');
      SQL.Add('create function GetDriverId(AValue VARCHAR(40)) RETURNS INT');
      SQL.Add('BEGIN');
      // SQL.Add('DECLARE inb INT;');
      SQL.Add('SELECT COUNT(*) INTO inb FROM tRideStatus;');
      SQL.Add('RETURN inb;');
      SQL.Add('END$$');
      SQL.Add('DELIMITER;');
    end;
  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    // FncgetdriveridProc.StoredProcName := 'mywalid.fncGetDriverId';

  end;

end;

procedure TServerMethods.DeleteAllProcFunc;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'Delete';
      SQL.Add('DROP FUNCTION IF EXISTS GetWorkID;');
      SQL.Add('DROP FUNCTION IF EXISTS GetPosition;');
      SQL.Add('DROP FUNCTION IF EXISTS GetActive;');
    end;
  end;

  try
    tmpScript.ValidateAll;
    tmpScript.ExecuteAll;
  finally
    tmpScript.Free;

  end;

end;

procedure TServerMethods.CreateData_Table;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'Data_Table';
      SQL.Add('DROP TABLE IF EXISTS Data_Table ;');
      SQL.Add('create table Data_Table(');
      SQL.Add('Id INT NOT NULL AUTO_INCREMENT,');
      SQL.Add('VTYPE INT,');
      SQL.Add('KIND_ID INT,');
      SQL.Add('PRIMARY KEY ( Id )');
      SQL.Add(');');
    end;
  end;

  try
    try
      tmpScript.ValidateAll;
      tmpScript.ExecuteAll;
    except
      raise Exception.Create('Fehlermeldung');
    end;
  finally
    tmpScript.Free;

  end;

end;

procedure TServerMethods.CreateTabWorkerStatus;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'tWorkerStatus';
      // SQL.Add('DROP TABLE IF EXISTS tWorkerStatus ;');
      SQL.Add('CREATE TABLE IF NOT EXISTS tWorkerStatus(');
      SQL.Add('Id INT AUTO_INCREMENT PRIMARY KEY,');
      SQL.Add('WorkID INT NOT NULL,');
      SQL.Add('nbHour INT NOT NULL,');
      SQL.Add('Position VARCHAR(40) NOT NULL,');
      SQL.Add('Active BOOLEAN DEFAULT FALSE,');
      SQL.Add('UNIQUE(WorkID)');
      SQL.Add(');');
    end;
  end;

  try
    try
      tmpScript.ValidateAll;
      tmpScript.ExecuteAll;
    except
      raise Exception.Create('Fehlermeldung');

    end;
  finally
    tmpScript.Free;

  end;
end;

procedure TServerMethods.CreateTabMeetingEvent;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;
  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'tMeetingEvent';
      // SQL.Add('DROP TABLE IF EXISTS tWorkerInfo ;');
      SQL.Add('CREATE TABLE IF NOT EXISTS tMeetingEvent(');
      // SQL.Add('Id INT AUTO_INCREMENT PRIMARY KEY,');
      SQL.Add('WorkIDGrp TEXT NOT NULL,');
      SQL.Add('Raum VARCHAR(40) NOT NULL,');
      SQL.Add('NameEvent VARCHAR(255) NOT NULL,');
      SQL.Add('IntervalEvent TEXT NOT NULL,');
      SQL.Add('DateEvent DATE NOT NULL,');
      SQL.Add('Duration INT NOT NULL,');
      SQL.Add('DesEvent TEXT NOT NULL,');
      SQL.Add('PRIMARY KEY (NameEvent,DateEvent)');
      SQL.Add(');');
    end;
  end;

  try
    try
      tmpScript.ValidateAll;
      tmpScript.ExecuteAll;
    except
      raise Exception.Create('Fehlermeldung');

    end;
  finally
    tmpScript.Free;

  end;
end;

procedure TServerMethods.CreateTabWorkerCalender;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;

  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'tWorkerCalender';
      // SQL.Add('DROP TABLE IF EXISTS tWorkerCalender ;');
      SQL.Add('CREATE TABLE IF NOT EXISTS tWorkerCalender(');
      // SQL.Add('Id INT AUTO_INCREMENT PRIMARY KEY,');
      SQL.Add('WorkID INT NOT NULL,');
      SQL.Add('Name VARCHAR(40) NOT NULL,');
      SQL.Add('DateDay DATE NOT NULL,');
      SQL.Add('PlanDay TEXT NOT NULL,');
      SQL.Add('PRIMARY KEY (WorkID,DateDay)');

      SQL.Add(');');
    end;
  end;
  try
    try
      tmpScript.ValidateAll;
      tmpScript.ExecuteAll;
    except

      raise Exception.Create('Fehlermeldung');

    end;
  finally
    tmpScript.Free;
  end;

end;

procedure TServerMethods.CreateTabAcceptMeeting;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;

  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'tAcceptMeeting';
      // SQL.Add('DROP TABLE IF EXISTS tWorkerInfo ;');
      SQL.Add('CREATE TABLE IF NOT EXISTS tAcceptMeeting(');
      SQL.Add('WorkID INT NOT NULL,');
      SQL.Add('Raum VARCHAR(40) NOT NULL,');
      SQL.Add('NameEvent VARCHAR(255) NOT NULL,');
      SQL.Add('DateDay DATE NOT NULL,');
      SQL.Add('AcceptDay VARCHAR(255) NOT NULL,');
      SQL.Add('PRIMARY KEY (WorkID,DateDay,AcceptDay)');
      SQL.Add(');');
    end;
  end;

  try
    try
      tmpScript.ValidateAll;
      tmpScript.ExecuteAll;
    except

      raise Exception.Create('Fehlermeldung');

    end;
  finally
    tmpScript.Free;
  end;

end;

procedure TServerMethods.CreateTabWorkerInfo;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;

  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'tWorkerInfo';
      // SQL.Add('DROP TABLE IF EXISTS tWorkerInfo ;');
      SQL.Add('CREATE TABLE IF NOT EXISTS tWorkerInfo(');
      SQL.Add('Id INT AUTO_INCREMENT PRIMARY KEY,');
      SQL.Add('WorkID INT NOT NULL,');
      SQL.Add('Name VARCHAR(40) NOT NULL,');
      SQL.Add('Adress VARCHAR(255) NOT NULL,');
      SQL.Add('UNIQUE(WorkID)');
      SQL.Add(');');
    end;
  end;

  try
    try
      tmpScript.ValidateAll;
      tmpScript.ExecuteAll;
    except

      raise Exception.Create('Fehlermeldung');

    end;
  finally
    tmpScript.Free;
  end;

end;

procedure TServerMethods.CreateTabWorkerRaum;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;

  with tmpScript.SQLScripts do
  begin
    Clear;

    with Add do
    begin
      Name := 'tWorkerRaum';
      // SQL.Add('DROP TABLE IF EXISTS tWorkerInfo ;');
      SQL.Add('CREATE TABLE IF NOT EXISTS tWorkerRaum(');
      SQL.Add('Id INT AUTO_INCREMENT PRIMARY KEY,');
      SQL.Add('Name VARCHAR(40) NOT NULL,');
      SQL.Add('UNIQUE(Name)');
      SQL.Add(');');
    end;
  end;

  try
    try
      tmpScript.ValidateAll;
      tmpScript.ExecuteAll;
    except

      raise Exception.Create('Fehlermeldung');

    end;
  finally
    tmpScript.Free;
  end;

end;

procedure TServerMethods.FullTable;
var
  tmpScript: TFDScript;
begin
  tmpScript := TFDScript.Create(nil);
  tmpScript.Connection := ConnectionMain;
  with tmpScript.SQLScripts do
  begin
    Clear;
    with Add do
    begin
      SQL.Add('INSERT INTO tWorkerInfo (Name,WorkID,Adress)');
      SQL.Add('VALUES');
      SQL.Add('("alex",15,"2 Street Welcome")ON DUPLICATE KEY UPDATE WorkID=WorkID;');
      SQL.Add('INSERT INTO tWorkerInfo(Name,WorkID,Adress)');
      SQL.Add('VALUES');
      SQL.Add('("ali",16,"15 Street Welcome")ON DUPLICATE KEY UPDATE WorkID=WorkID;');
      SQL.Add('INSERT INTO tWorkerStatus(WorkID,Position,nbHour,Active)');
      SQL.Add('VALUES');
      SQL.Add('(15,"Developer",500,TRUE)ON DUPLICATE KEY UPDATE WorkID=WorkID;');
      SQL.Add('INSERT INTO tWorkerStatus(WorkID,Position,nbHour,Active)');
      SQL.Add('VALUES');
      SQL.Add('(16,"Engineer",400,FALSE)ON DUPLICATE KEY UPDATE WorkID=WorkID;');

      SQL.Add('INSERT INTO tWorkerraum(WorkID,Position,nbHour,Active)');
      SQL.Add('VALUES');
      SQL.Add('(16,"Engineer",400,FALSE)ON DUPLICATE KEY UPDATE WorkID=WorkID;');

    end;
  end;

  try
    try
      tmpScript.ValidateAll;
      tmpScript.ExecuteAll;
    except
      raise Exception.Create('Fehlermeldung');

    end;
  finally
    tmpScript.Free;
  end;
end;

procedure TServerMethods.CreateScript;
begin
  //
end;

procedure TServerMethods.CreateStoredProc;
begin
  CreateFuncGetWorkID;
  CreateFuncGetAdress;
  CreateFuncGetPosition;
  CreateFuncGetActive;
  CreateFuncUpCalenderWorker;

  // CreateFunc;
end;

procedure TServerMethods.DeleteScript;
begin
  DeleteAllProcFunc;
end;

procedure TServerMethods.BuildTable;
begin
  DeleteAllProcFunc;
  // ----------------------------
  CreateTabWorkerInfo;
  CreateTabWorkerStatus;
  CreateTabWorkerCalender;
  CreateTabWorkerRaum;
  CreateTabAcceptMeeting;
  CreateTabMeetingEvent;
  // ------------------------------------

  // FullTable;
  // FullTable;
  // ---------------------------------------
  CreateStoredProc;

end;

procedure TServerMethods.MoveRideToArchive(AName: integer);

var
  query: TFDQuery;

begin
  query := TFDQuery.Create(nil);
  query.Connection := ConnectionMain;

  query.SQL.Add('CALL public."prcMoveRideToArchive"(:ride_id);');
  query.Params[0].Value := AName;
  query.ExecSQL;
end;


// SQL.Add('Id INT AUTO_INCREMENT PRIMARY KEY,');
// SQL.Add('WorkID TEXT NOT NULL,');
// SQL.Add('Raum VARCHAR(40) NOT NULL,');
// SQL.Add('NameEvent VARCHAR(255) NOT NULL,');
// SQL.Add('DateDay DATE NOT NULL,');
// SQL.Add('AcceptDay TEXT NOT NULL');

function TServerMethods.BoolAcceptMeeting(AIDWork: integer; ADateEvent: TDate;
  AAcceptDay: string): Boolean;
var
  tmpQuery: TFDQuery;
begin
  result := false;
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := ConnectionMain; { +QuotedStr(ANameEvent)+ }
  tmpQuery.SQL.Clear;
  tmpQuery.SQL.Text :=
    'SELECT WorkID FROM tacceptmeeting WHERE AcceptDay=:Acc and DateDay=:Dat and WorkID=:IDW';
  tmpQuery.ParamByName('IDW').Asinteger := AIDWork;
  tmpQuery.ParamByName('Dat').AsDate := ADateEvent;
  tmpQuery.ParamByName('Acc').AsString := AAcceptDay;

  try
    try
      tmpQuery.Open;
      if (tmpQuery.RecordCount > 0) then
      begin
        result := true;
      end
      else
        result := false;
    except
      result := false;
      tmpQuery.Close;
      tmpQuery.Free;
      exit;
    end;

  finally
    tmpQuery.Close;
    tmpQuery.Free;
  end;
end;

function TServerMethods.SetAcceptMeeting(AIDWork, ARaum, ANameEvent, ADateEvent,
  AAcceptDay: string): string;
var
  tmpQuery: TFDQuery;
begin
  result := '';
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := ConnectionMain; { +QuotedStr(ANameEvent)+ }
  tmpQuery.SQL.Text :=
    'INSERT INTO tacceptmeeting (WorkID,Raum,NameEvent,DateDay,AcceptDay)VALUES(:IDW,:Rau,:Nam,:Dat,:Acc)ON DUPLICATE KEY UPDATE AcceptDay =:Acc,DateDay =:Dat,WorkID =:IDW';
  tmpQuery.ParamByName('IDW').AsString := AIDWork;
  tmpQuery.ParamByName('Rau').AsString := ARaum;
  tmpQuery.ParamByName('Nam').AsString := ANameEvent;
  tmpQuery.ParamByName('Dat').AsDate := StrToDate(ADateEvent);
  tmpQuery.ParamByName('Acc').AsString := AAcceptDay;

  try
    try
      tmpQuery.ExecSQL;
    except
      result := 'NO';
      tmpQuery.Close;
      tmpQuery.Free;
      exit;
    end;

  finally
    result := 'OK';
    tmpQuery.Close;
    tmpQuery.Free;
  end;
end;

function TServerMethods.SetMeetingEvent(AllIDGrp, ARaum, ANameEvent,
  AIntervalEvent, ADateEvent: string; ADuration: integer;
  ADesEvent: string): string;
var
  tmpQuery: TFDQuery;
begin
  result := '';
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := ConnectionMain; { +QuotedStr(ANameEvent)+ }
  tmpQuery.SQL.Text :=
    'INSERT INTO tmeetingevent (WorkIDGrp,Raum,NameEvent,IntervalEvent,DateEvent,Duration,DesEvent)VALUES(:IDG,:Rau,:Nam,:Int,:Dat,:Dur,:Des)ON DUPLICATE KEY UPDATE NameEvent =:Nam,DateEvent =:Dat';
  tmpQuery.ParamByName('IDG').AsString := AllIDGrp;
  tmpQuery.ParamByName('Rau').AsString := ARaum;
  tmpQuery.ParamByName('Nam').AsString := ANameEvent;
  tmpQuery.ParamByName('Int').AsString := AIntervalEvent;
  tmpQuery.ParamByName('Dat').AsDate := StrToDate(ADateEvent);
  tmpQuery.ParamByName('Dur').Asinteger := ADuration;
  tmpQuery.ParamByName('Des').AsString := ADesEvent;

  AddMeetingReport(AllIDGrp, ARaum, ANameEvent, AIntervalEvent, ADesEvent,
    StrToDate(ADateEvent), ADuration);

  try
    try
      tmpQuery.ExecSQL;
    except
      result := 'NO';
      tmpQuery.Close;
      tmpQuery.Free;
      exit;
    end;

  finally
    result := 'OK';
    tmpQuery.Close;
    tmpQuery.Free;
  end;
end;

procedure TServerMethods.ChangeRideStatus(AName: integer; StatusId: integer);
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := ConnectionMain;

  query.SQL.Add('CALL public."prcChangeRideStatus"(:ride_id, :status_id);');
  query.Params[0].Value := AName;
  query.Params[1].Value := StatusId;
  query.ExecSQL;
end;

function TServerMethods.GetWorkerID(AName: string; AFirst: Boolean): integer;
var
  query: TFDQuery;
  iResult: integer;

begin
  if (AFirst = true) then
  begin
    try
      BuildTable;
    except
      result := 0;
      exit;
    end;
  end;

  query := TFDQuery.Create(nil);
  query.Connection := ConnectionMain;
  query.SQL.Add('SELECT ' + GetDabaseName + '.GetWorkID(:Aname);');
  query.Params[0].Value := AName;
  try
    query.Open;
    iResult := query.FieldByName(GetDabaseName + '.GetWorkID(' +
      QuotedStr(AName) + ')').Asinteger;
    result := iResult;

  except
    result := 0;
    freeandnil(query);

  end;
  freeandnil(query);

  //
  // ProcGetWorkID.Params[0].value := AName;
  // Result := ProcGetWorkID.ExecFunc;
end;

function TServerMethods.UpdateWorkerCalender(AIDWorker: integer; AName: string;
  ADateDay: string; APlanDay: string): integer;
var
  query: TFDQuery;

begin
  query := TFDQuery.Create(nil);
  query.Connection := ConnectionMain;

  query.SQL.Add('SELECT ' + GetDabaseName +
    '.UpCalenderWorker(:AIDWorker,:AName,:ADateDay,:APlanDay);');

  query.Params[0].Value := AIDWorker;
  query.Params[1].Value := AName;
  query.Params[2].Value := StrToDate(ADateDay);
  query.Params[3].Value := APlanDay;

  try
    try
      query.Open;
    except
      result := 0;
    end;
    // Result := query.FieldByName('mywalid.UpCalenderWorker(' +
    // inttostr(AIDWorker) +','+ QuotedStr(AName) +','+ QuotedStr(ADateDay) +','+
    // QuotedStr(APlanDay) + ')').Asinteger;

  finally
    result := 1;
    freeandnil(query);

  end;

  // ProcUpWorkCalender.Params[0].value := AIDWorker;
  // ProcUpWorkCalender.Params[1].value := AName;
  // ProcUpWorkCalender.Params[2].value := StrToDate(ADateDay);
  // ProcUpWorkCalender.Params[3].value := APlanDay;
  // Result := ProcUpWorkCalender.ExecFunc;
end;

procedure TServerMethods.DSServerModuleCreate(Sender: TObject);
begin
  // link connection to StoredProc
  INIPath := ExtractFilePath(ParamStr(0));

  ConnectionMain.LoginPrompt := false;
  ConnectionMain.ConnectionDefName := 'MYWALID_MYSQL';
  ConnectionMain.Connected := false;
  // ConnectionMain.Connected := True;
  { Build DataSet }

end;

function TServerMethods.GetWorkerActive(AWorkID: integer): Boolean;
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := ConnectionMain;

  query.SQL.Add('SELECT ' + GetDabaseName + '.GetActive(:AWorkID);');

  query.Params[0].Value := AWorkID;
  query.Open;

  result := query.FieldByName(GetDabaseName + '.GetActive(' + inttostr(AWorkID)
    + ')').AsBoolean;
  freeandnil(query);

  // ProcGetActive.Params[0].value := AWorkID;
  // Result := ProcGetActive.ExecFunc;
end;

function TServerMethods.GetWorkerPosition(AWorkID: integer): string;
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := ConnectionMain;

  query.SQL.Add('SELECT ' + GetDabaseName + '.GetPosition(:AWorkID);');

  query.Params[0].Value := AWorkID;
  query.Open;

  result := query.FieldByName(GetDabaseName + '.GetPosition(' +
    inttostr(AWorkID) + ')').AsString;
  freeandnil(query);

  // ProcGetPosition.Params[0].value := AWorkID;
  // Result := ProcGetPosition.ExecFunc;
end;

function TServerMethods.GetWorkerRaum: string;
var
  tmpQuery: TFDQuery;
  sResult: string;
begin
  sResult := '';
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := ConnectionMain;
  tmpQuery.SQL.Text := 'SELECT Name FROM tWorkerRaum';
  tmpQuery.Open;
  try
    if (tmpQuery.RecordCount > 0) then
    begin
      while not(tmpQuery.Eof) do
      begin
        sResult := sResult + tmpQuery.FieldByName('Name').AsString + ';';
        tmpQuery.Next;
      end;
    end;
  finally
    result := sResult;
    tmpQuery.Free;
  end;

end;

function TServerMethods.GetWorkerAddress(AWorkID: integer): string;
var
  query: TFDQuery;
begin
  query := TFDQuery.Create(nil);
  query.Connection := ConnectionMain;

  query.SQL.Add('SELECT ' + GetDabaseName + '.GetAdress(:AWorkID);');

  query.Params[0].Value := AWorkID;
  query.Open;
  try
    result := query.FieldByName(GetDabaseName + '.GetAdress(' +
      inttostr(AWorkID) + ')').AsString;
  finally
    freeandnil(query);
  end;

  // ProcGetAdress.Params[0].value := AWorkID;
  // Result := ProcGetAdress.ExecFunc;
end;

function TServerMethods.GetAllWorkerID: string;
var
  tmpQueryName: TFDQuery;
  tmpQueryWorkID: TFDQuery;
  sResult: string;
  arrRes: array of array of string;
  sName, sID: string;
var
  JSONColor: TJSONObject;
  JSONArray: TJSONArray;
  JSONObject: TJSONObject;
  JSONValue: TJSONValue;

var
  Data: array of string;
  ActualLength: integer;

  procedure AddElement(const Str: string);
  begin
    Data[ActualLength] := Str;
    inc(ActualLength);
  end;

begin

  tmpQueryWorkID := TFDQuery.Create(nil);

  tmpQueryWorkID.Connection := ConnectionMain;
  tmpQueryWorkID.SQL.Text := 'SELECT WorkID,Name FROM tWorkerInfo';
  tmpQueryWorkID.Open();
  sResult := '';
  // JSONArray := TJSONArray.Create();
  if (tmpQueryWorkID.RecordCount > 0) then
  Begin
    tmpQueryWorkID.First;
    // JSONColor := TJSONObject.Create();

    while not(tmpQueryWorkID.Eof) do
    Begin
      sName := tmpQueryWorkID.FieldByName('Name').AsString;
      sID := inttostr(tmpQueryWorkID.FieldByName('WorkID').Asinteger);
      // JSONColor.AddPair('Name',sName );
      // JSONColor.AddPair('WorkID', sID);
      sResult := sResult + sID + ',' + sName + ';';
      // jsonArray.AddElement(jsonObject);

      // AddElement(sname+';'+sID);
      // SetLength(data, ActualLength);
      tmpQueryWorkID.Next;
    End;

    result := sResult;
  end
  else
    result := '';

  tmpQueryWorkID.Free;

end;

function TServerMethods.GetNameWorker(AWorkID: integer): string;
var
  tmpQuery: TFDQuery;

begin
  result := '';
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := ConnectionMain;
  tmpQuery.SQL.Text := 'SELECT Name FROM tworkerinfo where WorkID=:WorkID';
  tmpQuery.ParamByName('WorkID').Asinteger := AWorkID;
  tmpQuery.Open;
  try
    if (tmpQuery.RecordCount > 0) then
    begin

      result := tmpQuery.FieldByName('Name').AsString;

    end
    else
      result := '';
  finally
    tmpQuery.Close;
    tmpQuery.Free;
  end;
end;

function TServerMethods.GetPlanDay(AWorkID: integer): string;
var
  tmpQuery: TFDQuery;

begin
  result := '';
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := ConnectionMain;
  tmpQuery.SQL.Text :=
    'SELECT PlanDay FROM tWorkercalender where WorkID=:WorkID';
  tmpQuery.ParamByName('WorkID').Asinteger := AWorkID;
  tmpQuery.Open;
  try
    if (tmpQuery.RecordCount > 0) then
    begin

      result := tmpQuery.FieldByName('PlanDay').AsString;

    end
    else
      result := '';
  finally
    tmpQuery.Close;
    tmpQuery.Free;
  end;
end;

procedure Split(const Delimiter: Char; Input: string;
  const Strings: TStringlist);
begin
  Assert(Assigned(Strings));
  Strings.Clear;
  Strings.Delimiter := Delimiter;
  Strings.DelimitedText := Input;
end;

function TServerMethods.getALLParticipants(AString: string): string;
var
  sStrings: TStringlist;
  iID: integer;
  i: integer;
  res: string;
begin
  res := '( ';
  sStrings := TStringlist.Create;
  Split(',', AString, sStrings);

  for i := 0 to sStrings.Count - 1 do
  begin
    iID := StrToInt(sStrings[i]);
    res := res + GetNameWorker(iID);
    if (i < sStrings.Count - 1) then
      res := res + ' , ';

  end;

  try
    result := res + ' )';
  finally
    sStrings.Free;
  end;

end;

function TServerMethods.GetMeetingEvent(AIDWork: integer; AIndex: integer;
  ABoolLimit: Boolean): TMeetingEvent;
var
  tmpQuery: TFDQuery;

begin
  result := nil;
  tmpQuery := TFDQuery.Create(nil);
  tmpQuery.Connection := ConnectionMain;
  if (ABoolLimit = false) then
    tmpQuery.SQL.Text := 'SELECT POSITION("' + inttostr(AIDWork) +
      '" IN WorkIDGrp),WorkIDGrp,NameEvent,Duration,Raum,DesEvent,IntervalEvent,DateEvent FROM tmeetingevent where POSITION("'
      + inttostr(AIDWork) + '" IN WorkIDGrp)>0 and DateEvent>=current_date()'
  else
    tmpQuery.SQL.Text := 'SELECT POSITION("' + inttostr(AIDWork) +
      '" IN WorkIDGrp),WorkIDGrp,NameEvent,Duration,Raum,DesEvent,IntervalEvent,DateEvent FROM tmeetingevent where POSITION("'
      + inttostr(AIDWork) +
      '" IN WorkIDGrp)>0 and DateEvent>=current_date() LIMIT ' +
      inttostr(AIndex) + ',1';
  tmpQuery.Open;
  try
    if (tmpQuery.RecordCount > 0) then
    begin

      if (ABoolLimit = true) and
              (BoolAcceptMeeting(AIDWork, tmpQuery.FieldByName('DateEvent')
                      .AsDateTime, tmpQuery.FieldByName('IntervalEvent').AsString) = false)
      then
      Begin

        result := TMeetingEvent.Create;
        result.ID := AIDWork;
        result.Participants := getALLParticipants
          (tmpQuery.FieldByName('WorkIDGrp').AsString);
        result.DateEvent := tmpQuery.FieldByName('DateEvent').AsDateTime;
        result.DescriptionEvent := tmpQuery.FieldByName('DesEvent').AsString;
        result.IntervalEvent := tmpQuery.FieldByName('IntervalEvent').AsString;
        result.Duration := tmpQuery.FieldByName('Duration').Asinteger;
        result.NameEvent := tmpQuery.FieldByName('NameEvent').AsString;
        result.Raum := tmpQuery.FieldByName('Raum').AsString;

      End
      else
      begin
        result := TMeetingEvent.Create;
        result.ID := tmpQuery.RecordCount;
        result.Participants := '';
        result.DateEvent := now;
        result.DescriptionEvent := '';
        result.IntervalEvent := '';
        result.Duration := 0;
        result.NameEvent := '';
        result.Raum := '';

      end;

    end
    else
    begin
      result := TMeetingEvent.Create;
      result.ID := 0;
      result.Participants := '';
      result.DateEvent := now;
      result.DescriptionEvent := '';
      result.IntervalEvent := '';
      result.Duration := 0;
      result.NameEvent := '';
      result.Raum := '';

    end;
    // Result := nil;
  finally
    tmpQuery.Close;
    tmpQuery.Free;
  end;

end;

function TServerMethods.GetMeetingProposition(AIDWorker: integer;
  ARaum, ADayDate, AllIDGrp: string): string;
var
  sInput, sDir: string;
  sStrings: TStringlist;
  i: integer;
  sMe: string;
  ArrIDs: Array of tMettingProp;
  iID: integer;
  sPlan: string;
  askCMD: string;
  sres: string;
begin

  // SetLength(AllIDGrp, Length(AllIDGrp) - 1);

  if (AllIDGrp.IsEmpty) then
    exit;

  sStrings := TStringlist.Create;
  Split(',', AllIDGrp, sStrings);
  SetLength(ArrIDs, sStrings.Count);
  askCMD := ' ';
  askCMD := askCMD + inttostr(sStrings.Count) + ' ';
  for i := 0 to sStrings.Count - 1 do
  begin
    iID := StrToInt(sStrings[i]);
    ArrIDs[i].ID := iID;
    sPlan := GetPlanDay(iID);
    ArrIDs[i].PlanDay := sPlan;
    askCMD := askCMD + ArrIDs[i].PlanDay + ' ';
  end;

{$IFDEF UNICODE}
  sDir := GetCurrentDir + PathDelim + 'Calender' + PathDelim;
{$ELSE}
  sDir := gsAppPath + 'Calender' + PathDelim;
{$ENDIF}
  // test :=GetDosOutput('Calender2.exe',sDir);
  ResCMDList := TStringlist.Create;
  GetDosOutput('Calender.exe' + askCMD, sDir);
  // ResCMDList.Delimiter :=sLineBreak ;
  ResCMDList.QuoteChar := #0; // or

  sres := ResCMDList.DelimitedText;

  // Extract all ID Groupe

  // Calcule intersection time
  try
    result := Stringreplace(ResCMDList.Text, sLineBreak, '+', [rfReplaceAll]);;
  finally
    freeandnil(ResCMDList);
  end;

end;

function TServerMethods.GetRideRequirement(AName: integer): string;
begin
  FncgetriderequirementProc.Params[0].Value := AName;
  result := FncgetriderequirementProc.ExecFunc;
end;

function TServerMethods.GetDosOutput(CommandLine: string;
  Work: string = 'C:\'): string;
var
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array [0 .. 255] of AnsiChar;
  BytesRead: Cardinal;
  WorkDir: string;
  Handle: Boolean;
begin
  result := '';
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := true;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try
    with SI do
    begin
      FillChar(SI, SizeOf(SI), 0);
      cb := SizeOf(SI);
      dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
      wShowWindow := SW_HIDE;
      hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
      hStdOutput := StdOutPipeWrite;
      hStdError := StdOutPipeWrite;
    end;
    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine), nil, nil,
      true, 0, nil, PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil);
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            result := result + Buffer;

            ResCMDList.Add(result); // <<<<<<<<<<<<<<<<<<< output
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;



// var
// I: Integer;
//
// for I:= Low(SubInfo) to High(SubInfo) do
// SubInfo[I].Free;
// SetLength(SubInfo, 0);

end.
