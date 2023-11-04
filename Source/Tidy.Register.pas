unit Tidy.Register;

interface

uses
  System.Classes, Tidy;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Tidy', [TTidy]);
end;

end.
