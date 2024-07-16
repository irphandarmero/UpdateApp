object frm_main: Tfrm_main
  Left = 0
  Top = 0
  ClientHeight = 229
  ClientWidth = 325
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbUrl: TLabel
    Left = 32
    Top = 179
    Width = 19
    Height = 13
    Caption = 'URL'
  end
  object label6: TLabel
    Left = 8
    Top = 119
    Width = 4
    Height = 13
    Caption = '-'
  end
  object btUpdate: TButton
    Left = 96
    Top = 56
    Width = 125
    Height = 57
    Caption = 'UPDATE'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btUpdateClick
  end
  object pLoading: TProgressBar
    Left = 8
    Top = 142
    Width = 305
    Height = 17
    TabOrder = 1
  end
  object Button1: TButton
    Left = 219
    Top = 8
    Width = 98
    Height = 25
    Caption = 'Download All Files'
    TabOrder = 3
    Visible = False
  end
  object edURL: TEdit
    Left = 80
    Top = 176
    Width = 233
    Height = 21
    TabOrder = 2
    Text = 'ftp://192.168.1.125/SIMRS/'
  end
  object ftp: TIdFTP
    OnWork = ftpWork
    OnWorkBegin = ftpWorkBegin
    OnWorkEnd = ftpWorkEnd
    IPVersion = Id_IPv4
    ConnectTimeout = 0
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 21
    Left = 16
    Top = 8
  end
end
