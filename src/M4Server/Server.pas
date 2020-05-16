{ ============================================
  Software Name : 	M4Server
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit Server;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Types,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.TabControl, FMX.Ani, FMX.Effects,
  FMX.Edit, FMX.EditBox, FMX.SpinBox,
  FMX.Objects, FMX.Layouts, System.ImageList, FMX.ImgList, ElComponent,
  ElBaseComp, ElTray;

type
  TfrmServer = class(TForm)
    lblDTServ: TLabel;
    TabCtrlServer: TTabControl;
    tabSetting: TTabItem;
    tabUser: TTabItem;
    LaySetting: TLayout;
    Rectangle1: TRectangle;
    imgSettingCancel: TImage;
    lbl1: TLabel;
    Layout1: TLayout;
    lbl7: TLabel;
    lblPort: TLabel;
    SpinBoxPort: TSpinBox;
    edtIP: TEdit;
    lblIP: TLabel;
    imgTest: TImage;
    imgResultTest: TImage;
    Layout2: TLayout;
    ChBox2: TCheckBox;
    statbrConnection: TStatusBar;
    lblDate: TLabel;
    lblTime: TLabel;
    lblDescription: TLabel;
    BevelEffect1: TBevelEffect;
    SpinBoxMonitor: TSpinBox;
    lblScreen: TLabel;
    imgOkSetting: TImage;
    animSetting: TFloatAnimation;
    Layout3: TLayout;
    ilCount: TImageList;
    Image1: TImage;
    edtDataBase: TEdit;
    lblDataBase: TLabel;
    lblDLL: TLabel;
    edtDLLLIB: TEdit;
    btnSelectDLL: TButton;
    edtPassword: TEdit;
    lblPassword: TLabel;
    edtUsername: TEdit;
    lblUsername: TLabel;
    OpDlgDLL: TOpenDialog;
    ElTrayIcon1: TElTrayIcon;
    TabRaum: TTabItem;
    Rectangle2: TRectangle;
    lbltitelraum: TLabel;
    Layout4: TLayout;
    lblAddRaum: TLabel;
    edtRaumName: TEdit;
    lblRaumName: TLabel;
    imgRaumAddStauts: TImage;
    CheckBox1: TCheckBox;
    Layout5: TLayout;
    StatusBar1: TStatusBar;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    BevelEffect2: TBevelEffect;
    Layout6: TLayout;
    imgOKRaum: TImage;
    Rectangle3: TRectangle;
    lblTitelUser: TLabel;
    Layout7: TLayout;
    Label14: TLabel;
    lblWorkID: TLabel;
    SpinBoxWorkID: TSpinBox;
    edtNameUser: TEdit;
    lblNameUser: TLabel;
    imgUserAddStauts: TImage;
    CheckBox2: TCheckBox;
    lblAdresse: TLabel;
    edtAdresseUser: TEdit;
    lblPosition: TLabel;
    edtPositionUser: TEdit;
    Layout8: TLayout;
    StatusBar2: TStatusBar;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    BevelEffect3: TBevelEffect;
    Layout9: TLayout;
    imgOKUser: TImage;
    imgUserCancel: TImage;
    imgCancelRaum: TImage;
    procedure FormCreate(Sender: TObject);
    procedure imgTestClick(Sender: TObject);
    procedure btnSelectDLLClick(Sender: TObject);
    procedure imgOkSettingClick(Sender: TObject);
    procedure ElTrayIcon1DblClick(Sender: TObject);
    procedure imgOKRaumClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; var KeyChar: Char;
      Shift: TShiftState);
    procedure imgOKUserClick(Sender: TObject);
  private
    function GetIP: String;
    function ReadConnecParametere: Boolean;
    procedure SaveConnecParametere;
    procedure SetParametertoConnection;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmServer: TfrmServer;

implementation

uses IniFiles, ModuleSrv, System.IOUtils, IdStack, System.UITypes,
  FireDAC.Phys.IBDef, FireDAC.Phys.IBWrapper, vcl.Forms;

var
  INIPath: string;

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}
  // MySQLDriver

function TfrmServer.GetIP: String;
begin
  TIdStack.IncUsage;
  try
    Result := GStack.LocalAddress;
  finally
    TIdStack.DecUsage;
  end;
end;





function TfrmServer.ReadConnecParametere: Boolean;
var
  INI: TIniFile;
  LIPAdresse: string;
  LPort: string;
  LDLLLib: string;
  LDataBase: string;
  LUsername, LPassword: string;
