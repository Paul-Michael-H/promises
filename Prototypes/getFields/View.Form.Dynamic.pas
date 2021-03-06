unit View.Form.Dynamic;

interface

uses
  dmHTTP.VCL,
  MicroService.Fields.Result,
  MicroService.FieldData.Result,
  MicroService.Fields.Connector,
  MicroService.FieldData.Connector,
  Mitov.JSON,
  Mitov.Containers.List,
  Mitov.Containers.Dictionary,
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
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  IFieldsConnector = MicroService.Fields.Connector.IConnector;
  TFieldsConnector = MicroService.Fields.Connector.TConnector;
  IFieldsPromise = IPromise<TFields>;
  IFieldDataConnector = MicroService.FieldData.Connector.IConnector;
  TFieldDataConnector = MicroService.FieldData.Connector.TConnector;
  IFieldDataPromise = IPromise<TStringFieldData>;

  IFieldDictionary = IDictionary<string,TEdit>;
  TFieldDictionary = TDictionary<string,TEdit>;


  TfrmDynamic = class(TForm)
    pnlCommands: TPanel;
    pnlControls: TPanel;
    btnGetFields: TButton;
    btnGetData: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnGetFieldsClick(Sender: TObject);
    procedure btnGetDataClick(Sender: TObject);
  private
    { Private declarations }
    FFieldsPromise: IFieldsPromise;
    FFieldDataPromise: IFieldDataPromise;
    FCriticalSection: ICriticalSection;
    FFieldsConnector: IFieldsConnector;
    FFieldDataConnector: IFieldDataConnector;
    FNextYPosition: integer;
    FNextXPosition: integer;
    FFieldDictionary: IFieldDictionary;

    procedure AddControl(const aName: string);
    procedure RequestFields;
    procedure CleanControlData;
    procedure RequestFieldDataSynchronous;
    procedure RequestFieldDataAsynchronous;
    procedure RequestFieldDataList;
    function HandleGetFields(aValue: TFields): TFields;
    function GetEditByName(const aName: string): TEdit;
  private
    function newFieldDataPromise(const aList: string): IFieldDataPromise;
    function HandleFieldData(aValue: TStringFieldData): TStringFieldData;
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
  URL_GetData = 'http://localhost:27370/getData?list=%s';

procedure TfrmDynamic.AddControl(const aName: string);

  function CreateLabel: TLabel;
  begin
    Result := TLabel.Create(Self);
    Result.Parent := pnlControls;
    Result.Name := aName+'_label';
    Result.Caption := aName;
    Result.Top := FNextYPosition;
    Result.Left := FNextXPosition;
    Result.Width := 60;
  end;

  function CreateEdit(const aOffset: integer): TEdit;
  begin
    Result := TEdit.Create(Self);
    Result.Parent := pnlControls;
    Result.Name := aName;
    Result.Text := '';
    Result.Top := FNextYPosition;
    Result.Left := FNextXPosition+aOffset;
  end;

var
  Edit: TEdit;
  EditLabel: TLabel;
begin
  Lock;
  try
    EditLabel := CreateLabel;
    Edit := CreateEdit(EditLabel.Width + 20);
    FFieldDictionary.Add(aName, Edit);
    Inc(FNextYPosition, Edit.Height+5);
    if FNextYPosition > (pnlControls.ClientHeight - Edit.Height - 10)  then
    begin
      FNextYPosition := 5;
      FNextXPosition := Edit.Left + Edit.Width + 20;
    end;
  finally
    Unlock;
  end;
end;


procedure TfrmDynamic.btnGetDataClick(Sender: TObject);
begin
  if FFieldDictionary.Count > 0 then
  begin
    CleanControlData;
    RequestFieldDataList;
  end;
end;


procedure TfrmDynamic.btnGetFieldsClick(Sender: TObject);
begin
  if FFieldDictionary.Count = 0 then
    RequestFields;
end;


procedure TfrmDynamic.CleanControlData;
var
  Edit: TEdit;
begin
  FFieldDictionary.GetValues.Query().ForEach(
    procedure(const aEdit: TEdit)
    begin
      aEdit.Text := 'Pending';
    end
  );
