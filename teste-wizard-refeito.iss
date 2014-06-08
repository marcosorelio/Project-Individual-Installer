; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{166A3BDA-206C-4597-96E2-B61DEBC4BE8F}
AppName=MediWorkslight
AppVersion=7.0
;AppVerName=My Program 1.5
DefaultDirName={sd}\Medilab\MediWorkslight
DisableDirPage=yes
DefaultGroupName=Medilab\Mediworkslight
OutputDir=Output
OutputBaseFilename=Prototype
Compression=lzma
SolidCompression=yes

[Languages]
Name: "brazilianportuguese"; MessagesFile: "compiler:Languages\BrazilianPortuguese.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: MediWorksLight\Mediworks.exe; DestDir: "{app}"; Flags: ignoreversion
Source: MediWorksLight\medi.ini; DestDir: "{app}"; Flags: ignoreversion
Source: MediWorksLight\MEDI05F.DLL; DestDir: "{app}"; Flags: ignoreversion
Source: MediWorksLight\MediRDLL.dll; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\Mediworkslight"; Filename: "{app}\Mediworks.exe"
Name: "{group}\{cm:UninstallProgram,My Program}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\Mediworkslight"; Filename: "{app}\Mediworks.exe"; Tasks: desktopicon
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\MediworksLight"; Filename: "{app}\Mediworks.exe"; Tasks: quicklaunchicon

[Run]
Filename: "{app}\Mediworks.exe"; Description: "{cm:LaunchProgram,MediworksLight}"; Flags: nowait postinstall skipifsilent


