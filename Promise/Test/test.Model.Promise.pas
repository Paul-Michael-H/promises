unit test.Model.Promise;


interface

uses
  System.SysUtils,
  Promise,
  TestFramework;

type
  TTest = class(TTestCase)
  published
    procedure testCreation;
    procedure testPromiseWithResponse;
    procedure testPromiseWithReject;
    procedure testPromiseTask;
    procedure testPromiseFailed;
    procedure testPromiseCatch;
    procedure testPromiseMultiple;
    procedure testPromiseFailFirstWithMultipleWhens;
    procedure testPromiseReuse;
  end;

implementation

type
  ExpectedTestException = class(Exception);
  IStringPromise = IPromise<string>;
  IIntegerPromise = IPromise<integer>;

procedure AddTests;
var
  TestSuite:   ITestSuite;
begin
  TestSuite := TTestSuite.Create('Model.Promise');
  TestSuite.AddTest(TTest.Create('testCreation'));
  TestSuite.AddTest(TTest.Create('testPromiseWithResponse'));
  TestSuite.AddTest(TTest.Create('testPromiseWithReject'));
  TestSuite.AddTest(TTest.Create('testPromiseTask'));
  TestSuite.AddTest(TTest.Create('testPromiseCatch'));
  TestSuite.AddTest(TTest.Create('testPromiseMultiple'));
  TestSuite.AddTest(TTest.Create('testPromiseFailFirstWithMultipleWhens'));
  TestSuite.AddTest(TTest.Create('testPromiseReuse'));

  RegisterTest(TestSuite);
end;


{ TTest }

procedure TTest.testCreation;
var
  Promise: IStringPromise;
begin
  Promise := TPromise<string>.newPromise;
  CheckNotNull(Promise, 'Promise not created');
end;


procedure TTest.testPromiseWithReject;
const
  Constant = 'Reject';
var
  Promise: IStringPromise;
  Value: string;
begin
  Value := Constant;
  Promise := TPromise<string>.newPromise(
    function(aValue: string): string
    begin
      Sleep(100);
      raise ExpectedTestException.Create('testPromiseWithReject');
    end,
    function(aValue: string): string
    begin
      Sleep(100);
      Result := Constant;
    end
  );
  Promise.All;
  CheckEquals(Constant, Promise.Reject, 'Reject failed');
end;


procedure TTest.testPromiseWithResponse;
const
  Constant = 'Result';
var
  Promise: IStringPromise;
  Value: string;
begin
  Value := Constant;
  Promise := TPromise<string>.newPromise(
    function(aValue: string): string
    begin
      Sleep(100);
      Result := Value;
    end,
    nil
  );
  Promise.All;
  CheckEquals(Constant, Promise.Response, 'Response failed');
end;


procedure TTest.testPromiseTask;
var
  Promise: IStringPromise;
  TestValue: Integer;
begin
  TestValue := 0;
  Promise := TPromise<string>.newPromise(
    function(aValue: string): string
    begin
      Sleep(100);
      Inc(TestValue);
      Result := aValue;
    end,
    nil
  );
  Promise.All;
  CheckEquals(1, TestValue, 'Promise failed to increase test value in when');
end;


procedure TTest.testPromiseCatch;
const
  Constant = 'Caught';
var
  Promise: IStringPromise;
  TestValue: integer;
begin
  TestValue := 0;
  Promise := TPromise<string>.newPromise(
    nil,
    function(aValue: string): string
    begin
      Dec(TestValue);
      Result := Constant;
    end
  );
  Promise.All;
  CheckEquals(-1, TestValue, 'Promise failed to increase testvalue in failed path');
  CheckEquals(Constant, Promise.Response, 'Promise failed to increase testvalue in failed path');
end;


procedure TTest.testPromiseFailed;
const
  Constant = 'Result';
var
  Promise: IStringPromise;
  TestValue: Integer;
begin
  TestValue := 0;
  Promise := TPromise<string>.newPromise(
    function(aValue: string): string
    begin
      Sleep(100);
      raise Exception.Create('Failed');
    end,
    function(aValue: string): string
    begin
      Dec(TestValue);
      Result := '';
    end
  );
  Promise.All;
  CheckEquals(-1, TestValue, 'Promise failed to set value in failed path');
end;


procedure TTest.testPromiseFailFirstWithMultipleWhens;
var
  Promise: IIntegerPromise;
  TestValue: Integer;
begin
  TestValue := 0;
  Promise := TPromise<integer>.newPromise(
    function(aValue: integer): integer
    begin
      Sleep(100);
      Inc(TestValue);
      Result := TestValue;
    end,
    function(aValue: integer): integer
    begin
      Dec(TestValue);
      Result := aValue;
    end
  )
  .When(
    function(aValue: integer): integer
    begin
      Sleep(100);
      Inc(TestValue);
      Result := TestValue;
    end,
    function(aValue: integer): integer
    begin
      Dec(TestValue);
      Result := aValue;
    end
  );
  Promise.All;
  CheckEquals(2, Promise.Response, 'Promise failed to return correct value ');
  CheckEquals(2, TestValue, 'Promise failed to increase testtest value in both when calls');
end;


procedure TTest.testPromiseMultiple;
const
  Constant = 'Result';
var
  Promise: IStringPromise;
  TestValue: Integer;
begin
  TestValue := 0;
  Promise := TPromise<string>.newPromise;
  Promise.When(
    function(Value: string): string
    begin
      Sleep(100);
      Inc(TestValue);
      Result := Constant;
    end,
    nil
  )
  .When(
    function(Value: string): string
    begin
      Sleep(100);
      Inc(TestValue);
      Result := Value;
    end,
    nil
  );
  Promise.All;
  CheckEquals(2, TestValue, 'Promise failed to increase test value in both when calls');
  CheckEquals(Constant, Promise.Response, 'Promise failed to return correct response');
end;


procedure TTest.testPromiseReuse;
const
  Constant = 'Result';
var
  Promise: IStringPromise;
  TestValue: Integer;
begin
  TestValue := 0;
  Promise := TPromise<string>.newPromise;
  Promise.When(
    function(Value: string): string
    begin
      Sleep(100);
      Inc(TestValue);
      Result := Constant;
    end,
    nil
  );
  Promise.All;
  Promise.When(
    function(Value: string): string
    begin
      Sleep(100);
      Inc(TestValue);
      Result := Constant;
    end,
    nil
  );
  Promise.All;
  CheckEquals(2, TestValue, 'Promise failed to increase test value in both when calls');
end;



initialization
  AddTests;

end.
