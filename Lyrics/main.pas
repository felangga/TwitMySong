unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, FileCtrl, XPMan;

type
  TForm1 = class(TForm)
    txtParser: TMemo;
    cmdBrowse: TButton;
    edtPath: TEdit;
    bukafile: TOpenDialog;
    XPManifest1: TXPManifest;
    Label1: TLabel;
    cmdParseSave: TButton;
    procedure cmdBrowseClick(Sender: TObject);
    procedure cmdParseSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.cmdBrowseClick(Sender: TObject);
var direktori : string;
begin
  if (bukafile.Execute) then
  begin
    edtPath.Text := bukafile.FileName;
    txtParser.Lines.LoadFromFile(edtPath.text);
  end;
end;


procedure TForm1.cmdParseSaveClick(Sender: TObject);
var i : integer;
begin
  for i := 0 to txtParser.Lines.Count do
    if (txtParser.Lines.Strings[i] = '') then txtParser.Lines.Delete(i);

  for i := 0 to txtParser.Lines.Count do
  begin
    if (Length(txtParser.Lines.Strings[i]) < 25) then
      if (i = 0) then
      begin
        txtParser.Lines.Strings[i+1] := txtParser.Lines.Strings[0] + ' '+ Lowercase(txtParser.Lines.Strings[i+1]);
        txtParser.Lines.Delete(0);
      end
     else
      begin
        txtParser.Lines.Strings[i-1] := txtParser.Lines.Strings[i-1] + ' ' + Lowercase( txtParser.Lines.Strings[i]);
        txtParser.Lines.Delete(i);
      end;
      txtParser.Lines.Strings[i] := txtParser.Lines.Strings[i]+'\n';
  end;
  txtParser.Lines.SaveToFile(edtPath.Text);
  ShowMessage('Task Done'+Chr(13)+'Saved to : ' + edtPath.Text);
end;

end.
