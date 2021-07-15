unit Promise;

interface

uses
  System.SysUtils,
  Mitov.Types,
  Mitov.Attributes,
  Mitov.Containers.List,
  Mitov.Threading;

type
  IPromise<TResult> = interface
  ['{C5270059-B0BE-4060-B479-F387BF4CA5CB}']

    function Catch(const aTask: TFunc<TResult,TResult>): IPromise<TResult>;
    function When(const aTask: TFunc<TResult,TResult>;
                  const aReject: TFunc<TResult,TResult>): IPromise<TResult>;
    function All: IPromise<TResult>;
    function Response: TResult;
    function Reject: TResult;
  end;


  TPromise<TResult> = class(TInterfacedObject, IPromise<TResult>)
  type
  strict private
    FProcessingThread: IProcessingThread;
    FRejected: boolean;
    FDone: boolean;
    FResponse: TResult;
    FReject: TResult;

    procedure CreateData;
    procedure Start;
    procedure Stop;
  protected
    procedure AddCatch(const aReject: TFunc<TResult,TResult> = nil);
    procedure AddTask(const aTask: TFunc<TResult,TResult> = nil;
                      const aReject: TFunc<TResult,TResult> = nil);
    procedure AddToChain(const aTask: TFunc<TResult,TResult> = nil;
                         const aReject: TFunc<TResult,TResult> = nil);

  public
    constructor Create(const aTask: TFunc<TResult,TResult> = nil;
                       const aReject: TFunc<TResult,TResult> = nil);
    destructor Destroy; override;

    function When(const aTask: TFunc<TResult,TResult>;
                  const aReject: TFunc<TResult,TResult>): IPromise<TResult>;
    function Catch(const aCatch: TFunc<TResult,TResult>): IPromise<TResult>;
    function All: IPromise<TResult>;
    function Response: TResult;
    function Reject: TResult;
    class function newPromise(const aTask: TFunc<TResult,TResult> = nil;
                              const aReject: TFunc<TResult,TResult> = nil): IPromise<TResult>;

  end;

implementation


{ TPromise }

constructor TPromise<TResult>.Create(const aTask: TFunc<TResult,TResult> = nil;
                                     const aReject: TFunc<TResult,TResult> = nil);
begin
  CreateData;
  AddToChain(aTask, aReject);
end;


destructor TPromise<TResult>.Destroy;
begin
  inherited;
end;


procedure TPromise<TResult>.CreateData;
begin
  FRejected := False;
  FProcessingThread := TProcessingThread.CreateNamed(Cardinal(Pointer(Self)).ToHexString,
    procedure(const aProcessingThread: IProcessingThread)
    begin
      Stop;
    end
  );
end;


procedure TPromise<TResult>.AddCatch(const aReject: TFunc<TResult, TResult>);
begin
  Start;
  FProcessingThread.Process(
    procedure
    begin
      try
        FRejected := False;
        FResponse := aReject(FReject);
      except
      end;
    end
  );
end;


procedure TPromise<TResult>.AddTask(const aTask: TFunc<TResult, TResult>;
                                    const aReject: TFunc<TResult, TResult>);
begin
  Start;
  FProcessingThread.Process(
    procedure
    var
      Result: TResult;
    begin
      try
        if not FRejected then
        begin
          Result := FResponse;
          Result := aTask(Result);
          FResponse := Result;
        end
        else if assigned(aReject) then
        begin
          Result := FReject;
          Result := aTask(Result);
          FReject := Result;
        end;
      except
        on Exception do
        begin
          FRejected := True;
          if assigned(aReject) then
            FReject := aReject(FReject);
        end;
      end;
    end
  );
end;


procedure TPromise<TResult>.AddToChain(const aTask: TFunc<TResult, TResult>;
                                       const aReject: TFunc<TResult, TResult>);
begin
  if assigned(aTask) then
    AddTask(aTask, aReject)
  else if assigned(aReject) then
    AddCatch(aReject);
end;


function TPromise<TResult>.All: IPromise<TResult>;
begin
  while not FDone do
    Sleep(1);
  Result := Self;
end;


function TPromise<TResult>.Catch(const aCatch: TFunc<TResult,TResult>): IPromise<TResult>;
begin
  Result := Self;
  AddToChain(nil, aCatch);
end;


class function TPromise<TResult>.newPromise(const aTask: TFunc<TResult,TResult>;
                                            const aReject: TFunc<TResult,TResult>): IPromise<TResult>;
begin
  Result := TPromise<TResult>.Create(aTask, aReject);
end;


function TPromise<TResult>.Reject: TResult;
begin
  Result := FReject;
end;


function TPromise<TResult>.Response: TResult;
begin
  Result := FResponse;
end;


procedure TPromise<TResult>.Start;
begin
  if FDone then
  begin
    FDone := False;
  end;
end;

procedure TPromise<TResult>.Stop;
begin
  if not FDone then
  begin
    FDone := True;
  end;
end;


function TPromise<TResult>.When(const aTask: TFunc<TResult, TResult>;
                                const aReject: TFunc<TResult, TResult>): IPromise<TResult>;
begin
  Result := Self;
  AddToChain(aTask, aReject);
end;


end.
