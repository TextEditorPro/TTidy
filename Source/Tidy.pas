unit Tidy;

{ https://api.html-tidy.org/

  A HTML/XML tidy, clean, and repair wrapper for Delphi.

  Note! Only 64-bit Tidy.dll can be built from the latest source at the moment. }

interface

uses
  Winapi.Windows, System.Classes, System.SysUtils, Tidy.Classes, Tidy.Types;

type
  TCustomTidy = class(TComponent)
  strict private
    FCleanup: TTidyCleanup;
    FDiagnostics: TTidyDiagnostics;
    FDocument: Pointer;
    FDocumentDisplay: TTidyDocumentDisplay;
    FDocumentInAndOut: TTidyDocumentInAndOut;
    FEncoding: TTidyEncodingOptions;
    FEntities: TTidyEntities;
    FErrorCode: Integer;
    FErrors: string;
    FFileInputOutput: TTidyFileInputOutput;
    FLibraryName: TFilename;
    FLibModule: THandle;
    FOutput: string;
    FPrettyPrint: TTidyPrettyPrint;
    FProcs: TTidyProcs;
    FRepair: TTidyRepair;
    FTransformations: TTidyTransformation;
    function SetOptions: Boolean;
    procedure FinalizeLibrary;
    procedure InitializeLibrary;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Run(const AInput: string): Boolean;
    property Cleanup: TTidyCleanup read FCleanup write FCleanup;
    property Diagnostics: TTidyDiagnostics read FDiagnostics write FDiagnostics;
    property DocumentDisplay: TTidyDocumentDisplay read FDocumentDisplay write FDocumentDisplay;
    property DocumentInAndOut: TTidyDocumentInAndOut read FDocumentInAndOut write FDocumentInAndOut;
    property Encoding: TTidyEncodingOptions read FEncoding write FEncoding;
    property Entities: TTidyEntities read FEntities write FEntities;
    property ErrorCode: Integer read FErrorCode;
    property Errors: string read FErrors;
    property FileInputOutput: TTidyFileInputOutput read FFileInputOutput write FFileInputOutput;
    property LibraryName: TFilename read FLibraryName write FLibraryName;
    property Output: string read FOutput;
    property PrettyPrint: TTidyPrettyPrint read FPrettyPrint write FPrettyPrint;
    property Repair: TTidyRepair read FRepair write FRepair;
    property Transformation: TTidyTransformation read FTransformations write FTransformations;
  end;

  { Note! Add "pidWin32 or" if there is 32-bit dll some day }
  [ComponentPlatformsAttribute(pidWin64)]
  TTidy = class(TCustomTidy)
  published
    property Cleanup;
    property Diagnostics;
    property DocumentDisplay;
    property DocumentInAndOut;
    property Encoding;
    property Entities;
    property FileInputOutput;
    property LibraryName;
    property PrettyPrint;
    property Repair;
    property Transformation;
  end;

implementation

uses
  System.AnsiStrings, System.TypInfo, Tidy.Consts;

constructor TCustomTidy.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FLibraryName := DEFAULT_LIBRARY_NAME;
  FErrorCode := 0;

  FCleanup := TTidyCleanup.Create;
  FDiagnostics := TTidyDiagnostics.Create;
  FDocumentDisplay := TTidyDocumentDisplay.Create;
  FDocumentInAndOut := TTidyDocumentInAndOut.Create;
  FEncoding := TTidyEncodingOptions.Create;
  FEntities := TTidyEntities.Create;
  FFileInputOutput := TTidyFileInputOutput.Create;
  FPrettyPrint := TTidyPrettyPrint.Create;
  FRepair := TTidyRepair.Create;
  FTransformations := TTidyTransformation.Create;
end;

destructor TCustomTidy.Destroy;
begin
  FreeAndNil(FCleanup);
  FreeAndNil(FDiagnostics);
  FreeAndNil(FDocumentDisplay);
  FreeAndNil(FDocumentInAndOut);
  FreeAndNil(FEncoding);
  FreeAndNil(FEntities);
  FreeAndNil(FFileInputOutput);
  FreeAndNil(FPrettyPrint);
  FreeAndNil(FRepair);
  FreeAndNil(FTransformations);

  inherited;
