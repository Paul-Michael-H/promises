unit MicroService.Custom.Connector;

interface

uses
  System.SysUtils,
  System.Net.HttpClient,
  Promise,
  Mitov.Threading,
  Mitov.Containers.List;

type
  IConnectorAccessor = interface
    ['{E3651D72-06CC-439B-80C4-6CAD6542A61A}']
    function getPort: Integer;
    procedure setPort(const aValue: Integer);
  end;


  IConnector<TResult> = interface(IConnectorAccessor)
    ['{32A77042-5D01-4180-B070-D4D18B420E61}']

    function newPromise(const aCommand: string): IPromise<TResult>;
    property Port: Integer read getPort write setPort;
  end;


  TConnector<TResult> = class(TInterfacedObject, IConnector<TResult>)
  strict private
    FHttpClient: THttpClient;
    FPort: Integer;
  protected
    function getPort: Integer;
    procedure setPort(const aValue: Integer);
    function ConvertToResult(const aValue: string): TResult; virtual; abstract;
  public
    constructor Create;
    destructor Destroy; override;

    function newPromise(const aCommand: string): IPromise<TResult>;
  end;

  IConnectorString = interface(IConnector<String>)
    ['{51B3F392-BAE7-4D37-A372-B8DC657D5D4A}']
  end;
  TConnectorString = class(TConnector<string>, IConnectorString)
  protected
    function ConvertToResult(const aValue: string): string; override;
  end;


implementation


{ TConnector }

constructor TConnector<TResult>.Create;
begin
  FHttpClient := THTTPClient.Create;
  FPort := 80;
end;


destructor TConnector<TResult>.Destroy;
begin
  FreeAndNil(FHttpClient);
end;


function TConnector<TResult>.getPort: Integer;
begin
  Result := FPort;
end;


function TConnector<TResult>.newPromise(const aCommand: string): IPromise<TResult>;
begin
  Result := TPromise<TResult>.newPromise(
    function(aResult: TResult): TResult
    var
      HttpResponse: IHttpResponse;
    begin
      try
        HttpResponse := FHttpClient.Get(aCommand);
        Result := ConvertToResult(HttpResponse.ContentAsString());
      except
        on e: exception do
        begin
          Result := ConvertToResult(e.Message);
        end;
      end;
    end,
    nil
    )
end;


procedure TConnector<TResult>.setPort(const aValue: Integer);
begin
  FPort := aValue;
end;

{ TConnectorString }

function TConnectorString.ConvertToResult(const aValue: string): string;
begin
  Result := aValue;
end;

end.
