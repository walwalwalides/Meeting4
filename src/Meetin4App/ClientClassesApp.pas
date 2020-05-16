{ ============================================
  Software Name : 	Meeting4
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }

unit ClientClassesApp;

interface

uses System.JSON, Data.DBXCommon, Data.DBXClient, Data.DBXDataSnap,
  Data.DBXJSON, Datasnap.DSProxy, System.Classes, System.SysUtils, Data.DB,
  Data.SqlExpr, Data.DBXDBReaders, Data.DBXCDSReaders, Data.DBXJSONReflect,
  Datasnap.DSClientRest, Datasnap.DSProxyRest, BClsMeetingEvent;

type
  TServerMethods1Client = class(TDSAdminClient)
  private
    FGetWorkerIDCommand: TDBXCommand;
    FUpdateWorkerCalender: TDBXCommand;
    FGetWorkerActiveCommand: TDBXCommand;
    FGetWorkerPositionCommand: TDBXCommand;
    FGetWorkerAddressCommand: TDBXCommand;
    FGetWorkerRaumCommand: TDBXCommand;
    FGetRideRequirementCommand: TDBXCommand;
    FChangeRideStatusCommand: TDBXCommand;
    FMoveRideToArchiveCommand: TDBXCommand;
    FGetAllWorkerIDCommand: TDBXCommand;
    FMeetingProposition: TDBXCommand;
    FMeetingEventCommond: TDBXCommand;
    FTestCommand: TDBXCommand;
    FReportCommand: TDBXCommand;
    FAcceptMeetingCommond: TDBXCommand;

  public
    constructor Create(ADBXConnection: TDBXConnection); overload;
    constructor Create(ADBXConnection: TDBXConnection;
      AInstanceOwner: Boolean); overload;
    destructor Destroy; override;
    function GetWorkerID(AName: string; AFirst: Boolean = false): integer;
    function GetWorkerPosition(AWorkerID: integer): string;
    function GetWorkerAddress(AWorkerID: integer): string;
    function GetWorkerActive(AWorkerID: integer): Boolean;
    function GetWorkerRaum: string;
    function GetAllWorkerID: string;
    function UpdateWorkerCalender(AIDWorker: integer;
      AName, ADayDate, APlanDate: string): integer; // update worker calender
    function GetMeetingProposition(AIDWorker: integer; ARaum: string;
      ADayDate: string; AllIDGrp: string): string;
    function CrMeetingEvent(AllIDGrp: string; ARaum: string; ANameEvent: string;
      AIntervalEvent: string; ADateEvent: string; ADuration: integer;
      ADesEvent: string): string;
    function GetMeetingEvent(AIDWork: integer; AIndex: integer;
      ABoolLimit: Boolean): TMeetingEvent;
    function SetAcceptMeeting(AIDWork, ARaum, ANameEvent,
  ADateEvent,AAcceptDay: string): string;
    function GetReportMeeting(out size: Int64): TStream;

    function GetRideRequirement(AWorkerID: integer): string;
    procedure ChangeRideStatus(AWorkerID: integer; StatusId: integer);
    procedure MoveRideToArchive(AWorkerID: integer);
  end;



  // IDSRestCachedTUser = interface(IDSRestCachedObject<TUser>)
  // end;
  //
  // TDSRestCachedTUser = class(TDSRestCachedObject<TUser>, IDSRestCachedTUser,
  // IDSRestCachedCommand)
  // end;

  // const

  // TServerMethods_Test: array [0 .. 1] of TDBXParameterArray =
  // ((Name: 'AIDWorker'; Direction: 1; DBXType: 6; TypeName: 'integer'),
  // (Name: ''; Direction: 4; DBXType: 37; TypeName: 'TMeetingEvent'));

implementation

function TServerMethods1Client.GetReportMeeting(out size: Int64): TStream;
begin
  if FReportCommand = nil then
  begin
    FReportCommand := FDBXConnection.CreateCommand;
    FReportCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FReportCommand.Text := 'TServerMethods.GetReportMeeting';
    FReportCommand.Prepare;
  end;

//  FReportCommand.Parameters[0].Value.GetInt64(size);


  FReportCommand.ExecuteUpdate;
  size := FReportCommand.Parameters[0].Value.GetInt64;

  Result := FReportCommand.Parameters[1].Value.GetStream(FInstanceOwner);
end;

