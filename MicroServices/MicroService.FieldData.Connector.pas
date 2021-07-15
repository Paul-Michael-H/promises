unit MicroService.FieldData.Connector;

interface

uses
  System.SysUtils,
  MicroService.Custom.Connector,
  MicroService.FieldData.Result,
  IdTCPConnection,
  IdTCPClient,
  IdHTTP,
  IdBaseComponent,
  IdComponent,
  IdCustomTCPServer,
  IdCustomHTTPServer,
  IdHTTPServer,
  IdContext;


type
  TStringFieldData = TFieldData<string>;

  IConnector = interface(IConnector<TStringFieldData>)
    ['{D31F77BD-C9B3-492E-AFA3-5EF498099237}']
  end;

  TConnector = class(MicroService.Custom.Connector.TConnector<TStringFieldData>, IConnector)
  protected
    function ConvertToResult(const aValue: string): TStringFieldData; override;
  end;

implementation

{ TConnector }

function TConnector.ConvertToResult(const aValue: string): TStringFieldData;
begin
  Result := TStringFieldData.FromJSON(aValue);
end;

end.
