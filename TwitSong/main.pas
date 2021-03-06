unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TwitterLib, ExtCtrls, 
  IEHTTP3, BMDThread, ComCtrls, Buttons, CoolTrayIcon, ShellAPI,
  Menus, Gauges, SUIStatusBar, SUIButton, SUIScrollBar, SUIPageControl,
  SUITabControl, SUIMemo, SUIEdit, SUIImagePanel, SUIGroupBox,
  SUIPopupMenu, SUIForm, IniLang2, SUIComboBox, FileCtrl;

const TKey = 'UVPRfnEO3a7q9PQQhSNpg';   // key akun milik tweetmysong
      TSecret = 'ixEBzOa6s5MgNEYRhEGcOJma1D4k7AaUZlUOUIP0';

type
  TfrmMain = class(TForm)
    lblPanjang: TLabel;
    lblEvery: TLabel;
    lbllagu: TLabel;
    lblVersi: TLabel;
    Label4: TLabel;
    tmrTweet: TTimer;
    ie: TIEHTTP;
    BMDThread1: TBMDThread;
    Timer1: TTimer;
    PanelGeser: TPanel;
    cmdJetAudio: TSpeedButton;
    cmdClementine: TSpeedButton;
    Image1: TImage;
    Tray: TCoolTrayIcon;
    mnuShowMain: TMenuItem;
    ShowTweetMySong1: TMenuItem;
    mnuQuit: TMenuItem;
    mnuTweet: TMenuItem;
    cmdWinamp: TSpeedButton;
    cmdVLC: TSpeedButton;
    Label5: TLabel;
    lblEditMeta: TLabel;
    lblArtis: TLabel;
    lblTrack: TLabel;
    moodSad: TGauge;
    moodHappy: TGauge;
    lblPlaylistMood: TLabel;
    lblSad: TLabel;
    lblHappy: TLabel;
    lblCustom: TLabel;
    suiForm1: TsuiForm;
    PopupMenu1: TsuiPopupMenu;
    GroupBox4: TsuiGroupBox;
    txtMetaArtist: TsuiEdit;
    txtMetaTrack: TsuiEdit;
    cmdEditOke: TsuiButton;
    Memo1: TsuiMemo;
    PageControl1: TsuiPageControl;
    TabSheet1: TsuiTabSheet;
    txtTwit: TsuiMemo;
    cmdKonek: TsuiButton;
    GroupBox5: TsuiGroupBox;
    cmdManual: TsuiButton;
    TabSheet2: TsuiTabSheet;
    txtTwitTimer: TsuiEdit;
    cmdApply: TsuiButton;
    cmdClearToken: TsuiButton;
    GroupBox2: TsuiGroupBox;
    scrollmedia: TsuiScrollBar;
    chkAutoTweet: TsuiCheckBox;
    TabSheet3: TsuiTabSheet;
    GroupBox1: TsuiGroupBox;
    GroupBox3: TsuiGroupBox;
    cmdUpdate: TsuiButton;
    cmdCredits: TsuiButton;
    StatusBar: TsuiStatusBar;
    pnlMedia: TPanel;
    cmdWMP: TSpeedButton;
    Panel1: TPanel;
    Shape1: TShape;
    Label11: TLabel;
    lblTips: TLabel;
    tmrTips: TTimer;
    cmdITunes: TSpeedButton;
    cmbBahasa: TsuiComboBox;
    chkSwap: TsuiCheckBox;
    lblLanguage: TLabel;
    filebox: TFileListBox;
    ieServer: TIEHTTP;
    procedure FormCreate(Sender: TObject);
    procedure TwitterCallBackProc(Sender: TObject);
    procedure suitempcmdKonekClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure InetSessionProgress(Sender: TObject; hInet: Pointer;
      Progress, ProgressMax, StatusCode: Cardinal; StatusText: String;
      ElapsedTime, EstimatedTime: TDateTime; Speed: Extended;
      SpeedUnit: String);
    procedure InetHttpProgress(Sender: TObject; hInet: Pointer; Progress,
      ProgressMax, StatusCode: Cardinal; StatusText: String; ElapsedTime,
      EstimatedTime: TDateTime; Speed: Extended; SpeedUnit: String);
    procedure InetConProgress(Sender: TObject; hInet: Pointer; Progress,
      ProgressMax, StatusCode: Cardinal; StatusText: String; ElapsedTime,
      EstimatedTime: TDateTime; Speed: Extended; SpeedUnit: String);
    procedure BMDThread1Execute(Sender: TObject; Thread: TBMDExecuteThread;
      var Data: Pointer);
    procedure BMDThread1Terminate(Sender: TObject;
      Thread: TBMDExecuteThread; var Data: Pointer);
    procedure tmrTweetTimer(Sender: TObject);
    procedure suitemptxtTwitChange(Sender: TObject);
    procedure suitempcmdApplyClick(Sender: TObject);
    procedure suitempcmdClearTokenClick(Sender: TObject);
    procedure cmdClementineClick(Sender: TObject);
    procedure cmdJetAudioClick(Sender: TObject);
    procedure suitempscrollmediaChange(Sender: TObject);
    procedure mnuShowMainClick(Sender: TObject);
    procedure mnuQuitClick(Sender: TObject);
    procedure mnuTweetClick(Sender: TObject);
    procedure suitempcmdUpdateClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormShow(Sender: TObject);
    procedure suitempchkAutoTweetClick(Sender: TObject);
    procedure TrayClick(Sender: TObject);
    procedure cmdWinampClick(Sender: TObject);
    procedure cmdVLCClick(Sender: TObject);
    procedure suitempcmdCreditsClick(Sender: TObject);
    procedure lblEditMetaClick(Sender: TObject);
    procedure suitempcmdEditOkeClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure lblCustomClick(Sender: TObject);
    procedure suitempcmdManualClick(Sender: TObject);
    procedure TrayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure tmrTipsTimer(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure cmdWMPClick(Sender: TObject);
    procedure cmdITunesClick(Sender: TObject);

  private
    { Private declarations }
    function cekUpdate () : Boolean;
    procedure tampilMood;
  public
    WMPAvailable            : Boolean;
    iTunesAvailable         : Boolean;
    Art,Jdl                 : String;
    customArtis, customTrack,
    tempCustom              : String;
    ServerUtama             : String;
    AlamatDownload          : String;
    { Public declarations }
    function getClementine (var Artis : String; var Judul : String): String;
    function getJetAudio (var Artis : String; var Judul : String): String;
    function getWinamp (var Artis : String; var Judul : String): String;
    function getVLC (var Artis : String; var Judul : String) : String;
    function getWMP (var Artis : String; var Judul : String) : String;
    function getiTunes (var Artis : String; var Judul : String) : String;
    procedure SaveSettings;
  end;

  // fungsi registrasi DLL
  TDllRegisterServer = function: HResult; stdcall;


const server = 'http://cahkoding.3owl.com/TMS/aksesData.php';
      serverUpdate = 'http://www.ukdwnetclub.com/bonggie/TMS/version.txt';
      serverTetap = 'http://ukdwnetclub.com/bonggie/TMS/';

var
  frmMain                 : TfrmMain;
  Twit                    : TwitterCli;
  Authenticated           : boolean = false;
  BolehTweet              : Boolean = false;
  Stop                    : Boolean = false;
  MediaSelector           : byte;       // Media player yang aktif;
  LastTitle               : String;
  GetJudul                : String;
  BahasaDipakai           : String;
  Token, TokenSc          : String;
  Bad, Happy, counter,
  total, I                : integer;
  Custom,Awal             : Boolean;
  Player                  : array [0..5] of String =('Clementine','JetAudio','Winamp','VLC','WMP','iTunes');
  Tips                    : array [0..5] of String;


implementation

uses Unicode, FungsiLain, update, Credits, CustomLirik;

{$R *.dfm}

const sWelcome1           = 'Welcome to #TwitMySong, waiting detector song to get song info ...';
      sWelcome2           = 'Welcome to #TwitMySong click on Connect with Twitter to get started!';
      sStConnect          = 'Connected, waiting song detector...';
      sConnect            = 'Connected to twitter, now waiting song detector ...';
      sEnterPIN           = 'Waiting PIN from login window ...';
      sPIN                = 'Enter PIN...';
      sStSent             = 'Tweet sent.';
      sConnected          = 'Connect with Twitter!';
      sConnecting         = 'Connecting to Twitter ...';
      sNumber             = 'PIN is wrong, should contain only numbers';
      sOver               = 'Text length more than 140 characters, please check again your tweet template.';
      sNotPlaying         = '#TwitMySong not detected any song played.';
      sGetSong            = 'Getting song info';
      sNowPlaying         = 'Now Playing';
      sBy                 = 'by';
      sRequestQuote       = 'Requesting Quote...';
      sHappyListen        = 'happy songs listened';
      sSadListen          = 'sad songs listened';
      sServerError        = 'Server error, could not get quote..';
      sClearToken         = 'This will disconnect the program from Twitter account.'+Chr(13)+'Do you want to contiune?';
      sDisconnect         = 'Disconnected from twitter, press Connect with Twitter to connect again!';
      sClearFail          = 'Failed to clear token, make sure that you''''re administrator';
      sClearFailTittle    = 'Failed Clear Token';
      sChangeLanguage     = 'Language changed, please restart to take effect.';
      sAutoWarning        = 'This will activate auto tweet when music change,'+Chr(13)+'please consider if your friend hate flood on their timeline.'+Chr(13)+'You can set thet weet timer to tweet every X song you want. '+Chr(13)+Chr(13)+'Do you want to activate auto tweet ?';
      sLastUpdate         = 'You have the latest update :)';
      sNewUpdate          = 'New #TwitMySong update found, do you want to update ?';
      sWMPPlugNotFound    = 'Windows Media Player plugin not found, do you want to download it?';
      sWMPNotInstall      = 'Windows Media Player plugin not installed yet, do you want to install it now ?';
      sFailWMP            = 'Failed to install WMP plugin, please run #TwitMySong as administrator';
      sSuccessWMP         = 'Windows Media Player plugin has been installed successfully.';
      siTunesPlugNotFound = 'iTunes plugin not found, do you want to download it?';
      siTunesNotInstall   = 'iTunes plugin not installed yet, do you want to install it now ?';
      sSuccessiTunes      = 'iTunes plugin has been installed successfully. Please restart iTunes to take effect.';
      sFailiTunes         = 'Failed to install iTunes plugin, please run #TwitMySong as administrator';
      Tips1               = 'You can customize the ''auto-generated'' lyrics by clicking Custom Lyrics.';
      Tips2               = 'No Lyrics found ? Maybe your song information (artist/title) is invalid, edit manually by Edit Metadata menu';
      Tips3               = 'Playlist mood show your entire songs mood inside your playlist, not just single song';
      Tips4               = 'Set amount of tweet every song option if you don''t want to flood your friends timeline :)';
      Tips5               = 'Follow @TwitMySong to get new update or another information. Thanks for using :)';

procedure InisialisasiTips;
begin
  Tips[0] := misc(Tips1,'Tips1');
  Tips[1] := misc(Tips1,'Tips2');
  Tips[2] := misc(Tips1,'Tips3');
  Tips[3] := misc(Tips1,'Tips4');
  Tips[4] := misc(Tips1,'Tips5');
end;

function RegisterOCX(FileName: string): Boolean;
var
  OCXHand: THandle;
  RegFunc: TDllRegisterServer;
begin
  OCXHand := LoadLibrary(PChar(FileName));
  RegFunc := GetProcAddress(OCXHand, 'DllRegisterServer');
  if @RegFunc <> nil then Result := RegFunc = S_OK
  else Result := False;
  FreeLibrary(OCXHand);
end;

function UnRegisterOCX(FileName: string): Boolean;
var
  OCXHand: THandle;
  RegFunc: TDllRegisterServer;
begin
  OCXHand := LoadLibrary(PChar(FileName));
  RegFunc := GetProcAddress(OCXHand, 'DllUnregisterServer');
  if @RegFunc <> nil then Result := RegFunc = S_OK
  else Result := False;
  FreeLibrary(OCXHand);
end;

procedure ReadTextFile(namaFile : String; var Title, Artis : String);
var
  myFile : TextFile;
  text   : string;
begin
  if FileExists(namaFile) then
  begin
    try
      AssignFile(myFile, namaFile);
      Reset(myFile);
      ReadLn(myFile, Artis);
      ReadLn(myFile, Title);

      CloseFile(myFile);
    except
      Artis := 'e';
      Title := 'e';
    end;
  end
else
  begin
    Artis := 'e';
    Title := 'e';
  end;
end;


procedure Split (const Delimiter: Char;  Input: string;  const Strings: TStrings);
begin
   Assert(Assigned(Strings)) ;
   Strings.Clear;
   Strings.Delimiter := Delimiter;
   Strings.DelimitedText := Input;
end;

function CekAngka(s: string): Boolean; // check apakah semuanya angka
Var b: integer;
    MySet: set of '0'..'9';
begin
  if s = '' then Result := false;

  MySet  := ['0'..'9'];
  Result := True;

  for b := 1 to length(s) do
   if not (s[b] in MySet) then Result := True;
end;


procedure TfrmMain.SaveSettings;
Var ts : TStringList;
    path : String;
begin
  path := ExtractFilePath(Application.ExeName) + 'settings.temp';
  ts := TStringList.Create;
  ts.Add(Token);
  ts.Add(TokenSc);

  if (chkAutoTweet.Checked = true) then
    ts.Add(IntToStr(tmrTweet.Interval))
  else
    ts.Add('-1');

  if (chkSwap.Checked = true) then
    ts.Add('Swap')
  else
    ts.Add('noSwap');

  ts.Add(cmbBahasa.Text);

  if (BahasaDipakai <> cmbBahasa.Text) then
    MessageBox(0,PChar(misc(sChangeLanguage,'sChangeLanguage')),'Information',MB_OK + MB_ICONINFORMATION) else

  Application.ProcessMessages;
  ts.SaveToFile(path);
  ts.Free;
end;


procedure TfrmMain.FormCreate(Sender: TObject);
var ts : TStringList;
begin
  // insialisasi variable
  bad := 0;
  happy := 0;
  frmMain.Width := 322;
  customArtis := '';
  customTrack := '';
  Custom := false;
  ServerUtama := server;

  // Load settings
  if FileExists(ExtractFilePath(application.ExeName) + 'settings.temp') then
  begin
    cmdClearToken.Enabled := true;
    ts := TStringList.Create;
    ts.LoadFromFile(ExtractFilePath(application.ExeName) + 'settings.temp');
    if ts.Count = 5 then
    begin
      Token := ts[0];
      Tokensc := ts[1];
      if (ts[2] <> '-1') then
      begin
        tmrTweet.Interval := StrToInt(ts[2]);
        tmrTweet.Enabled := true;
        txtTwitTimer.Text := ts[2];
      end
     else
      begin
        tmrTweet.Enabled := false;
        txtTwitTimer.Enabled := false;
      end;
      if (ts[3] = 'Swap') then chkSwap.Checked := true;

      CL := loadIni('Language\'+ts[4]+'.ini');
      if CL<>nil then fillProps([frmMain],CL);
      cmbBahasa.Text := ts[4];
      BahasaDipakai  := ts[4];
     end;
    ts.Free;
  end;

  if (Token <> '') and (TokenSc <> '') then
  begin
    txtTwit.Text := misc(sWelcome1,'sWelcome1');
    Authenticated := True
  end
 else
    txtTwit.Text := misc(sWelcome1,'sWelcome2');


  Twit := TwitterCli.Create(TKey,TSecret);
  if (Authenticated) then
  begin
    cmdKonek.Caption := 'Tweet !';
    Timer1.Enabled := true;
  end;


  with Twit do
  begin
    OnReqDone := TwitterCallBackProc;
    if Authenticated then SetStoredLogin(Token,Tokensc);
    RefURL := 'http://fcompware.blogpsot.com';
  end;

  InisialisasiTips;

  
end;

procedure TfrmMain.TwitterCallBackProc(Sender: TObject);
begin
  Memo1.Lines.Add('http response :' + inttostr(twit.LastHttpStatus));
  Memo1.Lines.SaveToFile('debug.txt');

  // Mung marai DC
  if (Twit.LastHttpStatus <> 200) AND (Twit.LastHttpStatus <> 403) AND (Twit.LastHttpStatus <> 401) AND (Twit.LastHttpStatus <> 400) AND (Twit.LastHttpStatus <> 0) then
  begin
    StatusBar.Panels[0].Text := 'Failed to tweet, try again later.';
  end;


  if (Twit.LastReq = trLogin) and (Twit.LastInternalReq = trRequestAccess) then
  begin
    StatusBar.Panels[0].Text := misc(sStConnect, 'StConnect');
    Timer1.Enabled := true;
    cmdManual.Visible := false;
    main.frmMain.cmdKonek.Enabled := true;
    cmdKonek.Caption  := 'Tweet !';
    txtTwit.Text := misc(sConnect, 'sConnect');
    Authenticated  := True;

    Token := Twit.AccessToken;
    TokenSc := Twit.AccessTokenSecret;
    SaveSettings;
    Exit;
  end;

  if Twit.LastReq = trLogin then
  begin // ambil PIN dulu
    txtTwit.Text := misc(sEnterPin, 'sEnterPIN');
    txtTwit.Enabled := false;
    cmdManual.Visible := true;
    cmdKonek.Enabled := false;
    cmdKonek.Caption := misc(sPIN,'sPIN');
    Timer1.Enabled := false;
    Exit;
  end;

  if twit.LastReq = trTwit then
  begin
    StatusBar.Panels[0].Text := misc(sStSent,'sStSent');
    Exit;
  end;
end;

procedure TfrmMain.suitempcmdKonekClick(Sender: TObject);
begin
  if (cmdKonek.Caption = misc(sConnected,'sConnected')) then
  begin
    StatusBar.Panels[0].Text := misc(sConnecting,'sConnecting');
    Authenticated  := False;
    DeleteFile(ExtractFilePath(application.ExeName) + 'settings.temp');
    LastTitle := '';
    Twit.Login(tlPin, true);
  end
 else
  if (cmdKonek.Caption = misc(sPIN,'sPIN')) then
  begin
    if not Authenticated then
    begin
      LastTitle := '';
      if Twit.LastReq <> trLogin then Exit;
      if not CekAngka(txtTwit.Text) then
      begin
        ShowMessage(misc(sNumber,'sNumber'));
        Exit;
      end;
      Twit.AccessPIN := txtTwit.Text;
      Twit.ContinuePINLogin;
    end;
  end
 else if (cmdKonek.Caption = 'Tweet !') then
 begin
   if (Length (txtTwit.Text) > 140) then MessageBox (0,PChar(misc(sOver,'sOver')),'Cannot tweet',MB_OK + MB_ICONWARNING) else
     if (txtTwit.Text <> misc(sNotPlaying, 'sNotPlaying')) then Twit.SendTwit(txtTwit.Text);
 end;
end;

function TfrmMain.getWinamp(var Artis : String; var Judul : String): String;
var Winamp : hwnd;
    CaptionLength : Integer;
    Title : String;
begin

  StatusBar.Panels[0].Text := misc(sGetSong,'sGetSong') + ' ... [Winamp] ';
  Winamp := findwindow('Winamp v1.x',nil);
  CaptionLength := GetWindowTextLength(Winamp);
  SetLength(title, CaptionLength);
  GetWindowText(Winamp, PChar(title), CaptionLength + 1);
  Title  := Copy(Title, 0, CaptionLength-9);

  if pos('Winamp',  Title) > 0 then
    Title := Copy(Title, 0, CaptionLength - 19);

  Artis  := Copy (Title, Pos('.', Copy(Title, 0, 5))+2,Pos('-',Title)-5);
  Judul  := Copy (Title, Pos('-', Title)+2, Length(Title));
  Result := Artis + ' - '+ Judul;
  StatusBar.Panels[0].Text := 'Standby ... ';
  if (Length(Artis) < 2) Or (Length(Judul) < 2) then
  begin
    Result := 'notplaying';
  end;
end;

function TfrmMain.getJetAudio (var Artis : String; var Judul : String): String;
var
  hwndForeground: HWND;
  titleLength: Integer;
  title : string;
begin
  stop := false;
  StatusBar.Panels[0].Text := misc(sGetSong,'sGetSong') + ' ... [JetAudio]';
  while (not Stop) do
  begin
    hwndForeground := Findwindow('COWON Jet-Audio MainWnd Class',nil);
    titleLength := GetWindowTextLength(hwndForeground);
    SetLength(title, titleLength);
    GetWindowText(hwndForeground, PChar(title), titleLength + 1);
    Application.ProcessMessages;
   // txtTwit.Lines.Add(title);
    if (pos('jetAudio', title) > 0) then
    begin
      Stop := true;
    end;
    sleep(5);
  end;

  // parsing judul
  title  := Copy(title, pos(']', title)+2, pos('[', Copy(title, pos(']', title), length(title)))-4);
  Artis  := Copy(title, 0, pos(' / ',Copy(title,0, length(title)-2))-1);
  StatusBar.Panels[0].Text := 'Standby ... ';
  Judul  := Copy(title, pos(' / ', title)+3, length(title));
  Result := Artis+'-'+Judul;
  if (Length(Artis) < 2) Or (Length(Judul) < 2) then
  begin
    Result := 'notplaying';
  end;
end;

function TfrmMain.getClementine (var Artis : String; var Judul : String): String;
var
  hwndForeground: HWND;
  titleLength: Integer;
  title: string;
begin
  StatusBar.Panels[0].Text := misc(sGetSong,'sGetSong') + ' ... [Clementine]';
  hwndForeground := GetHWNDByPID(GetProcessID('clementine.exe'));

  titleLength := GetWindowTextLength(hwndForeground);
  SetLength(title, titleLength);
  GetWindowText(hwndForeground, PChar(title), titleLength + 1);

  Artis  := Copy (title, 0, Pos('-',title)-2);
  Judul  := Copy (title, Pos('-', title) + 2, Length(title));

  Result := Artis +' - ' +Judul;
  if (Length(Artis) < 2) Or (Length(Judul) < 2) then
  begin
    Result := 'notplaying';
  end;

end;

function TfrmMain.getVLC (var Artis : String; var Judul : String): String;
var
  hwndForeground: HWND;
  titleLength: Integer;
  title: string;
begin
  StatusBar.Panels[0].Text := misc(sGetSong,'sGetSong') + ' ... [VLC]';
  hwndForeground := GetHWNDByPID(GetProcessID('vlc.exe'));
  titleLength := GetWindowTextLength(hwndForeground);
  SetLength(title, titleLength);
  GetWindowText(hwndForeground, PChar(title), titleLength + 1);
  title  := Copy (title, 0, Length(title)-19);

  Judul  := Copy (title, 0, Pos('-',title)-2);
  Artis  := Copy (title, Pos('-', title) + 2, Length(title));

  Result := Artis +' - ' +Judul;
  if (Length(Artis) < 2) Or (Length(Judul) < 2) then
  begin
    Result := 'notplaying';
  end;
end;

function TfrmMain.getWMP (var Artis : String; var Judul : String): String;
var
  title : string;
  art,jdl : String;
begin
  Result := 'notplaying';
  StatusBar.Panels[0].Text := misc(sGetSong,'sGetSong') + ' ... [WMP]';
  ReadTextFile (GetEnvironmentVariable('TEMP') + '\wmpplugin.txt',jdl, art);

  Judul  := jdl;
  Artis  := art;
  Result := Artis +' - ' +Judul;

  if (Length(Artis) <= 1) AND (Length (Judul) <=1) then
  begin
    Result := 'notplaying';
  end
 else if (Length(Artis) < 2) or (Length(Judul) < 2) then
  begin
    if (Length (Artis) < 2) then
    begin
      Result := Judul;
      Artis  := 'Unknown';
    end;
    if (Length (Judul) < 2) then
    begin
      Result := Artis;
      Judul  := 'Unknown';
    end;
  end

end;

function TfrmMain.getiTunes (var Artis : String; var Judul : String): String;
var
  title : string;
  art,jdl : String;
begin
  Result := 'notplaying';
  StatusBar.Panels[0].Text := misc(sGetSong,'sGetSong') + ' ... [iTunes]';
  ReadTextFile (GetEnvironmentVariable('TEMP') + '\itunesplugin.txt',jdl, art);

  if (Length(jdl) > 100) then jdl := Copy(jdl, 0, 100);
  if (Length(art) > 100) then art := Copy(art, 0, 100);

  Judul  := jdl;
  Artis  := art;
  Result := Artis +' - ' +Judul;

  if (Length(Artis) <= 1) AND (Length (Judul) <=1) then
  begin
    Result := 'notplaying';
  end
 else if (Length(Artis) < 2) or (Length(Judul) < 2) then
  begin
    if (Length (Artis) < 2) then
    begin
      Result := Judul;
      Artis  := 'Unknown';
    end;
    if (Length (Judul) < 2) then
    begin
      Result := Artis;
      Judul  := 'Unknown';
    end;
  end

end;



procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  if Authenticated then cmdCleartoken.Enabled := true;

  mnuTweet.Checked := chkAutoTweet.Checked;
  tmrTweet.Enabled := mnuTweet.Checked;
  txtTwitTimer.Enabled := tmrTweet.Enabled;
  chkAutoTweet.Enabled := Authenticated;
  if (customTrack <> '') AND (customArtis <> '') AND (frmMain.Width < 400) then
  begin
    lblCustom.Enabled := true;
    lblEditMeta.Enabled := True
  end
 else
  begin
    lblCustom.Enabled := false;
    lblEditMeta.Enabled := false;
  end;
  BMDThread1.Start;

  // Cek media player yang aktif
  if (GetProcessID('clementine.exe') = 0) then
    cmdClementine.Enabled := false
  else
   begin
     cmdClementine.Enabled := true;
   end;

  if (GetProcessID('JetAudio.exe') = 0) then
    cmdJetAudio.Enabled := false
  else
   begin
     cmdJetAudio.Enabled := true;
   end;

  if (GetProcessID('winamp.exe') = 0) then
    cmdWinamp.Enabled := false
  else
   begin
     cmdWinamp.Enabled := true;
   end;

   if (GetProcessID('vlc.exe') = 0) then
    cmdVLC.Enabled := false
  else
   begin
     cmdVLC.Enabled := true;
   end;

   if (GetProcessID('wmplayer.exe') = 0) then
    cmdWMP.Enabled := false
  else
    cmdWMP.Enabled := true;

  if (GetProcessID('iTunes.exe') = 0) then
    cmdITunes.Enabled := false
  else
    cmdITunes.Enabled := true;
end;

procedure TfrmMain.InetSessionProgress(Sender: TObject; hInet: Pointer;
  Progress, ProgressMax, StatusCode: Cardinal; StatusText: String;
  ElapsedTime, EstimatedTime: TDateTime; Speed: Extended;
  SpeedUnit: String);
begin
  Application.ProcessMessages;
end;

procedure TfrmMain.InetHttpProgress(Sender: TObject; hInet: Pointer;
  Progress, ProgressMax, StatusCode: Cardinal; StatusText: String;
  ElapsedTime, EstimatedTime: TDateTime; Speed: Extended;
  SpeedUnit: String);
begin
  Application.ProcessMessages;
end;

procedure TfrmMain.InetConProgress(Sender: TObject; hInet: Pointer;
  Progress, ProgressMax, StatusCode: Cardinal; StatusText: String;
  ElapsedTime, EstimatedTime: TDateTime; Speed: Extended;
  SpeedUnit: String);
begin
  Application.ProcessMessages;
end;

procedure TfrmMain.BMDThread1Execute(Sender: TObject;
  Thread: TBMDExecuteThread; var Data: Pointer);
var Swap : String;
begin
  if (Awal) then
  begin
     if (ieServer.CheckIEOnline = true) then
       ieServer.ExecuteURL(serverTetap + 'server.txt')
     else
       MessageBox(0, 'You''re not connected to internet.'+chr(13)+'This application wouldn''t work without internet connection.', 'No Internet', +mb_OK +mb_ICONWARNING);
  end
else if (not Awal) then
 begin
  // Pilihan media
  begin

    case MediaSelector of
      0 : begin
            GetJudul := getClementine (Art, Jdl);
          end;
      1 : begin
            GetJudul := getJetAudio (Art, Jdl);
          end;
      2 : begin
            GetJudul := getWinamp (Art, Jdl);
           end;
      3 : begin
            GetJudul := getVLC (Art, Jdl);
          end;
      4 : begin
            GetJudul := getWMP (Art, Jdl);
          end;
      5 : begin
            GetJudul := getiTunes(Art, Jdl);
          end;
    end;

    // Filter ben ra kedobel
    if (tempCustom = Art+Jdl) then
    begin
      Art := '';
      Jdl := '';
    end
    else
     tempCustom := Art+Jdl;
  end;

  if ((customArtis <> '') and (customArtis <> Art)) and ((customTrack <> '') and (customTrack <> Jdl) and (Custom))then //and (Art <> '') and (Jdl <> '')) then
  begin
    Art := customArtis;
    Jdl := customTrack;
   // customArtis := '';
   // customTrack := '';
    Custom := False;
  end;

  if (chkSwap.Checked) then
  begin
    Swap := Jdl;
    Jdl  := Art;
    Art := Swap;
    if (GetJudul <> 'notplaying') then GetJudul := Art + ' - ' + Jdl;
  end;

  If (Art <> '') AND (Jdl <> '') then
  begin

    if (GetJudul <> 'notplaying') then
    begin
      txtTwit.text := '#np '+ Art + ' - '+ jdl + ' #TwitMySong';
      Tray.ShowBalloonHint('['+Player[MediaSelector]+'] ' + misc(sNowPlaying,'sNowPlaying') , misc(sNowPlaying,'sNowPlaying')+' '+jdl+ ' '+misc(sBy,'sBy')+' '+ art, bitInfo, 10);
      StatusBar.Panels[0].Text := misc(sRequestQuote,'sRequestQuote');

      ie.postStr := 'p=text&artis='+Art+'&lagu='+Jdl;

      if (ie.CheckIEOnline = true) then
        ie.ExecuteURL(ServerUtama)
      else
        MessageBox(0, 'You''re not connected to internet.'+chr(13)+'This application wouldn''t work without internet connection.', 'No Internet', +mb_OK +mb_ICONWARNING);
    end
  else
    txtTwit.text := misc(sNotPlaying,'sNotPlaying');
  end;
 end;
end;

procedure TfrmMain.tampilMood;
begin
  total := happy - bad;
  moodHappy.MaxValue := (happy+bad);
  moodHappy.Hint := IntToStr(happy) + ' '+ misc(sHappyListen,'sHappyListen');
  moodSad.MaxValue := (happy+bad);
  moodSad.Hint := IntToStr(bad) + ' ' + misc(sHappyListen,'sSadListen');

  if (total > 0) then
  begin
    moodHappy.Progress := total;
    moodSad.Progress := moodSad.MaxValue;
  end
 else if (total < 0) then
  begin
    moodSad.Progress := moodSad.MaxValue - (total * -1);
    moodHappy.Progress := 0;
  end
 else
  begin
    moodSad.MaxValue := 1;
    moodSad.Progress := moodSad.MaxValue;
    moodHappy.Progress := 0;
  end;

end;

procedure TfrmMain.BMDThread1Terminate(Sender: TObject;
  Thread: TBMDExecuteThread; var Data: Pointer);
var ambil_data, mood : string;
begin

  if (Awal) then
  begin
    if (Length(ieServer.sl.Text) > 10) then
      ServerUtama := Copy(ieServer.sl.Text,0,length(ieServer.sl.Text)-2) + 'TMS/aksesData.php';

      Awal := false;
  end
else
 begin
  if (Length(Art) > 1) and (Length(Jdl) > 1) and (not Awal) and (ie.sl.Text <>'') then
  begin
    customArtis := Art;
    customTrack := Jdl;
    ambil_data := Copy(ie.sl.Text,0, length(ie.sl.Text)-2);
    if (ord(ie.sl.Text[1]) = 13) then
      ambil_data := Copy(ambil_data,3, length(ambil_data));


    if ((Pos('"</', ambil_data) > 0) or (Pos('http', ambil_data) > 0) or (Pos('"Fatal Error', ambil_data) > 0) or (Pos('!DOCTYPE HTML', ambil_data) > 0) or (Pos('Warning: mysql_connect():', ambil_data)> 0)) then
    begin
      txtTwit.text := '#np '+ Art + ' - ' + Jdl + ' #TwitMySong' +' #'+Player[MediaSelector];
      StatusBar.Panels[0].Text := misc(sServerError,'sServerError');
    end
   else
    begin
     if (Getjudul <> 'notplaying') and (ambil_data <> '') then
     begin
       if (length(ambil_data) > 1) AND (ambil_data <> 'Tidak Ketemu') AND (Pos('<br />', ambil_data) <= 0) then
        begin

          txtTwit.Text := '"'+Copy(ambil_data,0,length(ambil_data)-1)+'" #np '+ Art + ' - ' + Jdl + ' #TwitMySong' +' #'+Player[MediaSelector];
          BolehTweet := true;
          mood := Copy(Ambil_data, length(ambil_data), length(Ambil_data));
          if (Ord(mood[1]) = 46) then
            inc(happy)
          else if (Ord(mood[1]) = 96) then
            inc (bad)
          else if (Ord(mood[1]) = 39) then
          begin
            inc(happy, random(1));
            inc(bad, random(1));
          end;

          tampilMood;
        end
       else
        begin
          txtTwit.text := '#np '+ Art + ' - ' + Jdl + ' #TwitMySong' +' #'+Player[MediaSelector];
          BolehTweet := true;
        end;
        StatusBar.Panels[0].Text :=  'Standby ...';
     end
     else
      txtTwit.text := misc(sNotPlaying,'sNotPlaying');
    end;
  end;
 end;
end;

procedure TfrmMain.tmrTweetTimer(Sender: TObject);
begin
  if (Authenticated) AND (BolehTweet) then
  begin
    StatusBar.Panels[0].Text := 'Tweeting...';
    if (LastTitle <> customArtis+customTrack) then
    begin
      inc(counter);
      LastTitle := customArtis + customTrack;
    end;

    if (counter = StrToInt(txtTwitTimer.Text)) and (txtTwit.Text <> misc(sNotPlaying,'sNotPlaying')) then
    begin
      Twit.SendTwit(WideStringToUTF8(txtTwit.Text));
      counter := 0;
    end;
    BolehTweet := false;
  end;
end;

procedure TfrmMain.suitemptxtTwitChange(Sender: TObject);
begin
  lblPanjang.Caption := IntToStr(140 - Length (txtTwit.Text));
end;

procedure TfrmMain.suitempcmdApplyClick(Sender: TObject);
begin
  tmrTweet.Interval := StrtoInt(txtTwitTimer.Text);
  counter := 0;
  savesettings;
end;

procedure TfrmMain.suitempcmdClearTokenClick(Sender: TObject);
begin
  if MessageBox(0, PChar(misc(sClearToken,'sClearToken')), 'Clear Token', +mb_YesNo +mb_ICONWARNING) = 6 then
  begin
    try
      if Deletefile(ExtractFilePath(application.ExeName) + 'settings.temp') then
      begin
        Authenticated := false;
        cmdClearToken.Enabled := false;
        cmdKonek.Caption := misc(sConnected,'sConnected');
        Timer1.Enabled := false;
        StatusBar.Panels[0].Text := 'Standby ...';
        txtTwit.Text := misc(sDisconnect,'sDisconnect');
      end
     else
        MessageBox(0, PChar(misc(sClearFail, 'sClearFail')), PChar(misc(sClearFailTittle,'sClearFailTittle')), mb_ok + mb_iconwarning);
    except
    end;
  end;

end;

procedure TfrmMain.cmdClementineClick(Sender: TObject);
begin
  MediaSelector := 0;
  Stop := true;
end;

procedure TfrmMain.cmdJetAudioClick(Sender: TObject);
begin
  MediaSelector := 1;
end;

procedure TfrmMain.suitempscrollmediaChange(Sender: TObject);
begin
  PanelGeser.Left := ScrollMedia.Position * (-33);
end;

procedure TfrmMain.mnuShowMainClick(Sender: TObject);
begin
  Tray.ShowMainForm;
end;

procedure TfrmMain.mnuQuitClick(Sender: TObject);
begin
  Stop := true;
  Halt;
end;

procedure TfrmMain.mnuTweetClick(Sender: TObject);
begin
  mnuTweet.Checked := not mnuTweet.Checked;
  if (mnuTweet.Checked = true) then
   if MessageBox(0, PChar(misc(sAutoWarning,'sAutoWarning')), 'Auto tweet', +mb_YesNo +mb_ICONWARNING) = 6 then
   begin
     tmrTweet.Enabled := chkAutoTweet.Checked;
     chkAutoTweet.Checked := true;
   end;
end;

function TfrmMain.cekUpdate () : Boolean;
var h,t1,t2,b : integer;
    hasil,cur : String;
    A,C       : TStringList;
begin
  cekUpdate := false;
  ie.ExecuteURL(serverUpdate);
  hasil := ie.sl.Text;
  if (Pos('<!DOCTYPE', hasil) <= 0) AND (Length(hasil) < 11) then
  begin
    A := TStringList.Create;
    Split('.', hasil, A);
    h  := StrToInt(A[0]);
    t1 := StrToInt(A[1]);
    t2 := StrToInt(A[2]);
    b  := StrToInt(A[3]);

    cur := GetVersion(Application.ExeName);
    C   := TStringList.Create;
    Split('.', cur, C);

    // cek versi, jika versi lebih besar maka ada yang terbaru
    if (h > StrToInt(C[0])) then cekUpdate := True;
    if (t1 > StrToInt(C[1])) then cekUpdate := True;
    if (t2 > StrToInt(C[2])) then cekUpdate := True;
    if (b > StrToInt(C[3])) then cekUpdate := True;
    AlamatDownload := 'http://www.ukdwnetclub.com/bonggie/TMS/Version/'+A[0]+A[1]+A[2]+A[3]+'/twitsong.exe';
  end;
end;

procedure TfrmMain.suitempcmdUpdateClick(Sender: TObject);
begin
  if (cekUpdate() = true) then
     frmUpdate.Show
  else
     MessageBox(0, PChar(misc(sLastUpdate,'sLastUpdate')) , 'Update', mb_ok + mb_iconinformation);
end;

procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := false;
  Tray.HideMainForm;
end;

procedure TfrmMain.FormShow(Sender: TObject);
var Data: TAppBarData;
    add : integer;
    edit: String;
begin
  I := 0;
  WMPAvailable := false;
  iTunesAvailable := false;
  if (FileExists(ExtractFilePath(Application.ExeName) + 'TMSWmp.dll')) then WMPAvailable := true;
  if (FileExists(ExtractFilePath(Application.ExeName) + 'TMStunes.dll')) then iTunesAvailable := true;
  try
    filebox.Directory := ExtractFilePath(Application.ExeName) + '\Language\';
    for add := 0 to filebox.Count-1 do
    begin
      edit := StringReplace(filebox.Items[add],'.ini','',[rfReplaceAll, rfIgnoreCase]);
      cmbBahasa.Items.Add(edit);
    end;
  except
  end;

  lblVersi.Caption := GetVersion(Application.ExeName);
  self.Caption := '#TwitMySong v.' + GetVersion(Application.ExeName) + ' [BETA]';
  suiform1.Caption := '#TwitMySong v.' + GetVersion(Application.ExeName) + ' [BETA]';


  if (ie.CheckIEOnline = true) then
  begin
    if (CekUpdate = true) then
      if (MessageBox(0, PChar(misc(sNewUpdate,'sNewUpdate')) ,'Update',mb_yesno + mb_iconinformation) = 6) then
        cmdUpdate.Click;
  end
 else
   MessageBox(0, 'You''re not connected to internet.'+chr(13)+'This application wouldn''t work without internet connection.', 'No Internet', +mb_OK +mb_ICONWARNING);

  Awal := true;
  BMDThread1.Start;

  if (Authenticated) then
  begin

    // Cek media player yang aktif
   if (GetProcessID('wmplayer.exe') = 0) or (not WMPAvailable) then
     cmdWMP.Enabled := false
   else
   begin
     cmdWMP.Down := true;
     cmdWMP.Click;
     MediaSelector := 4;
   end;

   if (GetProcessID('iTunes.exe') = 0) or (not WMPAvailable) then
    cmdiTunes.Enabled := false
   else
   begin
     cmdiTunes.Down := true;
     cmdiTunes.Click;
     MediaSelector := 5;
   end;

   if (GetProcessID('clementine.exe') = 0) then
     cmdClementine.Enabled := false
   else
    begin
      cmdClementine.Down := true;
      MediaSelector := 0;
    end;

   if (GetProcessID('JetAudio.exe') = 0) then
     cmdJetAudio.Enabled := false
   else
    begin
      cmdJetAudio.Down := true;
      MediaSelector := 1;
    end;

   if (GetProcessID('winamp.exe') = 0) then
     cmdWinamp.Enabled := false
   else
    begin
      cmdWinamp.Down := true;
      MediaSelector := 2;
    end;

   if (GetProcessID('vlc.exe') = 0) then
     cmdVLC.Enabled := false
   else
    begin
      cmdVLC.Down := true;
      MediaSelector := 3;
    end;
  end;

  lblTips.Caption := Tips[0];
end;

procedure TfrmMain.suitempchkAutoTweetClick(Sender: TObject);
begin
  if (chkAutoTweet.Checked = true) then
   if MessageBox(0, PChar(misc(sAutoWarning,'sAutoWarning')), 'Auto tweet', +mb_YesNo +mb_ICONWARNING) = 6 then
     tmrTweet.Enabled := chkAutoTweet.Checked;
end;

procedure TfrmMain.TrayClick(Sender: TObject);
begin
  Tray.ShowMainForm;
end;

procedure TfrmMain.cmdWinampClick(Sender: TObject);
begin
  MediaSelector := 2;
end;

procedure TfrmMain.cmdVLCClick(Sender: TObject);
begin
  MediaSelector := 3;
end;

procedure TfrmMain.suitempcmdCreditsClick(Sender: TObject);
begin
  frmCredits.show;
end;


procedure TfrmMain.lblEditMetaClick(Sender: TObject);
var width : integer;
begin
  width := 150;
  lblEditMeta.Enabled := false;
  frmMain.Width := 470;
  frmMain.Left  := frmMain.Left - width;
  txtMetaArtist.Text := customArtis;
  txtMetaTrack.Text := customTrack;
end;

procedure TfrmMain.suitempcmdEditOkeClick(Sender: TObject);
begin
  frmMain.Width := 322;
  frmMain.Left  := frmMain.Left + 150;
  lblEditMeta.Enabled := True;

  begin
    customArtis := txtMetaArtist.Text;
    customTrack := txtMetaTrack.Text;
    Custom := True;
    BMDThread1.Start;
  end;
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  inc(happy);
  tampilMood;
end;

procedure TfrmMain.lblCustomClick(Sender: TObject);
begin
  frmCustom.Show;
end;

procedure TfrmMain.suitempcmdManualClick(Sender: TObject);
begin
  txtTwit.Enabled := true;
  cmdManual.Visible := false;
  cmdKonek.Enabled := true;
end;

procedure TfrmMain.TrayMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbRight) then
    PopupMenu1.Popup(X,Y);
end;

procedure TfrmMain.tmrTipsTimer(Sender: TObject);
var geser : integer;
begin
  inc (i);
  if (i > 4) then i := 0;
  geser := lblTips.Left;
  while (geser >= (29-270)) do
  begin
    lblTips.Left := geser;
    Sleep(5);
    Dec(geser,5);
    Application.ProcessMessages;
  end;

  lblTips.Caption := Tips[i];

  geser := 270;
  while (geser > 29) do
  begin
    lblTips.Left := geser;
    Sleep(1);
    Dec (geser,5);
    Application.ProcessMessages;
  end;


end;

procedure TfrmMain.Label4Click(Sender: TObject);
begin
  ShellExecute(0, 'OPEN', PChar('http://fcompware.blogspot.com'), '', '', SW_SHOWNORMAL);
end;

procedure TfrmMain.cmdWMPClick(Sender: TObject);
begin
  MediaSelector := 4;
  if (WMPAvailable = false) then
  begin
    if MessageBox(0, PChar(misc(sWMPPlugNotFound,'sWMPPlugNotFound')),'Not Found',MB_ICONEXCLAMATION + MB_YESNO) = 6 then
      ShellExecute(0, 'OPEN', PChar('http://fcompware.blogspot.com/2013/06/twitmysong-plugin-for-windows-media.html'), '', '', SW_SHOWNORMAL);

    cmdWMP.Down := false;
  end;

   If (FileExists(GetEnvironmentVariable('ProgramFiles') + '\Windows Media Player\plugins\TMSWmp.dll') = false) and (FileExists(ExtractFilePath(Application.ExeName) + 'TMSWmp.dll')) then
    if (MessageBox(0,PChar(misc(sWMPNotInstall,'sWMPNotInstall')), 'WMP Plugin', MB_ICONINFORMATION + MB_YESNO) = 6) then
     begin
       if (not DirectoryExists(GetEnvironmentVariable('ProgramFiles') + '\Windows Media Player\plugins'))then CreateDir(GetEnvironmentVariable('ProgramFiles') + '\Windows Media Player\plugins');

       begin
         if (CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'TMSWmp.dll'), PChar(GetEnvironmentVariable('ProgramFiles') + '\Windows Media Player\plugins\TMSWmp.dll'), false)) then
         begin
           // pindahkan file yang dibutuhkan
           CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'IEShims.dll'), PChar(GetEnvironmentVariable('ProgramFiles') + '\Windows Media Player\plugins\IEShims.dll'), false);
           CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'msvcp100d.dll'), PChar(GetEnvironmentVariable('ProgramFiles') + '\Windows Media Player\plugins\msvcp100d.dll'), false);
           CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'msvcr100d.dll'), PChar(GetEnvironmentVariable('ProgramFiles') + '\Windows Media Player\plugins\msvcr100d.dll'), false);


           // Register file plugin
           if (not RegisterOCX(GetEnvironmentVariable('ProgramFiles') + '\Windows Media Player\plugins\TMSWmp.dll')) then
             MessageBox(0,PChar(misc(sFailWMP,'sFailWMP')),'Failed to install',MB_ICONERROR+MB_OK)
           else
             MessageBox(0,PChar(misc(sSuccessWMP,'sSuccessWMP')),'Plugin Installed', MB_OK+MB_ICONINFORMATION);
         end
        else
          MessageBox (0,PChar(misc(sFailWMP,'sFailWMP')), 'Access Denied', MB_OK + MB_ICONERROR);
       end
     end;

end;

procedure TfrmMain.cmdITunesClick(Sender: TObject);
begin
  MediaSelector := 5;

  if (iTunesAvailable = false) then
  begin
    if MessageBox(0, PChar(misc(siTunesPlugNotFound,'siTunesPlugNotFound')),'Not Found',MB_ICONEXCLAMATION + MB_YESNO) = 6 then
      ShellExecute(0, 'OPEN', PChar('http://fcompware.blogspot.com/2013/06/twitmysong-plugin-for-windows-media.html'), '', '', SW_SHOWNORMAL);
    cmdITunes.Down := false;
  end;

   If (FileExists(GetEnvironmentVariable('ProgramFiles') + '\iTunes\Plug-ins\TMStunes.dll') = false) and (FileExists(ExtractFilePath(Application.ExeName) + 'TMStunes.dll')) then
    if (MessageBox(0,PChar(misc(siTunesNotInstall,'siTunesNotInstall')), 'iTunes Plugin', MB_ICONINFORMATION + MB_YESNO) = 6) then
     begin
       if (not DirectoryExists(GetEnvironmentVariable('ProgramFiles') + '\iTunes\Plug-ins\'))then CreateDir(GetEnvironmentVariable('ProgramFiles') + '\iTunes\Plug-ins\');

       begin
         if (CopyFile(PChar(ExtractFilePath(Application.ExeName) + 'TMStunes.dll'), PChar(GetEnvironmentVariable('ProgramFiles') + '\iTunes\Plug-ins\TMStunes.dll'), false)) then
         begin
            MessageBox(0,PChar(misc(sSuccessiTunes,'sSuccessiTunes')),'Plugin Installed', MB_OK+MB_ICONINFORMATION);
         end
        else
           MessageBox(0,PChar(misc(sFailiTunes,'sFailiTunes')),'Failed to install',MB_ICONERROR+MB_OK)
       end
     end;
end;

end.
