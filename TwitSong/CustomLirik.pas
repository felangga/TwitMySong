unit CustomLirik;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IEHTTP3, BMDThread, ExtCtrls, ComCtrls, OleCtrls, ActiveX,
  SHDocVw, mshtml, SUIButton, SUIMemo, SUIForm;

type
  TfrmCustom = class(TForm)
    lblInfo: TLabel;
    lblStatus: TLabel;
    web: TWebBrowser;
    suiForm1: TsuiForm;
    CustomLirik: TsuiMemo;
    cmdSelect: TsuiButton;
    cmdRefresh: TsuiButton;
    procedure ThreadDownloadLirikExecute(Sender: TObject;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure tmrUpdateTimer(Sender: TObject);
    procedure suitempcmdRefreshClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure suitempcmdSelectClick(Sender: TObject);
    procedure suitempCustomLirikClick(Sender: TObject);
    procedure webDocumentComplete(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure webDownloadComplete(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCustom: TfrmCustom;
  cArtis, cJudul : String;

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


procedure TfrmCustom.ThreadDownloadLirikExecute(Sender: TObject;
  Thread: TBMDExecuteThread; var Data: Pointer);
var isiPost : OleVariant;
    Header  : OleVariant;
    strData : String;
    i  : integer;
begin
  if (cJudul <> '') AND (cArtis <> '') then
  begin
    lblStatus.Caption := 'loading...';
    // iki URL Encoding
    cArtis := StringReplace (cArtis, '.','',[rfReplaceAll]);
    cJudul := StringReplace (cJudul, '.','',[rfReplaceAll]);
    cArtis := StringReplace (cArtis, '&','n',[rfReplaceAll]);
    cJudul := StringReplace (cJudul, '&','n',[rfReplaceAll]);
    web.Stop;

    strData := 'p=lirik&artis='+cArtis+'&'+'lagu='+cJudul;
    showMessage(strdata);
    isiPost := VarArrayCreate([0, Length(strData)-1], varByte);
    for i := 1 to Length(strData) do
      isiPost[i-1] := Ord(strData[i]);

    Header := 'Content-Type: application/x-www-form-urlencoded' + #10#13;
    web.Navigate(frmMain.ServerUtama, EmptyParam, EmptyParam, isiPost, Header);


{    if (pos('Tidak Ketemu', getSourceHTML(web)) <= 0) then
      CustomLirik.Lines.Add(getSourceHTML(web))
    else
      CustomLirik.Text := 'Lyrics not found';}
  end;
end;

procedure TfrmCustom.tmrUpdateTimer(Sender: TObject);
begin
  showmessage(frmMain.Art);
end;

procedure TfrmCustom.suitempcmdRefreshClick(Sender: TObject);
var isiPost : OleVariant;
    Header  : OleVariant;
    strData : String;
    i  : integer;
begin            
  begin
    if (frmMain.customArtis <> '') AND (frmMain.customTrack <> '') then
    begin
      cArtis := frmMain.customArtis;
      cJudul := frmMain.customTrack;
      if (cJudul <> '') AND (cArtis <> '') then
      begin
        lblStatus.Caption := 'loading...';
        // iki URL Encoding
        cArtis := StringReplace (cArtis, '.','',[rfReplaceAll]);
        cJudul := StringReplace (cJudul, '.','',[rfReplaceAll]);
        cArtis := StringReplace (cArtis, '&','n',[rfReplaceAll]);
        cJudul := StringReplace (cJudul, '&','n',[rfReplaceAll]);
        web.Stop;

        strData := 'p=lirik&artis='+cArtis+'&'+'lagu='+cJudul;
        isiPost := VarArrayCreate([0, Length(strData)-1], varByte);
        for i := 1 to Length(strData) do
          isiPost[i-1] := Ord(strData[i]);

        Header := 'Content-Type: application/x-www-form-urlencoded' + #10#13;
        web.Navigate(frmMain.ServerUtama, EmptyParam, EmptyParam, isiPost, Header);

      end;
    end
  end
end;

procedure TfrmCustom.FormShow(Sender: TObject);
begin
  if CL <> nil then fillProps([frmCustom],CL);
  frmCustom.Left := (frmMain.Left - frmCustom.Width) - 10;
  frmCustom.Top  := (frmMain.Top) - (frmCustom.Height - frmMain.Height);
  cmdRefresh.Click;
end;

procedure TfrmCustom.suitempcmdSelectClick(Sender: TObject);
begin

  frmMain.txtTwit.Text := '"'+CustomLirik.SelText+'" #np '+ cArtis + ' - ' + cJudul + ' #TwitMySong' +' #'+Player[MediaSelector]
end;

procedure TfrmCustom.suitempCustomLirikClick(Sender: TObject);
begin
  if (CustomLirik.SelText <> '') then
    cmdSelect.Enabled := true
  else
    cmdSelect.Enabled := false;
end;

procedure TfrmCustom.webDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
var
  document : IHTMLDocument2;
  s : string;
begin
  // extract the day's total earnings etc
  Document := Web.Document as IHTMLDocument2;
  s := Document.Body.innerHTML;

  // process this string to extract contents
  if (pos('Tidak Ketemu', s) <= 0) then
     CustomLirik.Text := s
  else
     CustomLirik.Text := 'Lyrics not found';
end;

procedure TfrmCustom.webDownloadComplete(Sender: TObject);
begin
  lblStatus.Caption := 'standby...';
end;

end.
