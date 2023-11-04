unit TidyDemo.MainForm;

interface

uses
  System.Actions, System.Classes, System.SysUtils, Vcl.ActnList, Vcl.Controls, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Forms,
  Vcl.StdCtrls, Tidy;

type
  TMainForm = class(TForm)
    ActionList: TActionList;
    ActionRunTidy: TAction;
    ButtonRunTidy: TButton;
    MemoDestination: TMemo;
    MemoErrors: TMemo;
    MemoSource: TMemo;
    PanelBottom: TPanel;
    PanelClient: TPanel;
    SplitterHorizontal: TSplitter;
    SplitterVertical: TSplitter;
    Tidy: TTidy;
    procedure ActionRunTidyExecute(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.ActionRunTidyExecute(Sender: TObject);
begin
  try
    if Tidy.Run(MemoSource.Lines.Text) then
    begin
      MemoDestination.Text := Tidy.Output;
      MemoErrors.Text := Tidy.Errors;
    end
    else
      ShowMessage('Tidy: Error code ' + Tidy.ErrorCode.ToString);
  except
    on E: Exception do
      ShowMessage(E.Message);
  end;
end;

end.
