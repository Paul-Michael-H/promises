unit MicroService.Fields.Connector;

interface

uses
  System.SysUtils,
  MicroService.Custom.Connector,
  MicroService.Fields.Result,
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
  IConnector = interface(IConnector<TFields>)
    ['{D31F77BD-C9B3-492E-AFA3-5EF498099237}']
  end;

  TConnector = class(MicroService.Custom.Connector.TConnector<TFields>, IConnector)
  protected
    function ConvertToResult(const aValue: string): TFields; override;
  end;

implementation

{ TConnector }

function TConnector.ConvertToResult(const aValue: string): TFields;
begin
  Result := TFields.FromJSON(aValue);
end;

end.
