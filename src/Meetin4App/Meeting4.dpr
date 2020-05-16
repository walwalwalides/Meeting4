program Meeting4;
{$UNDEF DELPHI_LLVM}

uses
  System.StartUpCopy,
  FMX.Forms,
  Calender in 'Frame\Calender.pas' {fraCalender} ,
  ClientClassesApp in 'ClientClassesApp.pas',
  ClientModuleApp in 'ClientModuleApp.pas' {ClientModule: TDataModule} ,
  Main in 'Main.pas' {frmMain} ,
  PassLock in 'Frame\PassLock.pas' {FraPassLock} ,
  uDM in 'Module\uDM.pas' {DM: TDataModule} ,
  uFontSetting in 'Source\uFontSetting.pas',
  uFunc in 'Source\uFunc.pas',
  uGoFrame in 'Source\uGoFrame.pas',
  uHelper in 'Source\uHelper.pas',
  uMain in 'Source\uMain.pas',
  uOpenUrl in 'Source\uOpenUrl.pas',
  uRest in 'Source\uRest.pas',
  uSign in 'Source\uSign.pas',
  uStartUp in 'Source\uStartUp.pas',
  Meeting in 'Frame\Meeting.pas' {fraMeeting: TFrame} ,
  dmMain in 'Module\dmMain.pas' {dataMain: TDataModule} ,
  DNLog.Client in 'UDP\DNLog.Client.pas',
  DNLog.Types in 'UDP\DNLog.Types.pas',
  Global in 'Source\Global.pas',
  About in 'About\About.pas' {frmAbout} ,
  BClsMeetingEvent in 'BClass\BClsMeetingEvent.pas',
  MeetingEvent in 'Frame\MeetingEvent.pas' {fraMeetingEvent: TFrame} ,
  uOpenUtils in 'AUtils\uOpenUtils.pas',
  Form.CustumMessage in 'Message\Form.CustumMessage.pas' {frmCustumMessage}
{$IFDEF ANDROID}
, Androidapi.JNI.Net.Wifi in 'AUtils\Androidapi.JNI.Net.Wifi.pas'
{$ENDIF}
;

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := true;
  Application.Initialize;
  Application.CreateForm(TClientModule, ClientModule);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TdataMain, dataMain);
  Application.CreateForm(TfrmCustumMessage, frmCustumMessage);
  Application.CreateForm(TfrmAbout, frmAbout);
  Application.Run;

end.
