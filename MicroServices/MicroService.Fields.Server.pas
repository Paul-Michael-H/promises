unit MicroService.Fields.Server;

interface

uses
  MicroService.Custom.Server,
  MicroService.Fields.Result,
  System.SysUtils,
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
  TCommand = (getFields);

  TMicroService = class(MicroService.Custom.Server.TMicroservice<TCommand>)
  const
    Commands : array[0..0] of string =
    ('/getFields');
  protected
    procedure ExtractCommand(const aContext: TIdContext;
                             const aRequestInfo: TIdHTTPRequestInfo;
                             var aCommandID: TCommand); override;
    procedure HandleCommand(const aContext: TIdContext;
                            const aCommand: TCommand;
                            aResponseInfo: TIdHTTPResponseInfo); override;
    function getContent: string;

  end;

implementation

uses
  System.Classes,
  System.JSON,
  System.JSON.Types,
  System.JSON.Builders,
  System.JSON.Writers,
  System.JSON.Readers;

{ TMicroservice }

procedure TMicroService.ExtractCommand(const aContext: TIdContext;
                                       const aRequestInfo: TIdHTTPRequestInfo;
                                       var aCommandID: TCommand);
var
  Command: string;
  Found: boolean;
begin
  Found := False;
  for Command in Commands do
    if ARequestInfo.URI = Command then
    begin
      aCommandID := getFields;
      Found := True;
      break;
    end;
  if not Found then
    raise Exception.Create('Invalid URI');
end;


function TMicroService.getContent: string;
begin
  Result := MockRecord.ToJSON;
end;


procedure TMicroService.HandleCommand(const aContext: TIdContext;
                                      const aCommand: TCommand;
                                      aResponseInfo: TIdHTTPResponseInfo);
begin
  case aCommand of
    getFields: aResponseInfo.ContentText := getContent;
  end;
end;

end.
