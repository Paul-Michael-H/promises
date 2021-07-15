unit MicroService.Fields.Result;

interface

uses
  System.SysUtils,
  Mitov.Json,
  Mitov.Attributes,
  Mitov.Serialization,
  Mitov.Serialization.Json;

type
  TField = record
    [Serialize( True )]
    name: string;
    [Serialize( True )]
    fieldtype: string;
  end;

  TFields = record
    [Serialize( True )]
    fields: array of TField;

    constructor FromJSON(const aValue: string);
    function ToJSON: string;
  end;

  function MockRecord: TFields;

implementation


{ TFields }

constructor TFields.FromJSON(const aValue: string);
begin
  TJsonSerialize.FromJson<TFields>(aValue, Self);
end;


function TFields.ToJSON: string;
var
  JsonElement: IJsonElement;
begin
  JsonElement := TJsonSerialize.ToJson(Self);
  Result := JsonElement.AsString;
end;


function MockRecord: TFields;
const
  MockCount = 10;
var
  i: integer;
begin
  SetLength(Result.fields, MockCount);
  for i := 1 to MockCount do
  begin
    Result.fields[i-1].name := 'Field' + i.toString;
    Result.fields[i-1].fieldtype := 'string';
  end;
end;


end.
