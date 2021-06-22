unit Request;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ActiveX, ExtCtrls, SUIProgressBar,
  SUIForm;

type
  TfrmRequest = class(TForm)
    browser: TWebBrowser;
    tmrRampung: TTimer;
    suiForm1: TsuiForm;
    progressBar: TsuiProgressBar;
    procedure browserProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure tmrRampungTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRequest: TfrmRequest;

implementation

uses main, IniLang2;

{$R *.dfm}


function GetHTML(const WebBrowser: TWebBrowser): String;
var
  LStream: TStringStream;
  Stream : IStream;
  LPersistStreamInit : IPersistStreamInit;
begin
  if not Assigned(WebBrowser.Document) then exit;
  LStream := TStringStream.Create('');
  try
    LPersistStreamInit := WebBrowser.Document as IPersistStreamInit;
    Stream := TStreamAdapter.Create(LStream,soReference);
    LPersistStreamInit.Save(Stream,true);
    result := LStream.DataString;
  finally
    LStream.Free();
  end;
end;

procedure TfrmRequest.browserProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
  progressBar.Max := ProgressMax;
  progressBar.Position := Progress;
end;

procedure TfrmRequest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (not main.Authenticated) then
  begin
    frmMain.txtTwit.Enabled := true;
    frmMain.txtTwit.Text := 'Welcome to TwitMySong click on Connect with Twitter to get started!';
    frmMain.cmdKonek.Enabled := true;
    frmMain.cmdKonek.Caption := 'Connect with Twitter!';
  end;
end;

procedure TfrmRequest.tmrRampungTimer(Sender: TObject);
var temp, potong : String;
    posisi       : Integer;
begin
  if (progressBar.Position = 0) then progressBar.Visible := False else progressBar.Visible := True;
  temp   := GetHTML(browser);
  posisi := pos('code-desc"><code>', temp);
  if (posisi > 0) then
  begin
    potong := Copy(temp, posisi+17, pos('</code>', Copy(temp, posisi+17, length(temp)))-1);
    if (potong <> '') then
    begin
      main.frmMain.txtTwit.Text := potong;
      main.frmMain.txtTwit.Enabled := true;
      main.frmMain.cmdKonek.Click;
      tmrRampung.Enabled := False;
      frmRequest.Hide;
    end;
  end;
end;

procedure TfrmRequest.FormShow(Sender: TObject);
begin
  if CL <> nil then fillProps([frmRequest],CL);
  tmrRampung.Enabled := true;
end;

end.
