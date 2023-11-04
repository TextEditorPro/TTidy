object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Tidy Demo'
  ClientHeight = 566
  ClientWidth = 869
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  TextHeight = 15
  object SplitterVertical: TSplitter
    Left = 409
    Top = 0
    Width = 5
    Height = 525
  end
  object MemoSource: TMemo
    Left = 0
    Top = 0
    Width = 409
    Height = 525
    Align = alLeft
    Lines.Strings = (
      '<html>'
      ' <head>'
      ' <title>Test document</title>'
      ' </head>'
      ' <body>'
      
        ' <p>This example shows how Tidy can indent output while preservi' +
        'ng'
      ' formatting of particular elements.</p>'
      ''
      ' <pre>This is'
      ' <em>genuine'
      '       preformatted</em>'
      '    text'
      ' </pre>'
      ' </body>'
      ' </html>')
    TabOrder = 0
  end
  object PanelBottom: TPanel
    Left = 0
    Top = 525
    Width = 869
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    ShowCaption = False
    TabOrder = 1
    object ButtonRunTidy: TButton
      AlignWithMargins = True
      Left = 788
      Top = 6
      Width = 75
      Height = 29
      Margins.Left = 6
      Margins.Top = 6
      Margins.Right = 6
      Margins.Bottom = 6
      Action = ActionRunTidy
      Align = alRight
      TabOrder = 0
    end
  end
  object PanelClient: TPanel
    Left = 414
    Top = 0
    Width = 455
    Height = 525
    Align = alClient
    BevelOuter = bvNone
    Caption = 'PanelClient'
    ParentColor = True
    ShowCaption = False
    TabOrder = 2
    object SplitterHorizontal: TSplitter
      Left = 0
      Top = 278
      Width = 455
      Height = 5
      Cursor = crVSplit
      Align = alBottom
    end
    object MemoDestination: TMemo
      Left = 0
      Top = 0
      Width = 455
      Height = 278
      Align = alClient
      TabOrder = 0
    end
    object MemoErrors: TMemo
      Left = 0
      Top = 283
      Width = 455
      Height = 242
      Align = alBottom
      TabOrder = 1
    end
  end
  object ActionList: TActionList
    Left = 496
    Top = 94
    object ActionRunTidy: TAction
      Caption = 'Run Tidy'
      OnExecute = ActionRunTidyExecute
    end
  end
  object Tidy: TTidy
    DocumentInAndOut.Doctype = 'auto'
    LibraryName = 'Tidy.dll'
    Repair.CSSPrefix = 'c'
    Left = 496
    Top = 24
  end
end
