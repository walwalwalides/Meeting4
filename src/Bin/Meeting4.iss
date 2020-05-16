; MMP setup script for Innosetup

; Set commonly used constants for preprocessor
#define ProgName "Meeting4"
#define ProgDocument "Doc_Meeting4"
#define ProgNameLower LowerCase(ProgName)
#define ProgExeName ProgNameLower + ".exe"
#define ProgVersion GetFileVersion(AddBackslash(SourcePath) + ProgNameLower + "32.exe")
#define Email "walwalwalides@gmail.com"
; Take care: this takes the first 4(!) chars of the exe's version string, eg "10.0"
#define ProgShortVersion Copy(ProgVersion, 1, 4)
#define Paypal "https://www.paypal.com/donate/?token=9IcBbr3u2HyksMU0cChpr16Huy0CxERc6X2RMqz6D8otNJ_f-s1LbmFT1pB_Ie6OH5sZoW&country.x=DE&locale.x=DE"
#define Website ""
#define OutDir "."
#define ResourceDir OutDir + ".\Img_Res\"

[Languages]
Name: "en"; MessagesFile: "compiler:Default.isl"
Name: "fr"; MessagesFile: "compiler:Languages\French.isl"
Name: "de"; MessagesFile: "compiler:Languages\German.isl"



