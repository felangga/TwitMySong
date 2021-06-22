unit FungsiLain;

interface

uses Windows, SysUtils, TlHelp32, Messages, Dialogs;

function GetVersion(ApplicationName: string) : string;
function GetProcessID(ProcessName: String):Integer;
function GetHWndByPID(const hPID: THandle): THandle;

procedure KillProcess(hWindowHandle: HWND);

implementation

procedure KillProcess(hWindowHandle: HWND);
var
  hprocessID: INTEGER;
  processHandle: THandle;
  DWResult: DWORD;
begin
  SendMessageTimeout(hWindowHandle, WM_CLOSE, 0, 0,
  SMTO_ABORTIFHUNG or SMTO_NORMAL, 5000, DWResult);
  if isWindow(hWindowHandle) then
  begin
    // PostMessage(hWindowHandle, WM_QUIT, 0, 0);
    { Get the process identifier for the window}
    GetWindowThreadProcessID(hWindowHandle, @hprocessID);
    if hprocessID <> 0 then
    begin
      { Get the process handle }
      processHandle := OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, False, hprocessID);
      if processHandle <> 0 then
      begin
        { Terminate the process }
        TerminateProcess(processHandle, 0);
        CloseHandle(ProcessHandle);
      end;
    end;
  end;
end;

function GetVersion(ApplicationName: string) : string;
CONST
  VAR_FILE_INFO = '\VarFileInfo\Translation';
  STRING_FILE_INFO = '\StringFileInfo\';
  FILE_VERSION = 'FileVersion';
VAR
  iVersionInfoSize: integer;
  dwHandle: dWord;
  strVersionInfoBuffer: string;
  iVersionValueSize: cardinal;
  pTranslationTable: pLongInt;
  strVersionValue: string;
  pVersionValue: pChar;

function QueryValue(ValueStr: String): String;
Begin
  IF VerQueryValue(PChar(strVersionInfoBuffer),
                     PChar(strVersionValue + ValueStr),
                     Pointer(pVersionValue),
                     iVersionValueSize) THEN
    Result := String(pVersionValue)
  //ELSE
//    Result := FCurrentVersion;
end;

begin
  iVersionInfoSize := GetFileVersionInfoSize(PChar(ApplicationName), dwHandle);
  IF iVersionInfoSize > 0 THEN
  Begin
    SetLength(strVersionInfoBuffer, iVersionInfoSize);
    IF GetFileVersionInfo(PChar(ApplicationName),dwHandle,
                                iVersionInfoSize,
                                  PChar(strVersionInfoBuffer))
    THEN
      IF VerQueryValue(PChar(strVersionInfoBuffer),
                             PChar(VAR_FILE_INFO),
                             Pointer(pTranslationTable),
                             iVersionValueSize)
      THEN
        strVersionValue := Format('%s%.4x%.4x%s',
                                  [STRING_FILE_INFO,
                                  LoWord(pTranslationTable^),
                                  HiWord(pTranslationTable^),'\']);
  End;
  Result := QueryValue(FILE_VERSION);
end;

function GetProcessID(ProcessName: String):Integer;
var Handle: tHandle;
    Process: tProcessEntry32;
    GotProcess: Boolean;
begin
  Handle:=CreateToolHelp32SnapShot(TH32CS_SNAPALL,0);
  Process.dwSize:=SizeOf(Process);
  GotProcess := Process32First(Handle,Process);
  {$B-}
  if GotProcess and (Process.szExeFile<>ProcessName) then
  repeat
    GotProcess := Process32Next(Handle,Process);
  until (not GotProcess) or (Process.szExeFile=ProcessName);
  {$B+}
  if GotProcess then
    Result:=Process.th32ProcessID
  else
    Result:=0;
  CloseHandle(Handle);
end;

function GetHWndByPID(const hPID: THandle): THandle;
type
  PEnumInfo = ^TEnumInfo;
  TEnumInfo = record
    ProcessID: DWORD;
    HWND: THandle;
  end;

function EnumWindowsProc(Wnd: DWORD; var EI: TEnumInfo): Bool; stdcall;
var
  PID: DWORD;
begin
  GetWindowThreadProcessID(Wnd, @PID);

  Result := (PID <> EI.ProcessID) or (not IsWindowEnabled(WND)) or (not IsWindowVisible(WND)); 
  if not Result then EI.HWND := WND; //break on return FALSE
end;

function FindMainWindow(PID: DWORD): DWORD;
var
  EI: TEnumInfo;
begin
  EI.ProcessID := PID;
  EI.HWND := 0;

  EnumWindows(@EnumWindowsProc, Integer(@EI));
  Result := EI.HWND;
  //showmessage(inttostr(result));
end;

begin
  if hPID<>0 then
    Result:=FindMainWindow(hPID)
  else
    Result:=0;
end;



end.
