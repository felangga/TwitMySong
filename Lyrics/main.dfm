object Form1: TForm1
  Left = 287
  Top = 431
  BorderStyle = bsToolWindow
  Caption = '#TwitMySong lyrics parser'
  ClientHeight = 208
  ClientWidth = 346
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  ScreenSnap = True
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 180
    Width = 125
    Height = 13
    Caption = 'fcomputer - #TwitMySong'
    Enabled = False
  end
  object txtParser: TMemo
    Left = 8
    Top = 40
    Width = 329
    Height = 129
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object cmdBrowse: TButton
    Left = 264
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Browse !'
    TabOrder = 1
    OnClick = cmdBrowseClick
  end
  object edtPath: TEdit
    Left = 8
    Top = 10
    Width = 249
    Height = 21
    TabOrder = 2
  end
  object cmdParseSave: TButton
    Left = 248
    Top = 175
    Width = 91
    Height = 25
    Caption = 'Parse && Save'
    TabOrder = 3
    OnClick = cmdParseSaveClick
  end
  object bukafile: TOpenDialog
    Left = 24
    Top = 48
  end
  object XPManifest1: TXPManifest
    Left = 56
    Top = 48
  end
end
