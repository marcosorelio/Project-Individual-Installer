; -- Example3.iss --
; Same as Example1.iss, but creates some registry entries too.

; SEE THE DOCUMENTATION FOR DETAILS ON CREATING .ISS SCRIPT FILES!

[Setup]
AppName=m3d1-work
AppVersion=1.5
DefaultDirName={sd}\Medilab\m3d1-work
DefaultGroupName=m3d1-work
UninstallDisplayIcon={sd}\m3d1-work.exe
OutputDir=C:\Users\marcos.orelio\Desktop\Nova pasta (2)

[Files]
Source: "m3d1-work.exe"; DestDir: "{app}"
Source: "m3d1-work.chm"; DestDir: "{app}"
Source: "Readme.txt"; DestDir: "{app}"; Flags: isreadme
Source: compiler:WizModernSmallImage.bmp; Flags: dontcopy

[Icons]
Name: "{group}\My Program"; Filename: "{app}\m3d1-work.exe"

; NOTE: Most apps do not need registry entries to be pre-created. If you
; don't know what the registry is or if you need to use it, then chances are
; you don't need a [Registry] section.

[Registry]
; Start "Software\My Company\My Program" keys under HKEY_CURRENT_USER
; and HKEY_LOCAL_MACHINE. The flags tell it to always delete the
; "My Program" keys upon uninstall, and delete the "My Company" keys
; if there is nothing left in them.
Root: HKCU; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
Root: HKCU; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\My Company"; Flags: uninsdeletekeyifempty
Root: HKLM; Subkey: "Software\My Company\My Program"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\My Company\My Program\Settings"; ValueType: string; ValueName: "Path"; ValueData: "{app}"


[Code]

function InitializeSetup(): Boolean; 
var 
ErrorCode:Integer; 
begin 
if RegKeyExists(HKEY_LOCAL_MACHINE, 'SOFTWARE\JavaSoft\Java Runtime Environment') then 
begin 
Result := true; 
end 
else 
begin 
MsgBox('É necessário instalar Java Runtime Environment',mbInformation, MB_OK ); 
ShellExec('open', 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=73141', '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode); 
Result := false; 
end 
end;

{--- Windows Firewall ---}

const
   NET_FW_IP_VERSION_ANY = 2;
   NET_FW_SCOPE_ALL = 0;

procedure FirewallButtonOnClick(Sender: TObject);
var
  Firewall, Application: Variant;
begin
  if MsgBox('Setup will now add itself to Windows Firewall as an authorized application for the current profile (' + GetUserNameString + '). Do you want to continue?', mbInformation, mb_YesNo) = idNo then
    Exit;

  { Create the main Windows Firewall COM Automation object }

  try
    Firewall := CreateOleObject('HNetCfg.FwMgr');
  except
    RaiseException('Please install Windows Firewall first.'#13#13'(Error ''' + GetExceptionMessage + ''' occurred)');
  end;

  { Add the authorization }

  Application := CreateOleObject('HNetCfg.FwAuthorizedApplication');
  Application.Name := 'm3d1-w0rk';
  Application.IPVersion := NET_FW_IP_VERSION_ANY;
  Application.ProcessImageFileName := ExpandConstant('{srcexe}');
  Application.Scope := NET_FW_SCOPE_ALL;
  Application.Enabled := True;

  Firewall.LocalPolicy.CurrentProfile.AuthorizedApplications.Add(Application);

  MsgBox('Setup is now an authorized application for the current profile', mbInformation, mb_Ok);
end;

{---}

procedure CreateButton(ALeft, ATop: Integer; ACaption: String; ANotifyEvent: TNotifyEvent);
begin
  with TButton.Create(WizardForm) do begin
    Left := ALeft;
    Top := ATop;
    Width := WizardForm.CancelButton.Width;
    Height := WizardForm.CancelButton.Height;
    Caption := ACaption;
    OnClick := ANotifyEvent;
    Parent := WizardForm.WelcomePage;
  end;
end;

procedure InitializeWizard();
var
  Left, LeftInc, Top, TopInc: Integer;
  ProgressBar: TNewProgressBar;
begin
  Left := WizardForm.WelcomeLabel2.Left;
  LeftInc := WizardForm.CancelButton.Width + ScaleX(8);
  TopInc := WizardForm.CancelButton.Height + ScaleY(8);
  Top := WizardForm.WelcomeLabel2.Top + WizardForm.WelcomeLabel2.Height - 4*TopInc;

  
  CreateButton(Left, Top, '&Firewall...', @FirewallButtonOnClick);
  Top := Top + TopInc;

  CreateButton(Left, Top, '&Word...', @FirewallButtonOnClick);
  Top := Top
  
  CreateButton(Left, Top, '&Word...', @FirewallButtonOnClick);
  Top := Top + TopInc;
 
end;


