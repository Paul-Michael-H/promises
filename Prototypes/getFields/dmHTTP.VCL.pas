unit dmHTTP.VCL;

interface

uses
  System.SysUtils,
  System.Classes,
  System.Net.HttpClient,
  Mitov.JSON,
  Microservice.Fields.Server,
  Microservice.FieldData.Server,
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
  TMicroServiceFieldData = MicroService.FieldData.Server.TMicroService;

  TdmHTTP = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    FFieldListService: TMicroServiceFields;
    FFieldDataService: TMicroServiceFieldData;
  public
    { Public declarations }
    function FieldListService: TMicroServiceFields;
    function FieldDataService: TMicroServiceFieldData;
  end;

var
  dmHTTP: TdmHTTP;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmHTTP.DataModuleCreate(Sender: TObject);
begin
  FFieldListService := TMicroServiceFields.Create(27369);
  FFieldDataService := TMicroServiceFieldData.Create(27370);
end;


function TdmHTTP.FieldDataService: TMicroServiceFieldData;
begin
  Result := FFieldDataService;
end;


function TdmHTTP.FieldListService: TMicroServiceFields;
begin
  Result := FFieldListService;
end;


end.


