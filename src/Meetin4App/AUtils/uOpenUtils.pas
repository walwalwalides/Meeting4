{ ============================================
  Software Name : 	Meeting4
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit uOpenUtils;

interface

uses
{$IFDEF MSWINDOWS}
  Winapi.ShellAPI, Winapi.Windows,FMX.forms;
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
Posix.Stdlib;
{$ENDIF POSIX}

type
  TMisc = class
    class procedure Open(sCommand: string);
  end;

implementation

class procedure TMisc.Open(sCommand: string);
begin
{$IFDEF MSWINDOWS}
   ShellExecute(0, 'OPEN', PChar(sCommand), '', '', SW_SHOWNORMAL);
//  ShellExecute(Handle, nil, PChar(sCommand),nil, nil, SW_SHOWNORMAL);
{$ENDIF MSWINDOWS}
{$IFDEF POSIX}
  _system(PAnsiChar('open ' + AnsiString(sCommand)));
{$ENDIF POSIX}
end;

end.