function TServerMethods1Client.GetMeetingEvent(AIDWork: integer;
  // Using Class Unit
  AIndex: integer; ABoolLimit: Boolean): TMeetingEvent;
var
  I: integer;
begin
  if FTestCommand = nil then
  begin
    FTestCommand := FDBXConnection.CreateCommand;
    FTestCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FTestCommand.Text := 'TServerMethods.GetMeetingEvent';
    FTestCommand.Prepare;
    // FTestCommand.CreateParameter(TServerMethods_Test);
  end;

  FTestCommand.Parameters[0].Value.SetInt32(AIDWork);
  FTestCommand.Parameters[1].Value.SetInt32(AIndex);
  FTestCommand.Parameters[2].Value.SetBoolean(ABoolLimit);


  // FTestCommand.ExecuteUpdate;
  // Result := TMeetingEvent(FUnMarshal.UnMarshal(FTestCommand.Parameters[1]
  // .Value.GetJSONValue(True)));

  /// /  FTestCommand.(ARequestFilter);
  if not FTestCommand.Parameters[0].Value.IsNull then
  begin
    FUnMarshal := TDBXClientCommand(FTestCommand.Parameters[0]
      .ConnectionHandler).GetJSONUnMarshaler;
    FTestCommand.ExecuteUpdate;
    try

      Result := TMeetingEvent(FUnMarshal.UnMarshal(FTestCommand.Parameters[3]
        .Value.GetJSONValue(True)));
      if FInstanceOwner then
        FTestCommand.FreeOnExecute(Result);
    finally
      FreeAndNil(FUnMarshal);
    end
  end
  else
    Result := nil;
end;

function TServerMethods1Client.GetWorkerID(AName: string;
  AFirst: Boolean = false): integer;
begin
  if FGetWorkerIDCommand = nil then
  begin
    FGetWorkerIDCommand := FDBXConnection.CreateCommand;
    FGetWorkerIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetWorkerIDCommand.Text := 'TServerMethods.GetWorkerID';
    FGetWorkerIDCommand.Prepare;
  end;
  FGetWorkerIDCommand.Parameters[0].Value.SetWideString(AName);
  FGetWorkerIDCommand.Parameters[1].Value.SetBoolean(AFirst);

  FGetWorkerIDCommand.ExecuteUpdate;
  Result := FGetWorkerIDCommand.Parameters[2].Value.GetInt32;
end;


function TServerMethods1Client.SetAcceptMeeting(AIDWork, ARaum, ANameEvent,
  ADateEvent,AAcceptDay: string): string;
begin
  if FAcceptMeetingCommond = nil then
  begin
    FAcceptMeetingCommond := FDBXConnection.CreateCommand;
    FAcceptMeetingCommond.CommandType := TDBXCommandTypes.DSServerMethod;
    FAcceptMeetingCommond.Text := 'TServerMethods.SetAcceptMeeting';
    FAcceptMeetingCommond.Prepare;
  end;
  FAcceptMeetingCommond.Parameters[0].Value.SetWideString(AIDWork);
  FAcceptMeetingCommond.Parameters[1].Value.SetWideString(ARaum);
  FAcceptMeetingCommond.Parameters[2].Value.SetWideString(ANameEvent);
  FAcceptMeetingCommond.Parameters[3].Value.SetWideString(ADateEvent);
  FAcceptMeetingCommond.Parameters[4].Value.SetWideString(AAcceptDay);

  FAcceptMeetingCommond.ExecuteUpdate;
  Result := FAcceptMeetingCommond.Parameters[5].Value.GetWideString;
end;

function TServerMethods1Client.CrMeetingEvent(AllIDGrp: string; ARaum: string;
  ANameEvent: string; AIntervalEvent: string; ADateEvent: string;
  ADuration: integer; ADesEvent: string): string;
begin
  if FMeetingEventCommond = nil then
  begin
    FMeetingEventCommond := FDBXConnection.CreateCommand;
    FMeetingEventCommond.CommandType := TDBXCommandTypes.DSServerMethod;
    FMeetingEventCommond.Text := 'TServerMethods.SetMeetingEvent';
    FMeetingEventCommond.Prepare;
  end;
  FMeetingEventCommond.Parameters[0].Value.SetWideString(AllIDGrp);
  FMeetingEventCommond.Parameters[1].Value.SetWideString(ARaum);
  FMeetingEventCommond.Parameters[2].Value.SetWideString(ANameEvent);
  FMeetingEventCommond.Parameters[3].Value.SetWideString(AIntervalEvent);
  FMeetingEventCommond.Parameters[4].Value.SetWideString(ADateEvent);
  FMeetingEventCommond.Parameters[5].Value.SetInt32(ADuration);
  FMeetingEventCommond.Parameters[6].Value.SetWideString(ADesEvent);

  FMeetingEventCommond.ExecuteUpdate;
  Result := FMeetingEventCommond.Parameters[7].Value.GetWideString;
