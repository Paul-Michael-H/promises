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
  end;

  TFieldsData<TData> = record
    [Serialize(True)]
    list: array of TFieldData<TData>;

    constructor FromJSON(const aValue: string);
    function ToJSON: string;
  end;

  function MockRecord(const aList: string): TFieldsData<string>;

implementation


{ TFields }

constructor TFieldsData<TData>.FromJSON(const aValue: string);
begin
  TJsonSerialize.FromJson<TFieldsData<TData>>(aValue, Self);
end;


function TFieldsData<TData>.ToJSON: string;
var
  JsonElement: IJsonElement;
begin
  JsonElement := TJsonSerialize.ToJson(Self);
  Result := JsonElement.AsString;
end;


function MockRecord(const aList: string): TFieldsData<string>;
var
  FieldList: TArray<string>;
  Field: string;
  i: integer;
begin
  FieldList := aList.Split([',']);
  SetLength(Result.list, Length(FieldList));
  i := 0;
  for Field in FieldList do
  begin
    Result.list[i].name := Field;
    Result.list[i].data := Random(100000000).ToHexString;
    inc(i);
  end;
end;


end.
