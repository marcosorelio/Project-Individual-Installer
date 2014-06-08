instalador-individual
=====================

Instalador utilizando a IDE Inno Setup

Função verifica se java foi instalado na máquina

```basic
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
```