end;

function TServerMethods1Client.GetMeetingProposition(AIDWorker: integer;
  ARaum: string; ADayDate: string; AllIDGrp: string): string;
begin
  if FMeetingProposition = nil then
  begin
    FMeetingProposition := FDBXConnection.CreateCommand;
    FMeetingProposition.CommandType := TDBXCommandTypes.DSServerMethod;
    FMeetingProposition.Text := 'TServerMethods.GetMeetingProposition';
    FMeetingProposition.Prepare;
  end;
  FMeetingProposition.Parameters[0].Value.SetInt32(AIDWorker);
  FMeetingProposition.Parameters[1].Value.SetWideString(ARaum);
  FMeetingProposition.Parameters[2].Value.SetWideString(ADayDate);
  FMeetingProposition.Parameters[3].Value.SetWideString(AllIDGrp);

  FMeetingProposition.ExecuteUpdate;
  Result := FMeetingProposition.Parameters[4].Value.GetWideString;
end;

function TServerMethods1Client.UpdateWorkerCalender(AIDWorker: integer;
  AName: string; ADayDate: string; APlanDate: string): integer;
begin
  if FUpdateWorkerCalender = nil then
  begin
    FUpdateWorkerCalender := FDBXConnection.CreateCommand;
    FUpdateWorkerCalender.CommandType := TDBXCommandTypes.DSServerMethod;
    FUpdateWorkerCalender.Text := 'TServerMethods.UpdateWorkerCalender';
    FUpdateWorkerCalender.Prepare;
  end;
  FUpdateWorkerCalender.Parameters[0].Value.SetInt32(AIDWorker);
  FUpdateWorkerCalender.Parameters[1].Value.SetWideString(AName);
  FUpdateWorkerCalender.Parameters[2].Value.SetWideString(ADayDate);
  FUpdateWorkerCalender.Parameters[3].Value.SetWideString(APlanDate);

  FUpdateWorkerCalender.ExecuteUpdate;
  Result := FUpdateWorkerCalender.Parameters[4].Value.GetInt32;
end;

function TServerMethods1Client.GetWorkerActive(AWorkerID: integer): Boolean;
begin
  if FGetWorkerActiveCommand = nil then
  begin
    FGetWorkerActiveCommand := FDBXConnection.CreateCommand;
    FGetWorkerActiveCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetWorkerActiveCommand.Text := 'TServerMethods.GetWorkerActive';
    FGetWorkerActiveCommand.Prepare;
  end;
  FGetWorkerActiveCommand.Parameters[0].Value.SetInt32(AWorkerID);
  FGetWorkerActiveCommand.ExecuteUpdate;
  Result := FGetWorkerActiveCommand.Parameters[1].Value.GetBoolean;
end;

function TServerMethods1Client.GetWorkerPosition(AWorkerID: integer): string;
begin
  if FGetWorkerPositionCommand = nil then
  begin
    FGetWorkerPositionCommand := FDBXConnection.CreateCommand;
    FGetWorkerPositionCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetWorkerPositionCommand.Text := 'TServerMethods.GetWorkerPosition';
    FGetWorkerPositionCommand.Prepare;
  end;
  FGetWorkerPositionCommand.Parameters[0].Value.SetInt32(AWorkerID);
  FGetWorkerPositionCommand.ExecuteUpdate;
  Result := FGetWorkerPositionCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetWorkerAddress(AWorkerID: integer): string;
begin
  if FGetWorkerAddressCommand = nil then
  begin
    FGetWorkerAddressCommand := FDBXConnection.CreateCommand;
    FGetWorkerAddressCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetWorkerAddressCommand.Text := 'TServerMethods.GetWorkerAddress';
    FGetWorkerAddressCommand.Prepare;
  end;
  FGetWorkerAddressCommand.Parameters[0].Value.SetInt32(AWorkerID);
  FGetWorkerAddressCommand.ExecuteUpdate;
  Result := FGetWorkerAddressCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetRideRequirement(AWorkerID: integer): string;
