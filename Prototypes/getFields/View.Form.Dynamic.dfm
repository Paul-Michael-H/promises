object frmDynamic: TfrmDynamic
  Left = 0
  Top = 0
  Caption = 'Dynamic'
  ClientHeight = 372
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCommands: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    Caption = 'pnlCommands'
    ShowCaption = False
    TabOrder = 0
    ExplicitLeft = 232
    ExplicitTop = 152
    ExplicitWidth = 185
    object btnGetFields: TButton
      Left = 8
      Top = 10
      Width = 75
      Height = 25
      Caption = 'getFields'
      TabOrder = 0
      OnClick = btnGetFieldsClick
    end
    object btnGetData: TButton
      Left = 89
      Top = 10
      Width = 75
      Height = 25
      Caption = 'getData'
      TabOrder = 1
      OnClick = btnGetDataClick
    end
  end
  object pnlControls: TPanel
    Left = 0
    Top = 41
    Width = 635
    Height = 331
    Align = alClient
    Caption = 'pnlControls'
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 232
    ExplicitTop = 152
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
end
