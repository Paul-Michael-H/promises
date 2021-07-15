unit MicroService.FieldData.Result;

interface

uses
  System.SysUtils,
  Mitov.Json,
  Mitov.Attributes,
  Mitov.Serialization,
  Mitov.Serialization.Json;

type
  TFieldData<TData> = record
    [Serialize( True )]
    name: string;
    [Serialize( True )]
    data: TData;

    constructor FromJSON(const aValue: string);
    function ToJSON: string;
  end;

  function MockRecord(const aName: string): TFieldData<string>;

implementation


{ TFields }

constructor TFieldData<TData>.FromJSON(const aValue: string);
begin
  TJsonSerialize.FromJson<TFieldData<TData>>(aValue, Self);
end;


function TFieldData<TData>.ToJSON: string;
var
  JsonElement: IJsonElement;
begin
  JsonElement := TJsonSerialize.ToJson(Self);
  Result := JsonElement.AsString;
end;


function MockRecord(const aName: string): TFieldData<string>;
begin
  Result.name := aName;
  Result.data := Random(100000000).ToHexString;
end;


end.
