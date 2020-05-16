program M4Server;

uses
  FMX.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  Server in 'Server.pas' {frmServer},
  ServerMethodsServ in 'ServerMethodsServ.pas' {ServerMethods: TDSServerModule},
  ServerContainerServ in 'ServerContainerServ.pas' {ServerContainer1: TDataModule},
  ModuleSrv in 'Module\ModuleSrv.pas' {DMModuleSrv: TDataModule},
  BClsMeetingEvent in 'BClass\BClsMeetingEvent.pas',
  Report in 'VCLReport\Report.pas' {frmReport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='M4Server';
  Application.CreateForm(TfrmServer, frmServer);
  Application.CreateForm(TServerContainer1, ServerContainer1);
  Application.CreateForm(TDMModuleSrv, DMModuleSrv);
  Application.CreateForm(TfrmReport, frmReport);
  Application.Run;
end.

