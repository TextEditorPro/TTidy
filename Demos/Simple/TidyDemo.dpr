program TidyDemo;

uses
  Vcl.Forms,
  TidyDemo.MainForm in 'TidyDemo.MainForm.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
