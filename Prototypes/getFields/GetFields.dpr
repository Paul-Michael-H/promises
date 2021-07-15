program GetFields;

uses
  Vcl.Forms,
  frmEditGet in 'frmEditGet.pas' {fmEditGet},
  dmHTTP.VCL in 'dmHTTP.VCL.pas' {dmHTTP: TDataModule},
  View.Form.Dynamic in 'View.Form.Dynamic.pas' {frmDynamic};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmDynamic, frmDynamic);
  Application.CreateForm(TfmEditGet, fmEditGet);
  Application.CreateForm(TdmHTTP, dmHTTP.VCL.dmHTTP);
  Application.Run;
end.

