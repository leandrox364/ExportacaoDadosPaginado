object FrmMain: TFrmMain
  Left = 0
  Top = 0
  Caption = 'Exportar Dados com Pagina'#231#227'o'
  ClientHeight = 600
  ClientWidth = 1012
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Gauge1: TGauge
    Left = 0
    Top = 558
    Width = 1012
    Height = 42
    Align = alBottom
    ForeColor = clLime
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    Progress = 0
    ExplicitTop = 400
    ExplicitWidth = 1024
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1012
    Height = 89
    Align = alTop
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    ExplicitWidth = 1008
    object Label1: TLabel
      Left = 272
      Top = 8
      Width = 142
      Height = 21
      Caption = 'Registros Por P'#225'gina'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object Button2: TButton
      Left = 144
      Top = 33
      Width = 100
      Height = 30
      Caption = 'Parar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = Button2Click
    end
    object Button1: TButton
      Left = 14
      Top = 33
      Width = 100
      Height = 30
      Caption = 'Iniciar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object EdtLinhas: TEdit
      Left = 272
      Top = 34
      Width = 121
      Height = 29
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      Text = '1000'
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 89
    Width = 1012
    Height = 469
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitTop = 83
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=D:\Desenvolvimento\DesenvolvimentoDelphi\DB\CEP.FDB'
      'User_Name=SYSDBA'
      'Password=masterkey'
      'Protocol=TCPIP'
      'Server=localhost'
      'Port=3050'
      'DriverID=FB')
    FetchOptions.AssignedValues = [evMode, evRowsetSize]
    FetchOptions.Mode = fmAll
    FetchOptions.RowsetSize = 1000
    LoginPrompt = False
    Left = 496
    Top = 24
  end
  object QryItens: TFDQuery
    Connection = FDConnection1
    Left = 576
    Top = 24
  end
end