end;

procedure TCustomTidy.InitializeLibrary;
begin
  FLibModule := LoadLibrary(PWideChar(FLibraryName));

  if FLibModule <> 0 then
  begin
    @FProcs.BufAlloc := GetProcAddress(FLibModule, TTidyProcName.BufAlloc);
    @FProcs.BufAppend := GetProcAddress(FLibModule, TTidyProcName.BufAppend);
    @FProcs.BufFree := GetProcAddress(FLibModule, TTidyProcName.BufFree);
    @FProcs.BufInit := GetProcAddress(FLibModule, TTidyProcName.BufInit);
    @FProcs.CleanAndRepair := GetProcAddress(FLibModule, TTidyProcName.CleanAndRepair);
    @FProcs.Create := GetProcAddress(FLibModule, TTidyProcName.Create);
    @FProcs.OptSetBool := GetProcAddress(FLibModule, TTidyProcName.OptSetBool);
    @FProcs.OptSetInt := GetProcAddress(FLibModule, TTidyProcName.OptSetInt);
    @FProcs.OptSetValue := GetProcAddress(FLibModule, TTidyProcName.OptSetValue);
    @FProcs.ParseBuffer := GetProcAddress(FLibModule, TTidyProcName.ParseBuffer);
    @FProcs.Release := GetProcAddress(FLibModule, TTidyProcName.Release);
    @FProcs.RunDiagnostics := GetProcAddress(FLibModule, TTidyProcName.RunDiagnostics);
    @FProcs.SaveBuffer := GetProcAddress(FLibModule, TTidyProcName.SaveBuffer);
    @FProcs.SetErrorBuffer := GetProcAddress(FLibModule, TTidyProcName.SetErrorBuffer);
  end
  else
    raise Exception.Create(sTidyFailedToLoadDLL);

  if Assigned(FProcs.Create) then
    FDocument := FProcs.Create;
end;

procedure TCustomTidy.FinalizeLibrary;
begin
  if Assigned(FProcs.Release) and Assigned(FDocument) then
  begin
    FProcs.Release(FDocument);
    FDocument := nil;
  end;

  if FLibModule <> 0 then
  begin
    FreeLibrary(FLibModule);
    FLibModule := 0;
  end;
end;

function TCustomTidy.SetOptions: Boolean;

  function SetOption(const AOptionId: Cardinal; const AValue: LongBool): Boolean; overload;
  begin
    Result := FProcs.OptSetBool(FDocument, AOptionId, AValue)
  end;

  function SetOption(const AOptionId: Cardinal; const AValue: Cardinal): Boolean; overload;
  begin
    Result := FProcs.OptSetInt(FDocument, AOptionId, AValue)
  end;

  function SetOption(const AOptionId: Cardinal; const AValue: PAnsiChar): Boolean; overload;
  begin
    Result := FProcs.OptSetValue(FDocument, AOptionId, AValue)
  end;

var
  LCleanupOption: TTidyCleanupOption;
  LDiagnosticOption: TTidyDiagnosticsOption;
  LDocumentDisplayOption: TTidyDocumentDisplayOption;
  LDocumentInAndOutOption: TTidyDocumentInAndOutOption;
  LFileInputOutputOption: TTidyFileInputOutputOption;
  LEntitiesOption: TTidyEntitiesOption;
  LRepairOption: TTidyRepairOption;
  LPrettyPrintOption: TTidyPrettyPrintOption;
