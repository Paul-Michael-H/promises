unit View.Form.Dynamic;

interface

uses
  dmHTTP.VCL,
  MicroService.Fields.Result,
  MicroService.Fields.Connector,
  Mitov.JSON,
  Mitov.Containers.List,
  Mitov.Threading,
  Promise,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  System.JSON,
  System.JSON.Builders,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmDynamic = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FPromise: IPromise<TFields>;
    FCriticalSection: ICriticalSection;
    FConnector: MicroService.Fields.Connector.IConnector;
    FNextYPosition: integer;
    FNextXPosition: integer;

    procedure AddControl(const aName: string);
    procedure RequestFields;
    function HandleGetFields(aValue: TFields): TFields;
  public
    { Public declarations }
    procedure Lock;
    procedure Unlock;
  end;

var
  frmDynamic: TfrmDynamic;

implementation

{$R *.dfm}

const
  URL_GetFields = 'http://localhost:27369/getFields';

procedure TfrmDynamic.AddControl(const aName: string);
var
  Edit: TEdit;
begin
  Lock;
  try
    Edit := TEdit.Create(Self);
    Edit.Parent := Self;
    Edit.Name := aName;
    Edit.Text := aName;
    Edit.Top := FNextYPosition;
    Inc(FNextYPosition, Edit.Height+5);
    Edit.Left := FNextXPosition;
    if FNextYPosition > Self.Height then
    begin
      FNextYPosition := 5;
      Inc(FNextXPosition, Edit.Width + 10);
    end;
  finally
    Unlock;
  end;
end;


procedure TfrmDynamic.FormCreate(Sender: TObject);
begin
  FNextYPosition := 5;
  FNextXPosition := 5;
  FCriticalSection := TCriticalSection.Create;
  FConnector := TConnector.Create();
  RequestFields;
end;

function TfrmDynamic.HandleGetFields(aValue: TFields): TFields;

  procedure AddControlInMainThread(const aField: TField);
  begin
    Mitov.Threading.MainThreadExecute(Self, True,
      procedure
      begin
        AddControl(aField.name);
      end
    );
  end;

var
  i: integer;
begin
  Sleep(400);
  for i := 0 to Length(aValue.fields)-1 do
  begin
    AddControlInMainThread(aValue.fields[i]);
  end;
end;


procedure TfrmDynamic.Lock;
begin
  FCriticalSection.Enter;
end;


procedure TfrmDynamic.Unlock;
begin
  FCriticalSection.Leave;
end;


procedure TfrmDynamic.RequestFields;
begin
  FPromise := FConnector.newPromise(URL_GetFields)
    .when(HandleGetFields, nil);
end;



end.
