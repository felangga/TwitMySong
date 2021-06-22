unit update;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, IEHTTP3, BMDThread, URLMon, PRInternetAccess,
  OleCtrls, SHDocVw, ExtActns, SUIButton, SUIProgressBar, ExtCtrls, SUIForm;

type
  TfrmUpdate = class(TForm)
    lblProgress: TLabel;
    threadUpdate: TBMDThread;
    Label2: TLabel;
    suiForm1: TsuiForm;
    ProgressBar1: TsuiProgressBar;
    cmdCancel: TsuiButton;
    procedure suitempcmdCancelClick(Sender: TObject);
    procedure threadUpdateExecute(Sender: TObject;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure URL_OnDownloadProgress
        (Sender: TDownLoadURL;
         Progress, ProgressMax: Cardinal;
         StatusCode: TURLDownloadStatus;
         StatusText: String; var Cancel: Boolean) ;
  public
    { Public declarations }
    procedure DoDownload;
  end;

var
  frmUpdate: TfrmUpdate;

implementation

{$R *.dfm}
uses FungsiLain, IniLang2, main;

const sUpdate     = 'Do you want to cancel update process ?';
      sBatal      = 'Abort Update';
      sDone       = 'Update Completed';
      sDownloaded = 'Downloaded';
      sSukses     = 'Update downloaded, press OK to restart program';

procedure TfrmUpdate.suitempcmdCancelClick(Sender: TObject);
begin

  if (MessageBox(0, PChar(misc(sUpdate, 'Update')), PChar(misc(sBatal, 'UpdateAbort')), mb_yesno + mb_iconwarning) = 6) then
  begin
    threadUpdate.Stop;
    frmUpdate.Close;
  end;
end;

procedure TfrmUpdate.URL_OnDownloadProgress;
begin
   ProgressBar1.Max:= ProgressMax;
   label2.Caption := misc(sDownloaded,'Downloaded') + ' : ' + intToStr(Progress div 1024)  + ' / ' +Inttostr(progressMax div 1024) + ' kB';
   ProgressBar1.Position:= Progress;
end;

procedure update_selesai;
// udu lagune nidji !!
var
   F: TextFile;
   batName: string;
   pi: TProcessInformation;
   si: TStartupInfo;
begin
   batName := ExtractFilePath(ParamStr(0)) + '\update.bat';
   AssignFile(F,batName);
   Rewrite(F);
   Writeln(F,':try');
   Writeln(F,'del "'+ParamStr(0)+'"');
   Writeln(F,'if exist "'+ ParamStr(0)+'"'+' goto try');
   Writeln(F,'ren update.tmp twitsong.exe');
   Writeln(F,'twitsong.exe');
   Writeln(F,'del "' + batName + '"' );
   CloseFile(F);
   FillChar(si, SizeOf(si), $00);
   si.dwFlags := STARTF_USESHOWWINDOW;
   si.wShowWindow := SW_HIDE;
   if CreateProcess( nil, PChar(batName), nil, nil, False, IDLE_PRIORITY_CLASS,
       nil, nil, si, pi ) then
   begin
       CloseHandle(pi.hThread);
       CloseHandle(pi.hProcess);
   end;
   KillProcess(Application.Handle);
end;

procedure TfrmUpdate.DoDownload;
begin

   with TDownLoadURL.Create(Self) do
   try
     DeleteFile(ExtractFilePath (Application.ExeName) + 'update.tmp');
     URL := frmMain.AlamatDownload;
     FileName := ExtractFilePath (Application.ExeName) + 'update.tmp';
     OnDownloadProgress := URL_OnDownloadProgress;

     ExecuteTarget(nil) ;
     MessageBox(0, PChar(misc(sSukses, 'UpdateSuccess')), PChar(misc(sDone, 'UpdateDone')), mb_ok + mb_iconinformation);
     update_selesai;
   finally
     Free;
   end;
end;

procedure TfrmUpdate.threadUpdateExecute(Sender: TObject;
  Thread: TBMDExecuteThread; var Data: Pointer);
begin
  DoDownload;
end;

procedure TfrmUpdate.FormShow(Sender: TObject);
begin
  if CL <> nil then fillProps([frmUpdate],CL);
  SetWindowPos(Handle,HWND_TOPMOST,  0,  0,  0,  0,  SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  threadUpdate.Start;
end;

end.
