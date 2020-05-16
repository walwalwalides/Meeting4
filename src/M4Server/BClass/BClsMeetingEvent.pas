{ ============================================
  Software Name : 	M4Server
  ============================================ }
{ ******************************************** }
{ Written By WalWalWalides }
{ CopyRight © 2020 }
{ Email : WalWalWalides@gmail.com }
{ GitHub :https://github.com/walwalwalides }
{ ******************************************** }
unit BClsMeetingEvent;

interface

uses
  System.Classes, System.SysUtils;

type
  TMeetingEvent = class(TObject)
  Private
    FNameEvent: String;
    FID: integer;
    FDescriptionEvent: string;
    FIntervalEvent: string;
    FParticipants: string;
    FRaum: string;
    FDateEvent: TDate;
    FDuration: integer;
  protected
    procedure SetRaum(const Value: string);
    procedure SetDateEvent(const Value: TDate);
    procedure SetDuration(const Value: integer);
    procedure SetIntervalEvent(const Value: string);
    procedure setID(const Value: integer);
    procedure SetNameEvent(const Value: String);
    procedure SetDescriptionEvent(const Value: string);
    procedure setParticipants(const Value: string);
  public
    constructor Create;
    destructor Destroy; override;
    property ID: integer read FID write setID;
    property Participants: string read FParticipants write setParticipants;
    property DescriptionEvent: string read FDescriptionEvent
      write SetDescriptionEvent;
    Property IntervalEvent: string read FIntervalEvent write SetIntervalEvent;
    Property Duration: integer read FDuration write SetDuration;
    property NameEvent: String read FNameEvent write SetNameEvent;
    property Raum: string read FRaum write SetRaum;
    property DateEvent: TDate read FDateEvent write SetDateEvent;
  end;

implementation

{$REGION 'TMeetingEvent'}
{ TMeetingEvent }

constructor TMeetingEvent.Create;
begin
  inherited
end;

destructor TMeetingEvent.Destroy;
begin

  inherited;
end;

procedure TMeetingEvent.SetIntervalEvent(const Value: string);
begin
  FIntervalEvent := Value;
end;

procedure TMeetingEvent.setID(const Value: integer);
begin
  FID := Value;
end;

procedure TMeetingEvent.SetNameEvent(const Value: String);
begin
  FNameEvent := Value;
end;

procedure TMeetingEvent.SetDescriptionEvent(const Value: string);
begin
  FDescriptionEvent := Value;
end;

procedure TMeetingEvent.SetDuration(const Value: integer);
begin
  FDuration := Value;
end;

procedure TMeetingEvent.setParticipants(const Value: string);
begin
  FParticipants := Value;
end;

procedure TMeetingEvent.SetRaum(const Value: string);
begin
  FRaum := Value;
end;

procedure TMeetingEvent.SetDateEvent(const Value: TDate);
begin
  FDateEvent := Value;
end;

{$ENDREGION}

end.
