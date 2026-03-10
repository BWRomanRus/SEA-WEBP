object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'SEA WEBP (INFINITY PROJECTS INFDT.RU)'
  ClientHeight = 441
  ClientWidth = 838
  Color = clBtnFace
  Constraints.MinHeight = 480
  Constraints.MinWidth = 854
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object grid: TImage
    Left = 0
    Top = 0
    Width = 838
    Height = 400
    Align = alClient
    Center = True
    Proportional = True
    Stretch = True
    ExplicitLeft = 176
    ExplicitTop = 64
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 838
    Height = 400
    Align = alClient
    Center = True
    Proportional = True
    Stretch = True
    ExplicitLeft = 136
    ExplicitTop = 120
    ExplicitWidth = 105
    ExplicitHeight = 105
  end
  object Panel1: TPanel
    Left = 0
    Top = 400
    Width = 838
    Height = 41
    Align = alBottom
    Color = 16776957
    ParentBackground = False
    TabOrder = 0
    ExplicitTop = 406
    object Button1: TButton
      Left = 7
      Top = 8
      Width = 273
      Height = 25
      Caption = #1054#1090#1082#1088#1099#1090#1100' WEBP '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077' (OPEN WEBP IMAGE)'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'Google WEBP IMAGE|*.webp'
    Title = #1054#1090#1082#1088#1086#1081#1090#1077' webp ('#1089#1090#1072#1090#1080#1095#1085#1086#1077' '#1080#1083#1080' '#1072#1085#1080#1084#1080#1088#1086#1074#1072#1085#1085#1086#1077' '#1080#1079#1086#1073#1088#1072#1078#1077#1085#1080#1077')'
    Left = 432
    Top = 144
  end
  object Timer1: TTimer
    Enabled = False
    Left = 600
    Top = 272
  end
end
