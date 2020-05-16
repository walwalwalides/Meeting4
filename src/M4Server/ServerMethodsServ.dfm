object ServerMethods: TServerMethods
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 634
  Width = 791
  object ConnectionMain: TFDConnection
    Params.Strings = (
      'ConnectionDef=MYWALID_MYSQL')
    ResourceOptions.AssignedValues = [rvStoreItems]
    ResourceOptions.StoreItems = [siData, siDelta]
    Connected = True
    LoginPrompt = False
    Left = 377
    Top = 206
  end
  object ProcGetActive: TFDStoredProc
    Connection = ConnectionMain
    StoredProcName = 'mywalid.GetActive'
    Left = 273
    Top = 131
    ParamData = <
      item
        Position = 1
        Name = 'AWorkID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'result'
        DataType = ftBoolean
        ParamType = ptResult
      end>
  end
  object ProcGetAdress: TFDStoredProc
    Connection = ConnectionMain
    StoredProcName = 'mywalid.GetAdress'
    Left = 129
    Top = 26
    ParamData = <
      item
        Position = 1
        Name = 'AWorkID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'result'
        DataType = ftString
        ParamType = ptResult
        Size = 255
      end>
  end
  object FncgetriderequirementProc: TFDStoredProc
    Connection = ConnectionMain
    StoredProcName = '"fncGetRideRequirement"'
    Left = 524
    Top = 212
    ParamData = <
      item
        Position = 1
        Name = 'arg_ride_id'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'result'
        DataType = ftInteger
        FDDataType = dtInt32
        ParamType = ptResult
      end>
  end
  object ProcGetPosition: TFDStoredProc
    Connection = ConnectionMain
    StoredProcName = 'mywalid.GetPosition'
    Left = 608
    Top = 91
    ParamData = <
      item
        Position = 1
        Name = 'AWorkID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'result'
        DataType = ftString
        ParamType = ptResult
        Size = 20
        Value = Null
      end>
  end
  object qrWorkerInfo: TFDQuery
    Connection = ConnectionMain
    SQL.Strings = (
      'SELECT * FROM tWorkerInfo')
    Left = 227
    Top = 87
  end
  object qrWorkerStatus: TFDQuery
    Connection = ConnectionMain
    SQL.Strings = (
      'SELECT * FROM tWorkerStatus')
    Left = 344
    Top = 147
  end
  object DSPWorkerInfo: TDataSetProvider
    DataSet = qrWorkerInfo
    Left = 456
    Top = 152
  end
  object DSPWorkerStatus: TDataSetProvider
    DataSet = qrWorkerStatus
    Left = 592
    Top = 168
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 128
    Top = 176
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'c:\Program Files (x86)\mysql\lib\libmysql.dll'
    Left = 48
    Top = 240
  end
  object ProcGetWorkID: TFDStoredProc
    Connection = ConnectionMain
    StoredProcName = 'mywalid.GetWorkID'
    Left = 249
    Top = 35
    ParamData = <
      item
        Position = 1
        Name = 'AName'
        DataType = ftString
        ParamType = ptInput
        Size = 40
      end
      item
        Position = 2
        Name = 'result'
        DataType = ftInteger
        ParamType = ptResult
        Value = 0
      end>
  end
  object ProcUpWorkCalender: TFDStoredProc
    Connection = ConnectionMain
    StoredProcName = 'mywalid.UpCalenderWorker'
    Left = 97
    Top = 99
    ParamData = <
      item
        Position = 1
        Name = 'AWorkID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'AName'
        DataType = ftString
        ParamType = ptInput
        Size = 40
      end
      item
        Position = 3
        Name = 'ADateDay'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Position = 4
        Name = 'APlanDay'
        DataType = ftMemo
        ParamType = ptInput
      end
      item
        Position = 5
        Name = 'result'
        DataType = ftInteger
        ParamType = ptResult
      end>
  end
  object ProcGetRaum: TFDStoredProc
    Connection = ConnectionMain
    StoredProcName = 'mywalid.GetAdress'
    Left = 177
    Top = 234
    ParamData = <
      item
        Position = 1
        Name = 'AWorkID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Position = 2
        Name = 'result'
        DataType = ftString
        ParamType = ptResult
        Size = 255
      end>
  end
  object FDTable1: TFDTable
    IndexFieldNames = 'NameEvent;DateEvent'
    Connection = ConnectionMain
    UpdateOptions.UpdateTableName = 'MYWALID.tmeetingevent'
    TableName = 'MYWALID.tmeetingevent'
    Left = 288
    Top = 280
    object FDTable1WorkIDGrp: TMemoField
      FieldName = 'WorkIDGrp'
      Origin = 'WorkIDGrp'
      Required = True
      BlobType = ftMemo
    end
    object FDTable1Raum: TStringField
      FieldName = 'Raum'
      Origin = 'Raum'
      Required = True
      Size = 40
    end
    object FDTable1NameEvent: TStringField
      FieldName = 'NameEvent'
      Origin = 'NameEvent'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      Size = 255
    end
    object FDTable1IntervalEvent: TMemoField
      FieldName = 'IntervalEvent'
      Origin = 'IntervalEvent'
      Required = True
      BlobType = ftMemo
    end
    object FDTable1DateEvent: TDateField
      FieldName = 'DateEvent'
      Origin = 'DateEvent'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object FDTable1Duration: TIntegerField
      FieldName = 'Duration'
      Origin = 'Duration'
      Required = True
    end
    object FDTable1DesEvent: TMemoField
      FieldName = 'DesEvent'
      Origin = 'DesEvent'
      Required = True
      BlobType = ftMemo
    end
  end
end
