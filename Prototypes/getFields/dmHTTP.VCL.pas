unit dmHTTP.VCL;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Net.HttpClient,
  Mitov.JSON,
  Microservice.Fields.Server,
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
  TMicroServiceFields = Microservice.Fields.Server.TMicroService;

  TdmHTTP = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FFieldListService: TMicroServiceFields;
  public
    { Public declarations }
    function FieldListServicePort: integer;
    function FieldListService: TMicroServiceFields;
  end;

var
  dmHTTP: TdmHTTP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmHTTP.DataModuleCreate(Sender: TObject);
begin
  FFieldListService := TMicroServiceFields.Create(FieldListServicePort);
end;


function TdmHTTP.FieldListService: TMicroServiceFields;
begin
  Result := FFieldListService;
end;


function TdmHTTP.FieldListServicePort: integer;
begin
  Result := 27369;
end;

end.