begin
  Result := False;

  if not Assigned(FProcs.OptSetBool) or not Assigned(FProcs.OptSetInt) or not Assigned(FProcs.OptSetValue) then
    Exit;

  { User specified doctype }
  if not SetOption(TTidyOptionId.Doctype, PAnsiChar(FDocumentInAndOut.Doctype)) then
    Exit;
  { Number of errors to put out }
  if not SetOption(TTidyOptionId.ShowErrors, FDocumentDisplay.ShowErrors) then
    Exit;
  { Output BODY content only }
  if not SetOption(TTidyOptionId.BodyOnly, PAnsiChar(TidyBooleanToAnsiStr(FDocumentDisplay.ShowBodyOnly))) then
    Exit;
  { File name to write errors to }
  if FFileInputOutput.ErrorFilename <> '' then
    if not SetOption(TTidyOptionId.ErrFile, PAnsiChar(FFileInputOutput.ErrorFilename)) then
      Exit;
  { File name to write markup to }
  if FFileInputOutput.OutputFilename <> '' then
    if not SetOption(TTidyOptionId.OutFile, PAnsiChar(FFileInputOutput.OutputFilename)) then
      Exit;
  { Accessibility check level }
  if not SetOption(TTidyOptionId.AccessibilityCheckLevel, Ord(FDiagnostics.AccessibilityCheck)) then
    Exit;
  { Diagnostic options }
  for LDiagnosticOption := Low(TTidyDiagnosticsOption) to High(TTidyDiagnosticsOption) do
  if not SetOption(TidyDiagnosticsOptionId[Ord(LDiagnosticOption)], LDiagnosticOption in FDiagnostics.Options) then
    Exit;
  { Display options }
  for LDocumentDisplayOption := Low(TTidyDocumentDisplayOption) to High(TTidyDocumentDisplayOption) do
  if not SetOption(TidyDocumentDisplayOptionId[Ord(LDocumentDisplayOption)], LDocumentDisplayOption in FDocumentDisplay.Options) then
    Exit;
  { Document Input-Output options }
  for LDocumentInAndOutOption := Low(TTidyDocumentInAndOutOption) to High(TTidyDocumentInAndOutOption) do
  if not SetOption(TidyDocumentInAndOutOptionId[Ord(LDocumentInAndOutOption)], LDocumentInAndOutOption in FDocumentInAndOut.Options) then
    Exit;
  { File Input-Output options }
  for LFileInputOutputOption := Low(TTidyFileInputOutputOption) to High(TTidyFileInputOutputOption) do
  if not SetOption(TidyFileInputOutputOptionId[Ord(LFileInputOutputOption)], LFileInputOutputOption in FFileInputOutput.Options) then
    Exit;
  { In/out character encoding }
  if not SetOption(TTidyOptionId.CharEncoding, PAnsiChar(TidyEncodingToAnsiStr(FEncoding.Char))) then
    Exit;
  { Input character encoding (if different) }
  if not SetOption(TTidyOptionId.InCharEncoding, PAnsiChar(TidyEncodingToAnsiStr(FEncoding.Input))) then
    Exit;
  { Output character encoding (if different) }
  if not SetOption(TTidyOptionId.OutCharEncoding, PAnsiChar(TidyEncodingToAnsiStr(FEncoding.Output))) then
    Exit;  
  { Output line ending (default to platform) }
  if not SetOption(TTidyOptionId.Newline, PAnsiChar(TidyNewLineToAnsiStr(FEncoding.NewLine))) then
    Exit; 
  { Output a Byte Order Mark (BOM) for UTF-16 encodings }
  if not SetOption(TTidyOptionId.OutputBOM, PAnsiChar(TidyBooleanToAnsiStr(FEncoding.OutputBOM))) then
    Exit;
  { Cleanup options }
  for LCleanupOption := Low(TTidyCleanupOption) to High(TTidyCleanupOption) do
  if not SetOption(TidyCleanupOptionId[Ord(LCleanupOption)], LCleanupOption in FCleanup.Options) then
    Exit;
  { Merge multiple DIVs }
  if not SetOption(TTidyOptionId.MergeDivs, PAnsiChar(TidyBooleanToAnsiStr(FCleanup.MergeDivs))) then
    Exit;    
  { Merge multiple SPANs }
  if not SetOption(TTidyOptionId.MergeSpans, PAnsiChar(TidyBooleanToAnsiStr(FCleanup.MergeSpans))) then
    Exit; 
  { Entitities options }
  for LEntitiesOption := Low(TTidyEntitiesOption) to High(TTidyEntitiesOption) do
  if not SetOption(TidyEntitiesOptionId[Ord(LEntitiesOption)], LEntitiesOption in FEntities.Options) then
    Exit;
  { Default text for alt attribute }
  if not SetOption(TTidyOptionId.AltText, PAnsiChar(FRepair.AltText)) then
    Exit; 
  { Repair options }
  for LRepairOption := Low(TTidyRepairOption) to High(TTidyRepairOption) do
  if not SetOption(TidyRepairOptionId[Ord(LRepairOption)], LRepairOption in FRepair.Options) then
    Exit;  
  { CSS class naming for clean option }
  if not SetOption(TTidyOptionId.CSSPrefix, PAnsiChar(FRepair.CSSPrefix)) then
    Exit;
  { Enable //Tidy to use autonomous custom tags }
  if not SetOption(TTidyOptionId.UseCustomTags, PAnsiChar(TidyCustomTagToAnsiStr(FRepair.CustomTags))) then
    Exit;
  { Fix comments with adjacent hyphens }
  if not SetOption(TTidyOptionId.FixComments, PAnsiChar(TidyBooleanToAnsiStr(FRepair.FixComments))) then
    Exit;
  { Attributes to place first in an element }
  if not SetOption(TTidyOptionId.PriorityAttributes, PAnsiChar(TidyPriorityAttributesToAnsiStr(FRepair.RepeatedAttributes))) then
    Exit;
  { Output attributes in upper not lower case }
  if not SetOption(TTidyOptionId.UpperCaseAttrs, PAnsiChar(TidyUpperCaseAttributesToAnsiStr(FRepair.UppercaseAttributes))) then
    Exit;
  { Indent content of appropriate tags }
  if not SetOption(TTidyOptionId.IndentContent, PAnsiChar(TidyBooleanToAnsiStr(FPrettyPrint.Indent))) then
    Exit;  
  { Pretty print options }
  for LPrettyPrintOption := Low(TTidyPrettyPrintOption) to High(TTidyPrettyPrintOption) do
  if not SetOption(TidyPrettyPrintOptionId[Ord(LPrettyPrintOption)], LPrettyPrintOption in FPrettyPrint.Options) then
    Exit;
  { Indentation n spaces/tabs }
  if not SetOption(TTidyOptionId.IndentSpaces, FPrettyPrint.IndentSpaces) then
    Exit; 
  { Sort attributes }
  if not SetOption(TTidyOptionId.SortAttributes, PAnsiChar(TidySortAttributesToAnsiStr(FPrettyPrint.SortAttributes))) then
    Exit;
  { Expand tabs to n spaces }
  if not SetOption(TTidyOptionId.TabSize, FPrettyPrint.TabSize) then
    Exit; 
  { Degree to which markup is spread out vertically }
  if not SetOption(TTidyOptionId.VertSpace, PAnsiChar(TidyBooleanToAnsiStr(FPrettyPrint.VerticalSpace))) then
    Exit;
  { Wrap length }
  if not SetOption(TTidyOptionId.WrapLen, FPrettyPrint.WrapLength) then
    Exit;

  Result := True;
end;

function TCustomTidy.Run(const AInput: string): Boolean;
var
  LErrorBuffer: PTidyBuffer;
  LInputBuffer: PTidyBuffer;
  LOutputBuffer: PTidyBuffer;
  LInput: PAnsiChar;
  LSize: Cardinal;

  function CaptureDiagnostics: Boolean;
  begin
    New(LErrorBuffer);

    if Assigned(FProcs.BufInit) then
      FProcs.BufInit(LErrorBuffer);

    if Assigned(FProcs.SetErrorBuffer) then
      FErrorCode := FProcs.SetErrorBuffer(FDocument, LErrorBuffer);

    Result := FErrorCode >= 0;
  end;

  function Parse: Boolean;
  begin
    New(LInputBuffer);

    if Assigned(FProcs.BufInit) then
      FProcs.BufInit(LInputBuffer);

    LInput := PAnsiChar(AnsiString(AInput));
    LSize := System.AnsiStrings.StrLen(LInput);

    if Assigned(FProcs.BufAlloc) then
      FProcs.BufAlloc(LInputBuffer, LSize);

    if Assigned(FProcs.BufAppend) then
      FProcs.BufAppend(LInputBuffer, LInput, LSize);

    if Assigned(FProcs.ParseBuffer) then
      FErrorCode := FProcs.ParseBuffer(FDocument, LInputBuffer);

    Result := FErrorCode >= 0;
  end;

  function Tidy: Boolean;
  begin
    if Assigned(FProcs.CleanAndRepair) then
      FErrorCode := FProcs.CleanAndRepair(FDocument);

    Result := FErrorCode >= 0;
  end;

  function RunDiagnostics: Boolean;
  begin
     if Assigned(FProcs.RunDiagnostics) then
      FErrorCode := FProcs.RunDiagnostics(FDocument);

    Result := FErrorCode >= 0;
  end;

  function PrettyPrint: Boolean;
  begin
    New(LOutputBuffer);

    if Assigned(FProcs.BufInit) then
      FProcs.BufInit(LOutputBuffer);

    if Assigned(FProcs.SaveBuffer) then
      FErrorCode := FProcs.SaveBuffer(FDocument, LOutputBuffer);

    Result := FErrorCode >= 0;
  end;

  procedure CleanUp;
  begin
    if Assigned(LErrorBuffer) then
    begin
      FProcs.BufFree(LErrorBuffer);
      Dispose(LErrorBuffer);
    end;

    if Assigned(LInputBuffer) then
    begin
      FProcs.BufFree(LInputBuffer);
      Dispose(LInputBuffer);
    end;

    if Assigned(LOutputBuffer) then
    begin
      FProcs.BufFree(LOutputBuffer);
      Dispose(LOutputBuffer);
    end;
  end;

  function GetOutputEncoding: TEncoding;
  begin
    case FEncoding.Output of
      teAscii:
        Result := TEncoding.ASCII;
      teLatin0:
        Result := TEncoding.GetEncoding(28605);
      teLatin1:
        Result := TEncoding.GetEncoding(28591);
      teUtf8:
        Result := TEncoding.UTF8;
      teIso2022:
        Result := TEncoding.GetEncoding(50229);
      teMac:
        Result := TEncoding.GetEncoding(10029);
      teWin1252:
        Result := TEncoding.GetEncoding(1252);
      teIbm858:
        Result := TEncoding.GetEncoding(858);
      teUtf16LE, teUtf16:
        Result := TEncoding.Unicode;
      teUtf16BE:
        Result := TEncoding.BigEndianUnicode;
      teBig5:
        Result := TEncoding.GetEncoding(950);
      teShiftJis:
        Result := TEncoding.GetEncoding(932);
    else
      Result := TEncoding.UTF8;
    end;
  end;

  function PByteToString(ABytes: PByte; const ALength: Integer; const AEncoding: TEncoding): string;
  var
    LBytes: TBytes;
  begin
    if Assigned(ABytes) then
    begin
      SetLength(LBytes, ALength);
      Move(ABytes^, LBytes[0], ALength);
      Result := AEncoding.GetString(LBytes);
    end
    else
      Result := '';
  end;

begin
  Result := False;

  InitializeLibrary;
  try
    LErrorBuffer := nil;
    LInputBuffer := nil;
    LOutputBuffer := nil;

    if SetOptions then
    try
      if not CaptureDiagnostics then
        Exit;

      if not Parse then
        Exit;

      if not Tidy then
        Exit;

      if not RunDiagnostics then
        Exit;

      if not PrettyPrint then
        Exit;

      if FErrorCode > 0 then
        FErrors := PByteToString(LErrorBuffer.Bytes, LErrorBuffer.Size, TEncoding.UTF8);

      FOutput := PByteToString(LOutputBuffer.Bytes, LOutputBuffer.Size, GetOutputEncoding);

      Result := True;
    finally
      CleanUp;
    end
    else
      raise Exception.Create(sTidyFailedToSetOptions);
  finally
    FinalizeLibrary;
  end;
end;

end.
