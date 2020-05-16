object frmReport: TfrmReport
  Left = 0
  Top = 0
  Caption = 'frmReport'
  ClientHeight = 610
  ClientWidth = 877
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = 24
    Top = 8
    Width = 794
    Height = 1123
    DataSource = DataSource1
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    ShowDesigners = False
    ShowProgress = False
    ShowTracks = False
    Title = 'Report'
    BeforePrint = RLReport1BeforePrint
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 59
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      Color = clWhite
      ParentColor = False
      Transparent = False
      object RLSystemInfo1: TRLSystemInfo
        Left = 0
        Top = 0
        Width = 36
        Height = 16
        Align = faLeftTop
        Info = itTitle
        Text = ''
        Transparent = False
      end
      object RLLabel1: TRLLabel
        Left = 313
        Top = 22
        Width = 92
        Height = 27
        Caption = 'Meeting'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -24
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Transparent = False
      end
      object RLSystemInfo2: TRLSystemInfo
        Left = 601
        Top = 0
        Width = 117
        Height = 16
        Align = faRightTop
        Info = itPageNumber
        Text = 'Page'
        Transparent = False
      end
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 97
      Width = 718
      Height = 16
      BandType = btHeader
      Color = 16692062
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic, fsUnderline]
      ParentColor = False
      ParentFont = False
      Transparent = False
      object RLLabel2: TRLLabel
        Left = 62
        Top = 0
        Width = 16
        Height = 16
        Align = faTopOnly
        Caption = 'ID'
        Transparent = False
      end
      object RLLabel3: TRLLabel
        Left = 119
        Top = 0
        Width = 40
        Height = 16
        Align = faTopOnly
        Caption = 'Raum'
        Transparent = False
      end
      object RLLabel4: TRLLabel
        Left = 180
        Top = 0
        Width = 39
        Height = 16
        Align = faTopOnly
        Caption = 'Name'
        Transparent = False
      end
      object RLLabel5: TRLLabel
        Left = 307
        Top = 0
        Width = 74
        Height = 16
        Align = faTopOnly
        Caption = 'Description'
        Transparent = False
      end
      object RLLabel6: TRLLabel
        Left = 647
        Top = 0
        Width = 63
        Height = 16
        Align = faTopOnly
        Caption = 'Interval'
        Transparent = False
      end
      object RLLabel7: TRLLabel
        Left = 0
        Top = 0
        Width = 31
        Height = 16
        Align = faTopOnly
        Caption = 'Date'
        Transparent = False
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 113
      Width = 718
      Height = 16
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = True
      Borders.DrawBottom = True
      object RLDBText1: TRLDBText
        Left = 62
        Top = 0
        Width = 57
        Height = 16
        Align = faTopOnly
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        DataField = 'WorkIDGrp'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 119
        Top = 0
        Width = 61
        Height = 16
        Align = faTopOnly
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        DataField = 'Raum'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 180
        Top = 0
        Width = 128
        Height = 16
        Align = faTopOnly
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        DataField = 'NameEvent'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 307
        Top = 0
        Width = 340
        Height = 16
        Align = faTopOnly
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        DataField = 'DesEvent'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 647
        Top = 0
        Width = 67
        Height = 16
        Align = faTopOnly
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        DataField = 'IntervalEvent'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
      object RLDBText6: TRLDBText
        Left = 0
        Top = 0
        Width = 62
        Height = 16
        Align = faTopOnly
        AutoSize = False
        Borders.Sides = sdCustom
        Borders.DrawLeft = True
        Borders.DrawTop = False
        Borders.DrawRight = False
        Borders.DrawBottom = False
        DataField = 'DateEvent'
        DataSource = DataSource1
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        Text = ''
      end
    end
    object RLBand4: TRLBand
      Left = 38
      Top = 129
      Width = 718
      Height = 16
      BandType = btFooter
      object RLSystemInfo3: TRLSystemInfo
        Left = 648
        Top = 0
        Width = 70
        Height = 16
        Align = faRightTop
        Text = 'Date:'
      end
      object RLSystemInfo4: TRLSystemInfo
        Left = 568
        Top = 0
        Width = 80
        Height = 16
        Align = faRightTop
        Info = itHour
        Text = 'Hour:'
      end
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = DMModuleSrv.qrMeetingEvent
    Left = 640
    Top = 352
  end
  object RLPDFFilter1: TRLPDFFilter
    DocumentInfo.Creator = 
      'FortesReport Community Edition v4.0 \251 Copyright '#169' 1999-2016 F' +
      'ortes Inform'#225'tica'
    DisplayName = 'Documento PDF'
    Left = 200
    Top = 400
  end
  object frxReport1: TfrxReport
    Version = '6.3.14'
    DotMatrixReport = False
    EngineOptions.DoublePass = True
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick, pbCopy, pbSelection]
    PreviewOptions.OutlineWidth = 180
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 37871.995398692100000000
    ReportOptions.Description.Strings = (
      'Demonstrates how to create simple list report.')
    ReportOptions.LastChange = 42086.327078020790000000
    ReportOptions.VersionBuild = '1'
    ReportOptions.VersionMajor = '12'
    ReportOptions.VersionMinor = '13'
    ReportOptions.VersionRelease = '1'
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 72
    Top = 312
    Datasets = <
      item
        DataSet = frxUserDataSet1
        DataSetName = 'MeetingEvent'
      end>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      PaperWidth = 210.000000000000000000
      PaperHeight = 297.000000000000000000
      PaperSize = 9
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      Columns = 1
      ColumnWidth = 210.000000000000000000
      ColumnPositions.Strings = (
        '0')
      DataSet = frxUserDataSet1
      DataSetName = 'MeetingEvent'
      Frame.Typ = []
      MirrorMode = []
      PrintOnPreviousPage = True
      object Band1: TfrxReportTitle
        FillType = ftBrush
        Frame.Typ = []
        Height = 30.236240000000000000
        Top = 18.897650000000000000
        Width = 755.906000000000000000
        object Memo1: TfrxMemoView
          AllowVectorExport = True
          Top = 3.779530000000001000
          Width = 714.331170000000000000
          Height = 26.456710000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Typ = []
          Fill.BackColor = clGray
          HAlign = haCenter
          Memo.UTF8W = (
            'Meeting')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object Band2: TfrxPageHeader
        FillType = ftBrush
        Frame.Typ = []
        Height = 34.015770000000000000
        Top = 71.811070000000000000
        Width = 755.906000000000000000
        object Memo4: TfrxMemoView
          AllowVectorExport = True
          Left = 204.094620000000000000
          Top = 7.559060000000000000
          Width = 158.740260000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Color = clGray
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Raum')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          AllowVectorExport = True
          Left = 377.953000000000000000
          Top = 7.559060000000000000
          Width = 120.944960000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Color = clGray
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'NameEvent')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          AllowVectorExport = True
          Left = 514.016080000000000000
          Top = 7.559060000000000000
          Width = 83.149660000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Color = clGray
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'IntervalEvent')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          AllowVectorExport = True
          Left = 612.283860000000000000
          Top = 7.559060000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Color = clGray
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'Description')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Top = 7.559060000000000000
          Width = 181.417440000000000000
          Height = 18.897650000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clMaroon
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Frame.Color = clGray
          Frame.Typ = [ftBottom]
          Fill.BackColor = clWhite
          Memo.UTF8W = (
            'WorkIDGrp')
          ParentFont = False
        end
      end
      object Band3: TfrxPageFooter
        FillType = ftBrush
        Frame.Typ = []
        Height = 26.456710000000000000
        Top = 249.448980000000000000
        Width = 755.906000000000000000
        object Memo2: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Top = 7.559059999999930000
          Width = 710.551640000000000000
          Height = 15.118120000000000000
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          Fill.BackColor = clWhite
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page] of [TotalPages]')
          ParentFont = False
        end
      end
      object Band4: TfrxMasterData
        FillType = ftBrush
        Frame.Typ = []
        Height = 22.677180000000000000
        Top = 166.299320000000000000
        Width = 755.906000000000000000
        Columns = 1
        ColumnWidth = 200.000000000000000000
        ColumnGap = 20.000000000000000000
        DataSet = frxUserDataSet1
        DataSetName = 'MeetingEvent'
        RowCount = 0
        object Memo13: TfrxMemoView
          AllowVectorExport = True
          Left = 3.779530000000000000
          Width = 714.331170000000000000
          Height = 18.897650000000000000
          DataSet = frxUserDataSet1
          DataSetName = 'MeetingEvent'
          Frame.Typ = []
          Highlight.Font.Charset = DEFAULT_CHARSET
          Highlight.Font.Color = -370606080
          Highlight.Font.Height = -13
          Highlight.Font.Name = 'Arial'
          Highlight.Font.Style = []
          Highlight.Condition = '(<Line#> mod 2) = 0'
          Highlight.FillType = ftBrush
          Highlight.Fill.BackColor = 15790320
          Highlight.Frame.Typ = []
          WordWrap = False
        end
        object Memo9: TfrxMemoView
          AllowVectorExport = True
          Left = 204.094620000000000000
          Width = 173.858380000000000000
          Height = 18.897650000000000000
          DataField = 'Raum'
          DataSet = frxUserDataSet1
          DataSetName = 'MeetingEvent'
          Frame.Typ = []
          Memo.UTF8W = (
            '[MeetingEvent."Raum"]')
        end
        object Memo10: TfrxMemoView
          AllowVectorExport = True
          Left = 377.953000000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          DataField = 'NameEvent'
          DataSet = frxUserDataSet1
          DataSetName = 'MeetingEvent'
          Frame.Typ = []
          Memo.UTF8W = (
            '[MeetingEvent."NameEvent"]')
        end
        object Memo11: TfrxMemoView
          AllowVectorExport = True
          Left = 514.016080000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          DataField = 'IntervalEvent'
          DataSet = frxUserDataSet1
          DataSetName = 'MeetingEvent'
          Frame.Typ = []
          Memo.UTF8W = (
            '[MeetingEvent."IntervalEvent"]')
        end
        object Memo12: TfrxMemoView
          AllowVectorExport = True
          Left = 612.283860000000000000
          Width = 102.047310000000000000
          Height = 18.897650000000000000
          DataField = 'DesEvent'
          DataSet = frxUserDataSet1
          DataSetName = 'MeetingEvent'
          Frame.Typ = []
          Memo.UTF8W = (
            '[MeetingEvent."DesEvent"]')
        end
        object Memo8: TfrxMemoView
          AllowVectorExport = True
          Left = 7.559060000000000000
          Width = 196.535560000000000000
          Height = 18.897650000000000000
          TagStr = '[Customers."Cust No"]'
          DataField = 'WorkIDGrp'
          DataSet = frxUserDataSet1
          DataSetName = 'MeetingEvent'
          Frame.Typ = []
          Memo.UTF8W = (
            '[MeetingEvent."WorkIDGrp"]')
        end
      end
    end
  end
  object frxUserDataSet1: TfrxUserDataSet
    UserName = 'MeetingEvent'
    OnCheckEOF = frxUserDataSet1CheckEOF
    OnFirst = frxUserDataSet1First
    OnNext = frxUserDataSet1Next
    OnPrior = frxUserDataSet1Prior
    Fields.Strings = (
      'WorkIDGrp'
      'Raum'
      'NameEvent'
      'IntervalEvent'
      'DateEvent'
      'Duration'
      'DesEvent')
    OnGetValue = frxUserDataSet1GetValue
    Left = 80
    Top = 392
  end
  object ADOTable1: TADOTable
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=C:\ProgIDE\Projekt\' +
      'SoftProject\Delphi\Meeting4\Bin\MeetingEvent.mdb;Persist Securit' +
      'y Info=False'
    CursorType = ctStatic
    TableName = 'MeetingEvent'
    Left = 144
    Top = 328
    object ADOTable1WorkIDGrp: TWideMemoField
      FieldName = 'WorkIDGrp'
      BlobType = ftWideMemo
    end
    object ADOTable1Raum: TWideStringField
      FieldName = 'Raum'
      Size = 40
    end
    object ADOTable1NameEvent: TWideStringField
      FieldName = 'NameEvent'
      Size = 255
    end
    object ADOTable1IntervalEvent: TWideMemoField
      FieldName = 'IntervalEvent'
      BlobType = ftWideMemo
    end
    object ADOTable1DateEvent: TDateTimeField
      FieldName = 'DateEvent'
    end
    object ADOTable1Duration: TIntegerField
      FieldName = 'Duration'
    end
    object ADOTable1DesEvent: TWideMemoField
      FieldName = 'DesEvent'
      BlobType = ftWideMemo
    end
  end
end
