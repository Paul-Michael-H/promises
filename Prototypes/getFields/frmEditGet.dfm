object fmEditGet: TfmEditGet
  Left = 0
  Top = 0
  Caption = 'Get from Server'
  ClientHeight = 245
  ClientWidth = 691
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
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 691
    Height = 245
    Align = alClient
    TabOrder = 0
    object cxTextEdit1: TcxTextEdit
      Left = 87
      Top = 53
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 0
      Width = 121
    end
    object cxTextEdit2: TcxTextEdit
      Left = 87
      Top = 78
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 1
      Width = 121
    end
    object cxTextEdit3: TcxTextEdit
      Left = 87
      Top = 103
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 2
      Width = 121
    end
    object cxTextEdit4: TcxTextEdit
      Left = 87
      Top = 128
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 3
      Width = 121
    end
    object cxTextEdit5: TcxTextEdit
      Left = 87
      Top = 153
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 4
      Width = 121
    end
    object cxTextEdit6: TcxTextEdit
      Left = 312
      Top = 53
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 5
      Width = 121
    end
    object cxTextEdit7: TcxTextEdit
      Left = 312
      Top = 78
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 6
      Width = 121
    end
    object cxTextEdit8: TcxTextEdit
      Left = 312
      Top = 103
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 7
      Width = 121
    end
    object cxTextEdit9: TcxTextEdit
      Left = 312
      Top = 128
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 8
      Width = 121
    end
    object cxTextEdit10: TcxTextEdit
      Left = 312
      Top = 153
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 9
      Width = 121
    end
    object cxTextEdit11: TcxTextEdit
      Left = 537
      Top = 53
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 10
      Width = 121
    end
    object cxTextEdit12: TcxTextEdit
      Left = 537
      Top = 78
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 11
      Width = 121
    end
    object cxTextEdit13: TcxTextEdit
      Left = 537
      Top = 103
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 12
      Width = 121
    end
    object cxTextEdit14: TcxTextEdit
      Left = 537
      Top = 128
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 13
      Width = 121
    end
    object cxTextEdit15: TcxTextEdit
      Left = 537
      Top = 153
      Style.HotTrack = False
      Style.TransparentBorder = False
      TabOrder = 14
      Width = 121
    end
    object btnGet: TcxButton
      Left = 598
      Top = 196
      Width = 75
      Height = 25
      Caption = 'Get'
      TabOrder = 15
      OnClick = btnGetClick
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      AlignHorz = ahClient
      AlignVert = avClient
      LayoutLookAndFeel = dxLayoutSkinLookAndFeel
      ButtonOptions.Buttons = <>
      Hidden = True
      LayoutDirection = ldHorizontal
      ShowBorder = False
      Index = -1
    end
    object dxLayoutItem1: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'cxTextEdit1'
      Control = cxTextEdit1
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem2: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'cxTextEdit2'
      Control = cxTextEdit2
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItem3: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'cxTextEdit3'
      Control = cxTextEdit3
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItem4: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'cxTextEdit4'
      Control = cxTextEdit4
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutItem5: TdxLayoutItem
      Parent = dxLayoutGroup1
      CaptionOptions.Text = 'cxTextEdit5'
      Control = cxTextEdit5
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItem6: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'cxTextEdit6'
      Control = cxTextEdit6
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem7: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'cxTextEdit7'
      Control = cxTextEdit7
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItem8: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'cxTextEdit8'
      Control = cxTextEdit8
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItem9: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'cxTextEdit9'
      Control = cxTextEdit9
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutItem10: TdxLayoutItem
      Parent = dxLayoutGroup2
      CaptionOptions.Text = 'cxTextEdit10'
      Control = cxTextEdit10
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutItem11: TdxLayoutItem
      Parent = dxLayoutGroup3
      CaptionOptions.Text = 'cxTextEdit11'
      Control = cxTextEdit11
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 0
    end
    object dxLayoutItem12: TdxLayoutItem
      Parent = dxLayoutGroup3
      CaptionOptions.Text = 'cxTextEdit12'
      Control = cxTextEdit12
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutItem13: TdxLayoutItem
      Parent = dxLayoutGroup3
      CaptionOptions.Text = 'cxTextEdit13'
      Control = cxTextEdit13
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 2
    end
    object dxLayoutItem14: TdxLayoutItem
      Parent = dxLayoutGroup3
      CaptionOptions.Text = 'cxTextEdit14'
      Control = cxTextEdit14
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 3
    end
    object dxLayoutItem15: TdxLayoutItem
      Parent = dxLayoutGroup3
      CaptionOptions.Text = 'cxTextEdit15'
      Control = cxTextEdit15
      ControlOptions.OriginalHeight = 19
      ControlOptions.OriginalWidth = 121
      ControlOptions.ShowBorder = False
      Index = 4
    end
    object dxLayoutGroup1: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object dxLayoutGroup2: TdxLayoutGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      Index = 1
    end
    object dxLayoutGroup3: TdxLayoutGroup
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahLeft
      AlignVert = avTop
      CaptionOptions.Text = 'New Group'
      ButtonOptions.Buttons = <>
      Index = 0
    end
    object dxLayoutItem16: TdxLayoutItem
      Parent = dxLayoutAutoCreatedGroup1
      AlignHorz = ahRight
      CaptionOptions.Visible = False
      Control = btnGet
      ControlOptions.OriginalHeight = 25
      ControlOptions.OriginalWidth = 75
      ControlOptions.ShowBorder = False
      Index = 1
    end
    object dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup
      Parent = dxLayoutControl1Group_Root
      AlignHorz = ahLeft
      Index = 2
    end
  end
  object dxLayoutLookAndFeelList: TdxLayoutLookAndFeelList
    Left = 432
    Top = 192
    object dxLayoutSkinLookAndFeel: TdxLayoutSkinLookAndFeel
      LookAndFeel.SkinName = 'Office2019Colorful'
      PixelsPerInch = 96
    end
  end
end