begin
  Result := false;
  INI := TIniFile.Create(INIPath + ChangeFileExt(ExtractFileName(ParamStr(0)
    ), '.ini'));
  try
    LIPAdresse := INI.ReadString('Connection', 'IP-Adresse', GetIP);
    LPort := INI.ReadString('Connection', 'Port', '3306');
    LDataBase := INI.ReadString('Connection', 'DataBase', 'MyDataBase');
    LDLLLib := INI.ReadString('Connection', 'DLLLIB', '');
    LUsername := INI.ReadString('Connection', 'Username', 'Admin');
    LPassword := INI.ReadString('Connection', 'Password', '1234');

    edtIP.Text := LIPAdresse;
    SpinBoxPort.Text := LPort;
    edtDataBase.Text := LDataBase;
    edtDLLLIB.Text := LDLLLib;
    edtUsername.Text := LUsername;
    edtPassword.Text := LPassword;

    Result := True;

    // INI.ReadBool('LastFile', 'Send', false);
    // INI.ReadString('LastFile', 'Filetype', LFileInformation.FileType);
    // INI.readString('LastFile', 'Filename', ExtractFileName(LFileName));

  finally
    INI.Free;
  end;
end;

// C:\AllServer\mysql\lib\libmysql.dll
procedure TfrmServer.btnSelectDLLClick(Sender: TObject);
var
  stemp: string;
begin
  //
  stemp := '';
  if ((edtDLLLIB.Text <> '') and FileExists(edtDLLLIB.Text)) then
    OpDlgDLL.InitialDir := ExtractFileDir(edtDLLLIB.Text);

  if OpDlgDLL.Execute then
  begin
    stemp := OpDlgDLL.FileName;
    //
    if (stemp <> '') and (ExtractFileName(stemp) = 'libmysql.dll') then
    begin
      // sNewDLLPath := FileOpenDLL.FileName;
      // pathLibrary.Caption := sNewDLLPath;
      edtDLLLIB.Text := stemp

      // if MessageDlg('Do you wanna save the new DLL path ?', mtConfirmation,
      // [mbYes, mbNo], 0) = mrYes then
      // begin
      //
      // end;

    end
    else
    begin
      if (ExtractFileName(stemp) <> 'libmysql.dll') then
        MessageDlg('U muss choice  ''libmysql.dll'' .', TMsgDlgType.mtWarning,
          [TMsgDlgBtn.mbOK], 0);

    end;

  end;

end;

procedure TfrmServer.ElTrayIcon1DblClick(Sender: TObject);
begin
  self.Visible := True;
end;

procedure TfrmServer.FormCreate(Sender: TObject);
begin
  lblScreen.Visible := false;
  SpinBoxMonitor.Visible := false;
  // Clear StatusBar

  Label10.Visible := false;
  Label11.Visible := false;
  Label12.Visible := false;

  // --------------------------------//
  Label22.Visible := false;
  Label23.Visible := false;
  Label24.Visible := false;

  imgUserAddStauts.Visible := false;
  imgRaumAddStauts.Visible := false;

  lblDate.Text := '';
  lblTime.Text := '';
  lblDescription.Text := '';

  TabCtrlServer.TabIndex := 0;

  // -----------------------------------------//
  OpDlgDLL.Filter := 'Dynamic Link Library (*.dll)|*.dll';
  imgResultTest.Visible := false;
  INIPath := ExtractFilePath(ParamStr(0));
  ReadConnecParametere;
  Caption := Application.Title;
  Position := TFormPosition.MainFormCenter;
  lblDTServ.Position.x := 3;
  lblDTServ.Position.y := 3;
  lblDTServ.StyledSettings := [TStyledSetting.Family, TStyledSetting.Size
  { , TStyledSetting.FontColor } ];
  // ----------------------------------------------------------------------------------------------
  // lblDTServ.TextSettings.Font.Style := [TFontStyle.fsBold];
  lblDTServ.TextSettings.Font.Size := 25;
  lblDTServ.TextSettings.FontColor := $FF5EB3FE;
  // lblDTServ.TextSettings.Font.Style := lblDTServ.TextSettings.Font.Style + [TFontStyle.fsBold];
  lblDTServ.Text := 'Starting Time : ' + DateTimeToStr(Now);

  // ----------------------------------------------
  edtRaumName.MaxLength := 40;

end;

procedure TfrmServer.FormKeyDown(Sender: TObject; var Key: Word;
  var KeyChar: Char; Shift: TShiftState);
begin
  if (Key = ord(13)) then
  begin

    case TabCtrlServer.TabIndex of

      0:
        imgOkSettingClick(nil);
      1:
        imgOKUserClick(nil);
      2:
        imgOKRaumClick(nil);

    end;

  end;

end;

procedure TfrmServer.SaveConnecParametere;
var
  INI: TIniFile;
  LIPAdresse, LDataBase: string;
  LPort, LDLLLib: string;
  LUsername, LPassword: string;
begin
  INI := TIniFile.Create(INIPath + ChangeFileExt(ExtractFileName(ParamStr(0)
    ), '.ini'));
  try
    LIPAdresse := edtIP.Text;
    LPort := SpinBoxPort.Text;
    LDataBase := edtDataBase.Text;
    LDLLLib := edtDLLLIB.Text;
    LUsername := edtUsername.Text;
    LPassword := edtPassword.Text;

    INI.WriteString('Connection', 'IP-Adresse', LIPAdresse);
    INI.WriteString('Connection', 'Port', LPort);
    INI.WriteString('Connection', 'DLLLib', LDLLLib);
    INI.WriteString('Connection', 'DataBase', LDataBase);
    INI.WriteString('Connection', 'Username', LUsername);
    INI.WriteString('Connection', 'Password', LPassword);

  finally
    INI.Free;
  end;
