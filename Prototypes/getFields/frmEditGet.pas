unit frmEditGet;

interface

uses
  dmHTTP.VCL,
  MicroService.Custom.Connector,
  Mitov.Containers.List,
  Mitov.Threading,
  Promise,
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  dxSkinsCore,
  dxSkinOffice2019Colorful,
  dxLayoutcxEditAdapters,
  dxLayoutControlAdapters,
  cxContainer,
  cxEdit,
  Vcl.Menus,
  cxClasses,
  dxLayoutLookAndFeels,
  dxLayoutContainer,
  Vcl.StdCtrls,
  cxButtons,
  cxTextEdit,
  dxLayoutControl;

type
  TfmEditGet = class(TForm)
    dxLayoutControl1Group_Root: TdxLayoutGroup;
    dxLayoutControl1: TdxLayoutControl;
    cxTextEdit1: TcxTextEdit;
    dxLayoutItem1: TdxLayoutItem;
    cxTextEdit2: TcxTextEdit;
    dxLayoutItem2: TdxLayoutItem;
    cxTextEdit3: TcxTextEdit;
    dxLayoutItem3: TdxLayoutItem;
    cxTextEdit4: TcxTextEdit;
    dxLayoutItem4: TdxLayoutItem;
    cxTextEdit5: TcxTextEdit;
    dxLayoutItem5: TdxLayoutItem;
    cxTextEdit6: TcxTextEdit;
    dxLayoutItem6: TdxLayoutItem;
    cxTextEdit7: TcxTextEdit;
    dxLayoutItem7: TdxLayoutItem;
    cxTextEdit8: TcxTextEdit;
    dxLayoutItem8: TdxLayoutItem;
    cxTextEdit9: TcxTextEdit;
    dxLayoutItem9: TdxLayoutItem;
    cxTextEdit10: TcxTextEdit;
    dxLayoutItem10: TdxLayoutItem;
    cxTextEdit11: TcxTextEdit;
    dxLayoutItem11: TdxLayoutItem;
    cxTextEdit12: TcxTextEdit;
    dxLayoutItem12: TdxLayoutItem;
    cxTextEdit13: TcxTextEdit;
    dxLayoutItem13: TdxLayoutItem;
    cxTextEdit14: TcxTextEdit;
    dxLayoutItem14: TdxLayoutItem;
    cxTextEdit15: TcxTextEdit;
    dxLayoutItem15: TdxLayoutItem;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutGroup2: TdxLayoutGroup;
    dxLayoutGroup3: TdxLayoutGroup;
    btnGet: TcxButton;
    dxLayoutItem16: TdxLayoutItem;
    dxLayoutAutoCreatedGroup1: TdxLayoutAutoCreatedGroup;
    dxLayoutLookAndFeelList: TdxLayoutLookAndFeelList;
    dxLayoutSkinLookAndFeel: TdxLayoutSkinLookAndFeel;
    procedure btnGetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FPromise: IPromise<string>;
    FCriticalSection: ICriticalSection;
    FConnector: IConnectorString;
  protected
    procedure Lock;
    procedure Unlock;
  public
    { Public declarations }
    function GetAll(aValue: string): string;
    function HandleFailed(aError: string): string;
  end;

var
  fmEditGet: TfmEditGet;

implementation

{$R *.dfm}

procedure TfmEditGet.FormCreate(Sender: TObject);
begin
  FCriticalSection := TCriticalSection.Create;
  FConnector := TConnectorString.Create();
  FConnector.Port := 27369;
end;


procedure TfmEditGet.btnGetClick(Sender: TObject);
begin
  FPromise := TPromise<string>.newPromise(
    GetAll,
    HandleFailed
  );
end;


function TfmEditGet.GetAll(aValue: string): string;
var
  Promises: IArrayList<IPromise<string>>;
  Counter: integer;

  function newRequest(const aTextEdit: TcxTextEdit): IPromise<string>;
  begin
    inc(counter);
    aTextEdit.Text := 'Pending';
    Result := FConnector.newPromise('http://localhost:27369/getFields')
      .When(
        function(aValue: string): string
        begin
          Sleep(Random(200+Random(400)));
          Lock;
          try
            aTextEdit.Text := aValue;
          finally
            Unlock;
          end;
          Result := aValue;
        end
        ,nil
      )
      .Catch(
        function(aValue: string): string
        begin
          Dec(Counter);
          Result := aValue;
        end
      );
  end;


begin
  Promises := TArrayList<IPromise<string>>.Create;
  Promises.Add(newRequest(cxTextEdit1));
  Promises.Add(newRequest(cxTextEdit2));
  Promises.Add(newRequest(cxTextEdit3));
  Promises.Add(newRequest(cxTextEdit4));
  Promises.Add(newRequest(cxTextEdit5));
  Promises.Add(newRequest(cxTextEdit6));
  Promises.Add(newRequest(cxTextEdit7));
  Promises.Add(newRequest(cxTextEdit8));
  Promises.Add(newRequest(cxTextEdit9));
  Promises.Add(newRequest(cxTextEdit10));
  Promises.Add(newRequest(cxTextEdit11));
  Promises.Add(newRequest(cxTextEdit12));
  Promises.Add(newRequest(cxTextEdit13));
  Promises.Add(newRequest(cxTextEdit14));
  Promises.Add(newRequest(cxTextEdit15));
  While Counter > 0 do
    Sleep(1);
end;


function TfmEditGet.HandleFailed(aError: string): string;
begin
  Result := 'Error';
end;


procedure TfmEditGet.Lock;
begin
  FCriticalSection.Enter;
end;


procedure TfmEditGet.Unlock;
begin
  FCriticalSection.Leave;
end;


end.
