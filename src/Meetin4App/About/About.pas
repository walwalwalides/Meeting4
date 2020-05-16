{ ============================================
  Software Name : 	Meeting4
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight � 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }

unit About;

interface

uses
{$IFDEF WIN32}
 Winapi.Windows, Winapi.Messages,Winapi.ShellAPI,
{$ENDIF}
System.SysUtils, System.Variants,
  System.Classes, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.Types,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, FMX.ScrollBox, FMX.Memo;

type
  TfrmAbout = class(TForm)
    imgApp: TImage;
    lblAppInformation: TLabel;
    memAbout: TMemo;
    lblLinkGithub: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure lblLinkGithubClick(Sender: TObject);
  private
    procedure launchGithub;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAbout: TfrmAbout;

implementation

{$R *.fmx}
uses
{$IFDEF ANDROID}
  Androidapi.JNI.Embarcadero, Androidapi.JNI.GraphicsContentViewText, Androidapi.helpers,
  Androidapi.JNIBridge, FMX.Helpers.Android, Androidapi.JNI.JavaTypes,
{$ENDIF}
  System.IOUtils;


procedure TfrmAbout.launchGithub();
var
  myURL: string;
{$IFDEF ANDROID}
  Intent: JIntent;
{$ENDIF ANDROID}

{$IFDEF IOS}
  NSU: NSUrl;
{$ENDIF IOS}
begin
  myURL := 'https://github.com/walwalwalides';
{$IFDEF MSWINDOWS}
  ShellExecute(0, 'OPEN', PChar(myURL), '', '', SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}

{$IFDEF IOS}
  NSU   := StrToNSUrl(TIdURI.URLEncode(myURL));
  if SharedApplication.canOpenURL(NSU) then
  begin
    SharedApplication.openUrl(NSU);
  end;
{$ENDIF IOS}

{$IFDEF ANDROID}
  Intent := TJIntent.Create;
  Intent.setAction(TJIntent.JavaClass.ACTION_VIEW);
  Intent.setData(StrToJURI(myURL));
  TAndroidHelper.Activity.startActivity(Intent);
{$ENDIF ANDROID}
end;

procedure TfrmAbout.lblLinkGithubClick(Sender: TObject);
begin
  launchGithub();
end;

procedure TfrmAbout.FormCreate(Sender: TObject);
begin
//  Position := TFormPosition.MainFormCenter;
 lblAppInformation.Text:=TPath.GetFileNameWithoutExtension(ParamStr(0));

end;

end.