end;

procedure TfrmServer.SetParametertoConnection;
Begin
  DMModuleSrv.ConnectionMain.Connected := false;
  DMModuleSrv.ConnectionMain.Params.Clear;
  DMModuleSrv.ConnectionMain.DriverName := 'MySQL';

  with DMModuleSrv.ConnectionMain.Params do
  begin

    // Protocol := ipTCPIP;
    Add('Server=' + edtIP.Text);
    Add('Database=' + edtDataBase.Text);
    Add('User_name=' + edtUsername.Text);
    Add('Password=' + edtPassword.Text);
    Add('Port=' + IntToStr(Round(SpinBoxPort.Value)));
  end;
  DMModuleSrv.MySQLDriver.VendorLib := edtDLLLIB.Text;

  DMModuleSrv.ConnectionMain.ExecSQL('CREATE DATABASE IF NOT EXISTS ' +
    edtDataBase.Text + ';');
  // DMModuleSrv.ConnectionMain.ExecSQL('CREATE USER '+QuotedStr(edtUsername.Text)+'@'+QuotedStr(edtIP.Text)+' IDENTIFIED BY '+QuotedStr(edtPassword.Text)+';');
  DMModuleSrv.ConnectionMain.ExecSQL
    ('SET GLOBAL log_bin_trust_function_creators = 1;');

end;

procedure TfrmServer.imgOKRaumClick(Sender: TObject);
var
  BoolInput, BoolOuput: Boolean;
begin
  imgRaumAddStauts.Visible := false;
  BoolInput := false;
  BoolInput := edtRaumName.Text <> '';

  if (BoolInput = True) then
    BoolOuput := DMModuleSrv.InsertNewRaum(edtRaumName.Text)
  else
    exit;

  if (BoolOuput = True) then
  begin
    imgRaumAddStauts.Visible := True;
    MessageDlg('New raum added !', TMsgDlgType.mtInformation,
      [TMsgDlgBtn.mbOK], 0)
  end
  else
    MessageDlg('Cant''t add a new raum', TMsgDlgType.mtError,
      [TMsgDlgBtn.mbOK], 0);

end;

procedure TfrmServer.imgOkSettingClick(Sender: TObject);
begin

  try
    SetParametertoConnection;

    SaveConnecParametere;
  finally
    MessageDlg('new parameter saved.', TMsgDlgType.mtInformation,
      [TMsgDlgBtn.mbOK], 0);
  end;

end;

procedure TfrmServer.imgOKUserClick(Sender: TObject);
var
  BoolInput, BoolOuput: Boolean;
begin
  imgUserAddStauts.Visible := false;

  BoolInput := (edtNameUser.Text <> '') and (SpinBoxWorkID.Value > 0) and
    (edtPositionUser.Text <> '') and (edtAdresseUser.Text <> '');

  if (BoolInput = True) then
    BoolOuput := DMModuleSrv.insertNewUser(edtNameUser.Text,
      edtPositionUser.Text, Round(SpinBoxWorkID.Value), edtAdresseUser.Text)
  else
    exit;
  if (BoolOuput = True) then
  Begin
    imgUserAddStauts.Visible := True;
    MessageDlg('New user added !', TMsgDlgType.mtInformation,
      [TMsgDlgBtn.mbOK], 0)
  End
  else
    MessageDlg('Cant''t add a new user ', TMsgDlgType.mtError,
      [TMsgDlgBtn.mbOK], 0);
end;

procedure TfrmServer.imgTestClick(Sender: TObject);
var
  boolError: Boolean;
begin

  lblDate.Text := '';
  lblTime.Text := '';
  lblDescription.Text := '';
  imgResultTest.Visible := false;

  SetParametertoConnection;

  boolError := false;
  try
    try
      SetCursor(vcl.Forms.Screen.cursors[crHourGlass]);
      DMModuleSrv.ConnectionMain.Connected := True;
    except
      on E: Exception do
      Begin
        // ErrorDialog(, E.HelpContext);
        boolError := True;
        // ShowMessage('NO');
        lblDate.Text := DateToStr(Now);
        lblTime.Text := TimeToStr(Now);
        lblDescription.Text := E.Message;
        imgResultTest.Bitmap.Assign(ilCount.Bitmap(Image1.Size.Size, 2));
        imgResultTest.Visible := True;
      End;

    end;
  finally
    if not(boolError) then
    Begin
      // ShowMessage('OK');

      lblDate.Text := DateToStr(Now);
      lblTime.Text := TimeToStr(Now);
      lblDescription.Text := 'Connection Successful';
      imgResultTest.Bitmap.Assign(ilCount.Bitmap(Image1.Size.Size, 3));
      imgResultTest.Visible := True;
    End;
  end;

  SetCursor(vcl.Forms.Screen.cursors[crDefault]);
end;

end.
