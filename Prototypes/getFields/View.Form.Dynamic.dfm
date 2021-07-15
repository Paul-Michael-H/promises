object frmDynamic: TfrmDynamic
  Left = 0
  Top = 0
  Caption = 'Dynamic'
  ClientHeight = 299
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
  object timerFieldData: TTimer
    Interval = 5000
    OnTimer = timerFieldDataTimer
    Left = 24
    Top = 16
  end
end
