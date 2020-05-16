{ ============================================
  Software Name : 	Meeting4
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit PassLock;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes,
  System.Variants,
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  FMX.TMSBaseControl, FMX.TMSPassLock, FMX.Controls.Presentation,
  System.ImageList, FMX.ImgList, FMX.Edit, FMX.Objects, FMX.TabControl,
  FMX.TMSBaseGroup, FMX.TMSRadioGroup,
  FMX.ListBox, FMX.Layouts, System.Rtti, System.Bindings.Outputs,
  FMX.Bind.Editors, Data.Bind.EngExt, FMX.Bind.DBEngExt,
  Data.Bind.Components, Data.Bind.DBScope;

type
  TFraPassLock = class(TFrame)
    PassLock: TTMSFMXPassLock;
    Label1: TLabel;
    Label3: TLabel;
    edLUser: TEdit;
    Glyph1: TGlyph;
    img: TImageList;
    Rectangle1: TRectangle;
    TabControl1: TTabControl;
    TabItem1: TTabItem;
    TabItem3: TTabItem;
    ListBox1: TListBox;
    GroupName: TListBoxGroupHeader;
    ListBoxItemIPAdresse: TListBoxItem;
    edtIpAdresse: TEdit;
    ListBoxItemBenutzer: TListBoxItem;
    edtBnutzer: TEdit;
    ListBoxItemPassword: TListBoxItem;
    edtPassword: TEdit;
    ListBoxItemWeitere: TListBoxItem;
    edtPort: TEdit;
    ListBoxItem1: TListBoxItem;
    ListBoxItemEmail: TListBoxItem;
    edtEmail: TEdit;
    ListBoxItem2: TListBoxItem;
    ListBoxItemInternet: TListBoxItem;
    edtInternet: TEdit;
    RadioButton1: TRadioButton;
    rbConnecMethode: TTMSFMXRadioGroup;
    btnSave: TButton;
    btnSetting: TButton;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
    LinkControlToField2: TLinkControlToField;
    LinkControlToField3: TLinkControlToField;
    LinkControlToField4: TLinkControlToField;
    LinkControlToField5: TLinkControlToField;
    procedure PassLockPasswordConfirmed(Sender: TObject;
      Result: TTMSFMXPasswordConfirm);
    procedure PassLockPasswordLearned(Sender: TObject);
    procedure PassLockPasswordMatch(Sender: TObject);
    procedure PassLockPasswordMismatch(Sender: TObject);
    procedure rbNumbersChange(Sender: TObject);
    procedure rbLearnChange(Sender: TObject);
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure btnSaveClick(Sender: TObject);
    procedure btnSettingClick(Sender: TObject);
  private
    FRanOnce: Boolean;
    procedure fnReg;
    procedure fnLogin;
    procedure CheckWifi;
    procedure NewParmetreSaved;
    procedure iniConnection;
    procedure LoadSettingConnection;
    procedure SaveSetting(AMessageBool: Boolean);

    { Private declarations }
  public
    { Public declarations }
    procedure Init;

    procedure FirstShow;
    procedure ReleaseFrame;
    procedure goLogin;

  end;

var
  FraPassLock: TFraPassLock;
  BoolInActive: Boolean = False;

implementation

{$R *.fmx}

uses FMX.Effects, System.Threading, System.RegularExpressions, usign, Main,
  dmMain, ClientModuleApp, Global, DNLog.Types
{$IFDEF ANDROID}
    , System.Android.Service, Androidapi.JNI.JavaTypes,
  Androidapi.JNI.GraphicsContentViewText, Androidapi.JNI.Net,
  Androidapi.Helpers, Androidapi.JNI.App, {IntentServiceUnit,}
  Androidapi.JNIBridge, Androidapi.JNI.Net.Wifi {$ENDIF}
    ;

procedure TFraPassLock.btnSaveClick(Sender: TObject);
begin
  SaveSetting(True);
end;

procedure TFraPassLock.btnSettingClick(Sender: TObject);
begin
  TabControl1.TabIndex := 1;
end;

procedure TFraPassLock.CheckWifi;

{$IFDEF ANDROID}
var
  WifiManagerObj: JObject;
  WifiManager: JWifiManager;
  WifiInfo: JWifiInfo;
{$ENDIF}
begin

{$IFDEF ANDROID}
  WifiManagerObj := SharedActivityContext.getSystemService
    (TJContext.JavaClass.WIFI_SERVICE);
  WifiManager := TJWifiManager.Wrap((WifiManagerObj as ILocalObject)
    .GetObjectID);
  WifiInfo := WifiManager.getConnectionInfo();

  if ((WifiManager.isWifiEnabled) and (WifiManager.getWifiState = 3)) then
  begin

    if (BoolInActive = True) then
    begin
      Label3.Text := 'Wifi State: ' + 'Active !';
      BoolInActive := False;
    end;

  end
  else
  begin

    Label3.Text := 'Wifi State: ' + 'Not Active !';
    BoolInActive := True;
  end;

{$ENDIF}
End;

procedure TFraPassLock.fnReg;
var
  Task: ITask;
begin
  if ((PassLock.PassEntry <> '') and (edLUser.Text <> '')) then
  begin

    Task := TTask.Create(
      procedure()
      begin
        RegUser(edLUser.Text, PassLock.PassEntry);

      end);
    Task.Start;

  end
  else
    Showmessage('Username field is empty');
end;

procedure TFraPassLock.fnLogin;
var
  user: string;
  pass: String;
  Task: ITask;
begin
  user := edLUser.Text;
  pass := PassLock.PassEntry;
  // pass := MD5(edLPass.Text);
  Task := TTask.Create(
    procedure()
    begin
      LogUser(user, pass);
    end);
  Task.Start;
end;

procedure TFraPassLock.NewParmetreSaved;
Begin
{$IFDEF ANDROID}
  ShowCustumMessage('INFO', 'ALERT', 'INFO', 'New parameters saved', 'OK', '',
    $FF31B824, $FFDF5447);
{$ENDIF}
end;

procedure TFraPassLock.SaveSetting(AMessageBool: Boolean);
var
  iPos: Integer;
begin
  inherited;
  //
  //
  // FDQueryInsert.ParamByName('TaskName').AsString := TaskName;
  // FDQueryInsert.ExecSQL();
  // FDTableTask.Refresh;
  try
    dataMain.tblconnection.Edit;
    iPos := rbConnecMethode.itemindex;
    dataMain.tblconnection.FieldByName('MethodeIndex').asinteger := iPos;

    //
    case iPos of
      0:
        dataMain.tblconnection.FieldByName('Methode').asString := 'TCP';

      1:
        dataMain.tblconnection.FieldByName('Methode').asString := 'UDP';

    end;

    if (PassLock.PassEntry <> '') then
      dataMain.tblconnection.FieldByName('Password').asString :=
        PassLock.PassEntry;

    dataMain.tblconnection.post;
  finally
    dataMain.tblconnection.refresh;
    if (AMessageBool = True) then
      NewParmetreSaved;

    TabControl1.TabIndex := 0;
    LoadSettingConnection;

  end;

end;

constructor TFraPassLock.Create(AOwner: TComponent);
begin
  inherited;
  TabControl1.tabPosition := TTabPosition.None;
{$IFDEF ANDROID}
  edLUser.TextSettings.FontColor := TAlphaColorRec.white;
{$ENDIF}
  Init;
  LoadSettingConnection;
end;

procedure TFraPassLock.iniConnection;
begin
  if not FRanOnce then
  begin
    FRanOnce := True;


    // if (dataMain=nil) then
    // dataMain:=TdataMain.Create(FHome);

    dataMain.InitializeDatabase(0);

    dataMain.tblconnection.open;
    rbConnecMethode.itemindex := dataMain.tblconnection.FieldByName
      ('METHODEINDEX').asinteger;
  end;
end;

destructor TFraPassLock.Destroy;
begin
  //
  inherited;
end;

procedure TFraPassLock.FirstShow;
var
  Task: ITask;
begin
  Task := TTask.Create(
    procedure
    begin
      // Tasking, agar responsive. hati hati dalam menggunakan Task.
      // LoadHarga;

      TabControl1.TabIndex := 0;
      CheckWifi;
      iniConnection;

      BindSourceDB1.DataSet := dataMain.tblconnection;
      dataMain.mtblconnection.open;

    end);
  Task.Start;

end;

procedure TFraPassLock.goLogin;
begin
  //
end;

procedure TFraPassLock.LoadSettingConnection;
begin
  try
    if Assigned(dataMain.tblconnection) then
    begin
      dataMain.InitializeDatabase(0);
      dataMain.tblconnection.Close;
      dataMain.tblconnection.open;
      if (dataMain.tblconnection.FieldByName('IPAddress').asString <> '') then
      begin
        ClientModule.SQLConnection1.Params.Values['HostName'] :=
          dataMain.tblconnection.FieldByName('IPAddress').asString;
        ClientModule.SQLConnection1.Params.Values['Port'] :=
          dataMain.tblconnection.FieldByName('Port').asString;
        // --------------------------------------------------------------------------------------------------------  //


        edLUser.Text := dataMain.tblconnection.FieldByName('User').asString;
      end
      else
      begin
        ClientModule.SQLConnection1.Params.Values['HostName'] := SERVER_ADDRESS;
        ClientModule.SQLConnection1.Params.Values['Port'] :=
          dataMain.tblconnection.FieldByName('Port').asString;

        // --------------------------------------------------------------------------------------------------------  //


      end;
    end;
  finally
  end;
  // FreeAndNil(dataMain);
end;

procedure TFraPassLock.Init;
begin

  PassLock.LockType := pltNumber;

  Label3.Text := 'Enter password:'
end;

procedure TFraPassLock.rbLearnChange(Sender: TObject);
begin
  Init;
end;

procedure TFraPassLock.rbNumbersChange(Sender: TObject);
begin
  Init;
  PassLock.PassValue := '';
end;

procedure TFraPassLock.ReleaseFrame;
begin
{$IF DEFINED(IOS) or DEFINED(ANDROID)}
  DisposeOf;
{$ELSE}
  Free;
{$ENDIF}
  FraPassLock := Nil;
end;

procedure TFraPassLock.PassLockPasswordConfirmed(Sender: TObject;
Result: TTMSFMXPasswordConfirm);
begin
  if Result = pcSuccess then
  Begin
    if (edLUser.Text <> '') then
    Begin
      if (frmMain.CheeckUsername(edLUser.Text, True) = False) then
        Label3.Text := 'Result: Username is false.Please try again.'
      else
      Begin
        fnReg;
        SaveSetting(False);
      End;
    End
    else

      Label3.Text := 'Result: Username is empty.Please try again.'

  End

  else
    Label3.Text := 'Result: Confirm failed. Please try again.';
end;

procedure TFraPassLock.PassLockPasswordLearned(Sender: TObject);
begin
  Label3.Text := 'Result: Password learned. Please confirm password.';
end;

procedure TFraPassLock.PassLockPasswordMatch(Sender: TObject);
begin
  if (frmMain.CheeckUsername(edLUser.Text, True) = True) then
  Begin
    Label3.Text := 'Result: Password is correct';
    fnLogin;
  End
  else
  begin
    Label3.Text := 'Result: Server not found.';

  end;
end;

procedure TFraPassLock.PassLockPasswordMismatch(Sender: TObject);
begin
  Label3.Text := 'Result: Password is wrong. Please try again.';
end;

end.