[Setup]
AppId={#ProgName}
AppName={#ProgName}
AppVerName={#ProgName} {#ProgVersion}
VersionInfoVersion={#ProgVersion}
PrivilegesRequired=admin

; Displayed on the "Support" dialog of the Add/Remove Programs Control Panel applet:
AppVersion={#ProgShortVersion}
AppPublisher=walwalwalides
AppPublisherURL={#WebSite}
AppSupportURL={#WebSite}forum.php
AppUpdatesURL={#WebSite}download.php
AppContact={#Email}
AppReadmeFile={#WebSite}help.php?place=installer

CloseApplications=yes
ShowLanguageDialog=auto
;DefaultDirName={pf}\{#ProgName}
DefaultDirName=C:\WalWalWalides\{#ProgName} 
DefaultGroupName={#ProgName}
AllowNoIcons=yes
LicenseFile=license.txt
ChangesAssociations=yes
WizardImageFile={#ResourceDir}rainbow-star.bmp
WizardSmallImageFile={#ResourceDir}Meeting4_64_64.bmp
OutputDir={#OutDir}
OutputBaseFilename={#ProgName}_{#ProgShortVersion}_Setup
UninstallDisplayIcon={app}\{#ProgExeName}
SetupIconFile={#ResourceDir}Meeting4.ico
ArchitecturesInstallIn64BitMode=x64
UsePreviousAppDir=no
DirExistsWarning=auto
;PrivilegesRequired=none

[Tasks]
;Name: "activate_updatechecks"; Description: "Automatically check {#WebSite} for updates"; GroupDescription: "Options:";
Name: "activate_statistics"; Description: "Automatically report client and server versions on {#WebSite}"; GroupDescription: "Options:"
Name: "theme_windows"; Description: "Use default Windows theme"; GroupDescription: "Select theme:"; Flags: exclusive
Name: "theme_material"; Description: "Use dark Material theme"; GroupDescription: "Select theme:"; Flags: exclusive unchecked
Name: "desktopicon"; Description: "Create a &desktop icon for documents"; GroupDescription: "Options:"; MinVersion: 4,4

[InstallDelete]
Type: files; Name: "{app}\M4Server.exe"
Type: dirifempty; Name: {app}; 

[Files]
;Source: "{#ProgNameLower}64.exe"; DestDir: "{app}"; DestName: "{#ProgExeName}"; Flags: ignoreversion; Check: Is64BitInstallMode
Source: "{#ProgExeName}"; DestDir: "{app}"; Flags: ignoreversion
Source: "license.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "gpl.txt"; DestDir: "{app}"; Flags: ignoreversion
Source: "M4Server.exe"; DestDir: "{app}"
Source: "Calender\api-ms-win-core-console-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-datetime-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-debug-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-errorhandling-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-file-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-file-l1-2-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-file-l2-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-handle-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-heap-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-interlocked-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-libraryloader-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-localization-l1-2-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-memory-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-namedpipe-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-processenvironment-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-processthreads-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-processthreads-l1-1-1.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-profile-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-rtlsupport-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-string-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-synch-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-synch-l1-2-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-sysinfo-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-timezone-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-core-util-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-conio-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-convert-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-environment-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-filesystem-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-heap-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-locale-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-math-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-process-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-runtime-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-stdio-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-string-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-time-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\api-ms-win-crt-utility-l1-1-0.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\base_library.zip"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\Calender.exe"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\Calender.exe.manifest"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\pyexpat.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\python37.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\select.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\ucrtbase.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\unicodedata.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\VCRUNTIME140.dll"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\_bz2.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\_ctypes.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\_hashlib.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\_lzma.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\_queue.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\_socket.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion
Source: "Calender\_ssl.pyd"; DestDir: "{app}\Calender"; Flags: ignoreversion

[Icons]
Name: "{group}\{#ProgName}"; Filename: "{app}\{#ProgExeName}"
Name: "{group}\General help"; Filename: "https://github.com/walwalwalides"
Name: "{userdesktop}\{#ProgName}"; Filename: "{app}\{#ProgExeName}"; MinVersion: 4,4; Tasks: desktopicon
;Name: "{userdesktop}\{#ProgDocument}"; Filename: "{userdocs}\{#ProgName}"; MinVersion: 4,4; Tasks: desktopicon ;Flags: foldershortcut

[Registry]
; Enable auto-updatechecks if this option was checked. Only save the value when it's checked, as the default in preferences is False (see const.inc)
;Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "Updatecheck"; ValueData: 1; Tasks: activate_updatechecks
Root: HKCU; Subkey: "Software\{#ProgName}"; Flags: dontcreatekey uninsdeletevalue
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "DoUsageStatistics"; ValueData: 1; Tasks: activate_statistics

; Store theme selection: "Windows"
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: string; ValueName: "Theme"; ValueData: "Windows"; Tasks: theme_windows
; SQL colors from "Light" preset
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Comment Foreground"; ValueData: "8421504"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr ConditionalComment Foreground"; ValueData: "8421504"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr DataType Foreground"; ValueData: "128"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr DelimitedIdentifier Foreground"; ValueData: "32896"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Function Foreground"; ValueData: "8388608"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Identifier Foreground"; ValueData: "32896"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Key Foreground"; ValueData: "16711680"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Number Foreground"; ValueData: "8388736"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr String Foreground"; ValueData: "32768"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Symbol Foreground"; ValueData: "16711680"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr TableName Foreground"; ValueData: "16711935"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Variable Foreground"; ValueData: "8388736"; Tasks: theme_windows
; Data type colors from "Light" preset
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Binary"; ValueData: "8388736"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Datetime"; ValueData: "128"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Numeric"; ValueData: "16711680"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Other"; ValueData: "32896"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Real"; ValueData: "16711752"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Spatial"; ValueData: "8421376"; Tasks: theme_windows
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Text"; ValueData: "32768"; Tasks: theme_windows

; Store theme selection: "Material"
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: string; ValueName: "Theme"; ValueData: "Material"; Tasks: theme_material
; SQL colors from "Material" preset
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Comment Foreground"; ValueData: "8023636"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr ConditionalComment Foreground"; ValueData: "12108397"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr DataType Foreground"; ValueData: "15372999"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr DelimitedIdentifier Foreground"; ValueData: "16757122"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Function Foreground"; ValueData: "14929603"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Identifier Foreground"; ValueData: "16757122"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Key Foreground"; ValueData: "14929603"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Number Foreground"; ValueData: "7361535"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr String Foreground"; ValueData: "8906947"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Symbol Foreground"; ValueData: "12897152"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr TableName Foreground"; ValueData: "6911735"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "SQL Attr Variable Foreground"; ValueData: "7064575"; Tasks: theme_material
; Data type colors from "Dark" preset
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Binary"; ValueData: "13203071"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Datetime"; ValueData: "7566281"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Numeric"; ValueData: "16750469"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Other"; ValueData: "7586241"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Real"; ValueData: "13663613"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Spatial"; ValueData: "13553267"; Tasks: theme_material
Root: HKCU; Subkey: "Software\{#ProgName}"; ValueType: dword; ValueName: "FieldColor_Text"; ValueData: "7591283"; Tasks: theme_material

[Run]
;Filename: "{app}\{#ProgExeName}"; Description: "Launch {#ProgName}"; Flags: runascurrentuser nowait postinstall skipifsilent
Filename: "{app}\M4Server.exe"; Parameters: "/reg"; Flags: nowait postinstall skipifsilent runascurrentuser; 

[Dirs]
Name: "{app}\Flags"
Name: "{userdocs}\{#ProgName}"

[UninstallRun]
;Filename: "{app}\M4Server.exe"; Parameters: "/unreg";

[UninstallDelete]
Type: files; Name: "{app}\dbRegister.db"
Type: files; Name: "{app}\SettingDB.sqb"

[Code]
var
  txt: TNewStaticText;
  btn: TButton;

procedure DonateClick(Sender: TObject);
var
  ErrorCode: Integer;
begin
  ShellExec('open', '{#Paypal}', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;

procedure InitializeWizard();
begin
  txt := TNewStaticText.Create(WizardForm);
  txt.Parent := WizardForm.FinishedPage;
  txt.Caption := '{#ProgName} is free software for database workers.'+#13#10+'Keep it alive with a donation:';
  txt.Left := WizardForm.FinishedLabel.Left;
  txt.Top := WizardForm.FinishedLabel.Top + WizardForm.FinishedLabel.Height + 80;

  btn := TButton.Create(WizardForm);
  btn.Parent := WizardForm.FinishedPage;
  btn.Left := txt.Left;
  btn.Top := txt.Top + txt.Height + 10;
  btn.Width := WizardForm.Width div 2;
  btn.cursor:=crhandpoint;
  btn.Height := WizardForm.CancelButton.Height + 10;
  btn.Caption := 'Donate via Paypal';
  btn.OnClick := @DonateClick;
end;


procedure CurPageChanged(CurPageID: Integer);
begin
  if CurPageID = wpFinished then
    WizardForm.ActiveControl := btn;
end;
