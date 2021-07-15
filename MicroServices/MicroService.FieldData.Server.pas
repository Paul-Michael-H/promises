unit MicroService.FieldData.Server;

interface

uses
  MicroService.Custom.Server,
  MicroService.FieldData.Result,
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
  TCommand = string;
  TMicroService = class(MicroService.Custom.Server.TMicroservice<TCommand>)
  const
    Commands : array[0..0] of string =
    ('/getData');
  protected
    procedure ExtractCommand(const aContext: TIdContext;
                             const aRequestInfo: TIdHTTPRequestInfo;
                             var aCommand: TCommand); override;
    procedure HandleCommand(const aContext: TIdContext;
                            const aCommand: TCommand;
                            aResponseInfo: TIdHTTPResponseInfo); override;
    function getContent(const aName: TCommand): TCommand;

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
                                       var aCommand: TCommand);

  function GetValueForName(const aParameter: string): string;
  var
    Split: TArray<String>;
  begin
    Split := aParameter.Split(['=']);
    if Length(Split) = 2 then
      Result := Split[1]
    else
      Result := '';
  end;

var
  Command: string;
  Found: boolean;
begin
  Found := False;
  if aRequestInfo.Params.Count > 0 then
  begin
    for Command in Commands do
      if ARequestInfo.URI = Command then
      begin
        aCommand := GetValueForName(aRequestInfo.Params[0]);
        Found := True;
        break;
      end;
    if not Found then
      raise Exception.Create('Invalid URI');
  end
  else
    aCommand := '';
end;


function TMicroService.getContent(const aName: TCommand): TCommand;
begin
  Result := MockRecord(aName).ToJSON;
end;


procedure TMicroService.HandleCommand(const aContext: TIdContext;
                                      const aCommand: TCommand;
                                      aResponseInfo: TIdHTTPResponseInfo);
begin
  aResponseInfo.ContentText := getContent(aCommand);
end;

end.