begin
  if FGetRideRequirementCommand = nil then
  begin
    FGetRideRequirementCommand := FDBXConnection.CreateCommand;
    FGetRideRequirementCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetRideRequirementCommand.Text := 'TServerMethods.GetRideRequirement';
    FGetRideRequirementCommand.Prepare;
  end;
  FGetRideRequirementCommand.Parameters[0].Value.SetInt32(AWorkerID);
  FGetRideRequirementCommand.ExecuteUpdate;
  Result := FGetRideRequirementCommand.Parameters[1].Value.GetWideString;
end;

function TServerMethods1Client.GetWorkerRaum: string;
begin
  if FGetWorkerRaumCommand = nil then
  begin
    FGetWorkerRaumCommand := FDBXConnection.CreateCommand;
    FGetWorkerRaumCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetWorkerRaumCommand.Text := 'TServerMethods.GetWorkerRaum';
    FGetWorkerRaumCommand.Prepare;
  end;
  // FGetWorkerRaumCommand.Parameters[0].Value.SetInt32(AWorkerID);
  FGetWorkerRaumCommand.ExecuteUpdate;
  Result := FGetWorkerRaumCommand.Parameters[0].Value.GetWideString;
end;

function TServerMethods1Client.GetAllWorkerID: string;
begin
  if FGetAllWorkerIDCommand = nil then
  begin
    FGetAllWorkerIDCommand := FDBXConnection.CreateCommand;
    FGetAllWorkerIDCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FGetAllWorkerIDCommand.Text := 'TServerMethods.GetAllWorkerID';
    FGetAllWorkerIDCommand.Prepare;
  end;
  // FGetAllWorkerIDCommand.Parameters[0].Value.SetInt32(AWorkerID);
  FGetAllWorkerIDCommand.ExecuteUpdate;
  Result := FGetAllWorkerIDCommand.Parameters[0].Value.GetWideString;
end;

procedure TServerMethods1Client.ChangeRideStatus(AWorkerID: integer;
  StatusId: integer);
begin
  if FChangeRideStatusCommand = nil then
  begin
    FChangeRideStatusCommand := FDBXConnection.CreateCommand;
    FChangeRideStatusCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FChangeRideStatusCommand.Text := 'TServerMethods.ChangeRideStatus';
    FChangeRideStatusCommand.Prepare;
  end;
  FChangeRideStatusCommand.Parameters[0].Value.SetInt32(AWorkerID);
  FChangeRideStatusCommand.Parameters[1].Value.SetInt32(StatusId);
  FChangeRideStatusCommand.ExecuteUpdate;
end;

procedure TServerMethods1Client.MoveRideToArchive(AWorkerID: integer);
begin
  if FMoveRideToArchiveCommand = nil then
  begin
    FMoveRideToArchiveCommand := FDBXConnection.CreateCommand;
    FMoveRideToArchiveCommand.CommandType := TDBXCommandTypes.DSServerMethod;
    FMoveRideToArchiveCommand.Text := 'TServerMethods.MoveRideToArchive';
    FMoveRideToArchiveCommand.Prepare;
  end;
  FMoveRideToArchiveCommand.Parameters[0].Value.SetInt32(AWorkerID);
  FMoveRideToArchiveCommand.ExecuteUpdate;
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection);
begin
  inherited Create(ADBXConnection);
end;

constructor TServerMethods1Client.Create(ADBXConnection: TDBXConnection;
  AInstanceOwner: Boolean);
begin
  inherited Create(ADBXConnection, AInstanceOwner);
end;

destructor TServerMethods1Client.Destroy;
begin
  FGetWorkerIDCommand.DisposeOf;
  FGetWorkerActiveCommand.DisposeOf;
  FGetWorkerPositionCommand.DisposeOf;
  FGetWorkerAddressCommand.DisposeOf;
  FUpdateWorkerCalender.DisposeOf;
  FGetWorkerRaumCommand.DisposeOf;
  FGetAllWorkerIDCommand.DisposeOf;
  FMeetingProposition.DisposeOf;
  FMeetingEventCommond.DisposeOf;
  FTestCommand.DisposeOf;
  FReportCommand.DisposeOf;
  FAcceptMeetingCommond.DisposeOf;
  // ---------------------------------------- //

  FGetRideRequirementCommand.DisposeOf;

  FChangeRideStatusCommand.DisposeOf;
  FMoveRideToArchiveCommand.DisposeOf;
  inherited;
end;

end.