end;


procedure TfrmDynamic.FormCreate(Sender: TObject);
begin
  FNextYPosition := 5;
  FNextXPosition := 5;
  FCriticalSection := TCriticalSection.Create;
  FFieldsConnector := TFieldsConnector.Create;
  FFieldDataConnector := TFieldDataConnector.Create;
  FFieldDictionary := TFieldDictionary.Create;
end;


function TfrmDynamic.GetEditByName(const aName: string): TEdit;
var
  i: integer;
  Control: TControl;
begin
  Result := nil;
  for i := 0 to pnlControls.ControlCount-1 do
  begin
    Control := pnlControls.Controls[i];
    if Control.Name = aName then
      Result := Control as TEdit;
  end;
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
  FFieldDictionary.Clear;
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


procedure TfrmDynamic.RequestFieldDataSynchronous;
  procedure AddWhen(const aName: string);
  begin
    FFieldDataPromise.When(
      function(aValue: TStringFieldData): TStringFieldData
      var
        Promise: IPromise<TStringFieldData>;
      begin
        Promise := newFieldDataPromise(aName).All;
        Result := aValue;
      end,
      nil
    );
  end;

var
 Keys: IArrayList<string>;
 FieldName: string;
begin
  FFieldDataPromise := nil;
  Keys := FFieldDictionary.GetKeys;
  for FieldName in Keys do
  begin
    if not assigned(FFieldDataPromise) then
      FFieldDataPromise := newFieldDataPromise(FieldName)
    else
    begin
      AddWhen(FieldName);
    end;
  end;
end;


procedure TfrmDynamic.RequestFieldDataAsynchronous;
var
 Keys: IArrayList<string>;
 FieldName: string;
begin
  FFieldDataPromise := nil;
  Keys := FFieldDictionary.GetKeys;
  if Keys.Count > 0 then
  begin
    FFieldDataPromise := newFieldDataPromise(Keys[0])
      .When(
        function(aValue: TStringFieldData): TStringFieldData
        var
          Promises: IArrayList<IPromise<TStringFieldData>>;
          Promise: IPromise<TStringFieldData>;
          i: integer;
          FieldName: string;
          RunningCount: integer;
        begin
          RunningCount := 0;
          for FieldName in FFieldDictionary.GetKeys do
          begin
            if not assigned(Promises) then
            begin
              Promises := TArrayList<IPromise<TStringFieldData>>.Create;
            end
            else
            begin
              Inc(RunningCount);
              Promise := newFieldDataPromise(FieldName)
                .Catch(
                  function(aValue:TStringFieldData): TStringFieldData
                  begin
                    Dec(RunningCount);
                  end
              );
              Promises.Add(Promise);
            end;
          end;
          while RunningCount > 0 do
            Sleep(1);
        end,
        nil
      );
  end;
end;


procedure TfrmDynamic.RequestFieldDataList;
var
  List: string;
  FieldName: string;
begin
  for FieldName in FFieldDictionary.GetKeys do
  begin
    if List = '' then
      List := FieldName
    else
      List := Concat(List, ',', FieldName);
  end;
  FFieldDataPromise := newFieldDataPromise(List);
end;


procedure TfrmDynamic.RequestFields;
begin
  FFieldsPromise := FFieldsConnector.newPromise(URL_GetFields)
    .when(HandleGetFields, nil);
end;


function TfrmDynamic.newFieldDataPromise(const aList: string): IFieldDataPromise;
begin
  Result := FFieldDataConnector.newPromise(Format(URL_GetData,[aList]));
  Result.When(HandleFieldData, nil);
end;


function TfrmDynamic.HandleFieldData(aValue: TStringFieldData): TStringFieldData;
var
  Edit: TEdit;
  i: integer;
begin
  for i := 0 to Length(aValue.list)-1 do
  begin
    Edit := GetEditByName(aValue.list[i].name);
    if assigned(Edit) then
    begin
      Lock;
      try
        Edit.Text := aValue.list[i].data;
      finally
        Unlock;
      end;
    end;
    Result := aValue;
  end;
end;


end.
