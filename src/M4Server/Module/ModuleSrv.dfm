object DMModuleSrv: TDMModuleSrv
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 412
  Width = 423
  object ConnectionMain: TFDConnection
    Params.Strings = (
      'ConnectionDef=MYWALID_MYSQL')
    ResourceOptions.AssignedValues = [rvStoreItems]
    ResourceOptions.StoreItems = [siData, siDelta]
    Connected = True
    LoginPrompt = False
    Left = 65
    Top = 214
  end
  object MySQLDriver: TFDPhysMySQLDriverLink
    VendorLib = 'c:\Program Files (x86)\mysql\lib\libmysql.dll'
    Left = 80
    Top = 96
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 56
    Top = 32
  end
  object FDManager1: TFDManager
    SilentMode = True
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 72
    Top = 160
  end
  object qrMeetingEvent: TFDQuery
    Connection = ConnectionMain
    SQL.Strings = (
      'SELECT * FROM TMEETINGEVENT')
    Left = 64
    Top = 288
  end
end
