unit MicroService.Custom.Server;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Net.HttpClient,
  Mitov.JSON,
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
  TMicroservice<TCommand> = class
  strict private
    FServer: TIdHTTPServer;
  protected
    procedure HTTPCommandEvent(aContext: TIdContext;
                               aRequestInfo: TIdHTTPRequestInfo;
                               aResponseInfo: TIdHTTPResponseInfo);
    procedure ExtractCommand(const aContext: TIdContext;
                             const aRequestInfo: TIdHTTPRequestInfo;
                             var aCommandID: TCommand); virtual; abstract;
    procedure HandleCommand(const aContext: TIdContext;
                            const aCommand: TCommand;
                            aResponseInfo: TIdHTTPResponseInfo); virtual; abstract;

  public
    constructor Create(const aPort: integer);
    destructor Destroy; override;

  end;

implementation

{ TMicroservice<TCommand> }

constructor TMicroservice<TCommand>.Create(const aPort: integer);
begin
  FServer := TIdHTTPServer.Create(nil);
  FServer.DefaultPort := aPort;
  FServer.OnCommandGet := HTTPCommandEvent;
  FServer.Active := True;
end;


destructor TMicroservice<TCommand>.Destroy;
begin
  FreeAndNil(FServer);
  inherited;
end;


procedure TMicroservice<TCommand>.HTTPCommandEvent(aContext: TIdContext;
                                                   aRequestInfo: TIdHTTPRequestInfo;
                                                   aResponseInfo: TIdHTTPResponseInfo);
var
  Command: TCommand;
begin
  try
    ExtractCommand(aContext, aRequestInfo, Command);
    HandleCommand(aContext, Command, aResponseInfo);
  except
    on e: exception do
      aResponseInfo.ContentText := '{}';
  end;
end;

end.
