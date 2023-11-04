unit Tidy.Classes;

interface

uses
  System.Classes, Tidy.Types, Tidy.Consts;

type
  TTidyCleanup = class(TPersistent)
  strict private
    FMergeDivs: TTidyBoolean;
    FMergeSpans: TTidyBoolean;
    FOptions: TTidyCleanupOptions;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
    procedure SetOption(const AOption: TTidyCleanupOption; const AEnabled: Boolean);
  published
    property MergeDivs: TTidyBoolean read FMergeDivs write FMergeDivs default tbAuto;
    property MergeSpans: TTidyBoolean read FMergeSpans write FMergeSpans default tbAuto;
    property Options: TTidyCleanupOptions read FOptions write FOptions default TTidyDefault.CleanupOptions;
  end;

  TTidyDiagnostics = class(TPersistent)
  strict private
    FAccessibilityCheck: TTidyAccessibilityCheck;
    FOptions: TTidyDiagnosticsOptions;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
    procedure SetOption(const AOption: TTidyDiagnosticsOption; const AEnabled: Boolean);
  published
    property AccessibilityCheck: TTidyAccessibilityCheck read FAccessibilityCheck write FAccessibilityCheck default acNone;
    property Options: TTidyDiagnosticsOptions read FOptions write FOptions default TTidyDefault.DiagnosticsOptions;
  end;

  TTidyDocumentDisplay = class(TPersistent)
  strict private
    FOptions: TTidyDocumentDisplayOptions;
    FShowBodyOnly: TTidyBoolean;
    FShowErrors: Integer;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
    procedure SetOption(const AOption: TTidyDocumentDisplayOption; const AEnabled: Boolean);
  published
    property Options: TTidyDocumentDisplayOptions read FOptions write FOptions default TTidyDefault.DisplayOptions;
    property ShowBodyOnly: TTidyBoolean read FShowBodyOnly write FShowBodyOnly default tbNo;
    property ShowErrors: Integer read FShowErrors write FShowErrors default 6;
  end;

  TTidyDocumentInAndOut = class(TPersistent)
  strict private
    FDoctype: AnsiString;
    FOptions: TTidyDocumentInAndOutOptions;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
    procedure SetOption(const AOption: TTidyDocumentInAndOutOption; const AEnabled: Boolean);
  published
    property Doctype: AnsiString read FDoctype write FDoctype;
    property Options: TTidyDocumentInAndOutOptions read FOptions write FOptions default TTidyDefault.DocumentInAndOutOptions;
  end;

  TTidyEncodingOptions = class(TPersistent)
  strict private
    FChar: TTidyEncoding;
    FInput: TTidyEncoding;
    FNewLine: TTidyNewLine;
    FOutput: TTidyEncoding;
    FOutputBOM: TTidyBoolean;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
  published
    property Char: TTidyEncoding read FChar write FChar default teUtf8;
    property Input: TTidyEncoding read FInput write FInput default teUtf8;
    property NewLine: TTidyNewLine read FNewLine write FNewLine default nlCRLF;
    property Output: TTidyEncoding read FOutput write FOutput default teUtf8;
    property OutputBOM: TTidyBoolean read FOutputBOM write FOutputBOM default tbAuto;
  end;

  TTidyEntities = class(TPersistent)
  strict private
    FOptions: TTidyEntitiesOptions;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
    procedure SetOption(const AOption: TTidyEntitiesOption; const AEnabled: Boolean);
  published
    property Options: TTidyEntitiesOptions read FOptions write FOptions default TTidyDefault.EntitiesOptions;
  end;

  TTidyFileInputOutput = class(TPersistent)
  strict private
    FErrorFilename: AnsiString;
    FOptions: TTidyFileInputOutputOptions;
    FOutputFilename: AnsiString;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
    procedure SetOption(const AOption: TTidyFileInputOutputOption; const AEnabled: Boolean);
  published
    property ErrorFilename: AnsiString read FErrorFilename write FErrorFilename;
    property Options: TTidyFileInputOutputOptions read FOptions write FOptions default TTidyDefault.FileInputOutputOptions;
    property OutputFilename: AnsiString read FOutputFilename write FOutputFilename;
  end;

  TTidyPrettyPrint = class(TPersistent)
  strict private
    FIndent: TTidyBoolean;
    FIndentSpaces: Integer;
    FOptions: TTidyPrettyPrintOptions;
    FSortAttributes: TTidySortAttributes;
    FTabSize: Integer;
    FVerticalSpace: TTidyBoolean;
    FWrapLength: Integer;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
    procedure SetOption(const AOption: TTidyPrettyPrintOption; const AEnabled: Boolean);
  published
    property Indent: TTidyBoolean read FIndent write FIndent default tbYes;
    property IndentSpaces: Integer read FIndentSpaces write FIndentSpaces default 2;
    property Options: TTidyPrettyPrintOptions read FOptions write FOptions default TTidyDefault.PrettyPrintOptions;
    property SortAttributes: TTidySortAttributes read FSortAttributes write FSortAttributes default saNone;
    property TabSize: Integer read FTabSize write FTabSize default 8;
    property VerticalSpace: TTidyBoolean read FVerticalSpace write FVerticalSpace default tbNo;
    property WrapLength: Integer read FWrapLength write FWrapLength default 120;
  end;

  TTidyRepair = class(TPersistent)
  strict private
    FAltText: AnsiString;
    FCSSPrefix: AnsiString;
    FCustomTags: TTidyCustomTags;
    FFixComments: TTidyBoolean;
    FOptions: TTidyRepairOptions;
    FRepeatedAttributes: TTidyRepeatedAttributes;
    FUppercaseAttributes: TTidyUppercaseAttributes;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
    procedure SetOption(const AOption: TTidyRepairOption; const AEnabled: Boolean);
  published
    property AltText: AnsiString read FAltText write FAltText;
    property CustomTags: TTidyCustomTags read FCustomTags write FCustomTags default ctNo;
    property CSSPrefix: AnsiString read FCSSPrefix write FCSSPrefix;
    property FixComments: TTidyBoolean read FFixComments write FFixComments default tbAuto;
    property Options: TTidyRepairOptions read FOptions write FOptions default TTidyDefault.RepairOptions;
    property RepeatedAttributes: TTidyRepeatedAttributes read FRepeatedAttributes write FRepeatedAttributes default raKeepFirst;
    property UppercaseAttributes: TTidyUppercaseAttributes read FUppercaseAttributes write FUppercaseAttributes default uaNo;
  end;

  TTidyTransformation = class(TPersistent)
  strict private
    FOptions: TTidyTransformationOptions;
  public
    constructor Create;
    procedure Assign(ASource: TPersistent); override;
    procedure SetOption(const AOption: TTidyTransformationOption; const AEnabled: Boolean);
  published
    property Options: TTidyTransformationOptions read FOptions write FOptions default TTidyDefault.TransformationOptions;
  end;

implementation

{ TTidyCleanup }

constructor TTidyCleanup.Create;
begin
  inherited;

  FMergeDivs := tbAuto;
  FMergeSpans := tbAuto;
  FOptions := TTidyDefault.CleanupOptions;
end;

procedure TTidyCleanup.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyCleanup) then
  with ASource as TTidyCleanup do
  begin
    Self.FMergeDivs := FMergeDivs;
    Self.FMergeSpans := FMergeSpans;
    Self.FOptions := FOptions;
  end
  else
    inherited Assign(ASource);
end;

procedure TTidyCleanup.SetOption(const AOption: TTidyCleanupOption; const AEnabled: Boolean);
begin
  if AEnabled then
    Include(FOptions, AOption)
  else
    Exclude(FOptions, AOption);
end;

{ TTidyDiagnostics }

constructor TTidyDiagnostics.Create;
begin
  inherited;

  FAccessibilityCheck := acNone;
  FOptions := TTidyDefault.DiagnosticsOptions;
end;

procedure TTidyDiagnostics.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyDiagnostics) then
  with ASource as TTidyDiagnostics do
  begin
    Self.FAccessibilityCheck := FAccessibilityCheck;
    Self.FOptions := FOptions;
  end
  else
    inherited Assign(ASource);
end;

procedure TTidyDiagnostics.SetOption(const AOption: TTidyDiagnosticsOption; const AEnabled: Boolean);
begin
  if AEnabled then
    Include(FOptions, AOption)
  else
    Exclude(FOptions, AOption);
end;

{ TTidyDocumentDisplay }

constructor TTidyDocumentDisplay.Create;
begin
  inherited;

  FOptions := TTidyDefault.DisplayOptions;
  FShowBodyOnly := tbNo;
  FShowErrors := 6;
end;

procedure TTidyDocumentDisplay.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyDocumentDisplay) then
  with ASource as TTidyDocumentDisplay do
  begin
    Self.FOptions := FOptions;
    Self.FShowBodyOnly := FShowBodyOnly;
  end
  else
    inherited Assign(ASource);
end;

procedure TTidyDocumentDisplay.SetOption(const AOption: TTidyDocumentDisplayOption; const AEnabled: Boolean);
begin
  if AEnabled then
    Include(FOptions, AOption)
  else
    Exclude(FOptions, AOption);
end;

{ TTidyDocumentInAndOut }

constructor TTidyDocumentInAndOut.Create;
begin
  inherited;

  FDoctype := TTidyDefault.DocType;
  FOptions := TTidyDefault.DocumentInAndOutOptions;
end;

procedure TTidyDocumentInAndOut.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyDocumentInAndOut) then
  with ASource as TTidyDocumentInAndOut do
  begin
    Self.FDoctype := FDoctype;
    Self.FOptions := FOptions;
  end
  else
    inherited Assign(ASource);
end;

procedure TTidyDocumentInAndOut.SetOption(const AOption: TTidyDocumentInAndOutOption; const AEnabled: Boolean);
begin
  if AEnabled then
    Include(FOptions, AOption)
  else
    Exclude(FOptions, AOption);
end;

{ TTidyEncoding }

constructor TTidyEncodingOptions.Create;
begin
  inherited;

  FChar := teUtf8;
  FInput := teUtf8;
  FNewLine := nlCRLF;
  FOutput := teUtf8;
  FOutputBOM := tbAuto;
end;

procedure TTidyEncodingOptions.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyDocumentInAndOut) then
  with ASource as TTidyDocumentInAndOut do
  begin
    Self.FChar := FChar;
    Self.FInput := FInput;
    Self.FNewLine := FNewLine;
    Self.FOutput := FOutput;
    Self.FOutputBOM := FOutputBOM;
  end
  else
    inherited Assign(ASource);
end;

{ TTidyEntities }

constructor TTidyEntities.Create;
begin
  inherited;

  FOptions := TTidyDefault.EntitiesOptions;
end;

procedure TTidyEntities.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyEntities) then
  with ASource as TTidyEntities do
  begin
    Self.FOptions := FOptions;
  end
  else
    inherited Assign(ASource);
end;

procedure TTidyEntities.SetOption(const AOption: TTidyEntitiesOption; const AEnabled: Boolean);
begin
  if AEnabled then
    Include(FOptions, AOption)
  else
    Exclude(FOptions, AOption);
end;

{ TTidyFileInputOutput }

constructor TTidyFileInputOutput.Create;
begin
  inherited;

  FErrorFilename := '';
  FOptions := TTidyDefault.FileInputOutputOptions;
  FOutputFilename := '';
end;

procedure TTidyFileInputOutput.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyFileInputOutput) then
  with ASource as TTidyFileInputOutput do
  begin
    Self.FErrorFilename := FErrorFilename;
    Self.FOptions := FOptions;
    Self.FOutputFilename := FOutputFilename;
  end
  else
    inherited Assign(ASource);
end;

procedure TTidyFileInputOutput.SetOption(const AOption: TTidyFileInputOutputOption; const AEnabled: Boolean);
begin
  if AEnabled then
    Include(FOptions, AOption)
  else
    Exclude(FOptions, AOption);
end;

{ TTidyPrettyPrint }

constructor TTidyPrettyPrint.Create;
begin
  inherited;

  FIndent := tbYes;
  FIndentSpaces := 2;
  FOptions := TTidyDefault.PrettyPrintOptions;
  FSortAttributes := saNone;
  FTabSize := 8;
  FVerticalSpace := tbNo;
  FWrapLength := 120;
end;

procedure TTidyPrettyPrint.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyPrettyPrint) then
  with ASource as TTidyPrettyPrint do
  begin
    Self.FIndent := FIndent;
    Self.FIndentSpaces := FIndentSpaces;
    Self.FOptions := FOptions;
    Self.FSortAttributes := FSortAttributes;
    Self.FTabSize := FTabSize;
    Self.FVerticalSpace := FVerticalSpace;
    Self.FWrapLength := FWrapLength;
  end
  else
    inherited Assign(ASource);
end;

procedure TTidyPrettyPrint.SetOption(const AOption: TTidyPrettyPrintOption; const AEnabled: Boolean);
begin
  if AEnabled then
    Include(FOptions, AOption)
  else
    Exclude(FOptions, AOption);
end;

{ TTidyRepair }

constructor TTidyRepair.Create;
begin
  inherited;

  FAltText := '';
  FCSSPrefix := TTidyDefault.CSSPrefix;
  FCustomTags := ctNo;
  FFixComments := tbAuto;
  FOptions := TTidyDefault.RepairOptions;
  FRepeatedAttributes := raKeepFirst;
  FUppercaseAttributes := uaNo;
end;

procedure TTidyRepair.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyRepair) then
  with ASource as TTidyRepair do
  begin
    Self.FAltText := FAltText;
    Self.FCSSPrefix := FCSSPrefix;
    Self.FCustomTags := FCustomTags;
    Self.FFixComments := FFixComments;
    Self.FOptions := FOptions;
    Self.FRepeatedAttributes := FRepeatedAttributes;
    Self.FUppercaseAttributes := FUppercaseAttributes;
  end
  else
    inherited Assign(ASource);
end;

procedure TTidyRepair.SetOption(const AOption: TTidyRepairOption; const AEnabled: Boolean);
begin
  if AEnabled then
    Include(FOptions, AOption)
  else
    Exclude(FOptions, AOption);
end;

{ TTidyTransformation }

constructor TTidyTransformation.Create;
begin
  inherited;

  FOptions := TTidyDefault.TransformationOptions;
end;

procedure TTidyTransformation.Assign(ASource: TPersistent);
begin
  if Assigned(ASource) and (ASource is TTidyTransformation) then
  with ASource as TTidyTransformation do
    Self.FOptions := FOptions
  else
    inherited Assign(ASource);
end;

procedure TTidyTransformation.SetOption(const AOption: TTidyTransformationOption; const AEnabled: Boolean);
begin
  if AEnabled then
    Include(FOptions, AOption)
  else
    Exclude(FOptions, AOption);
end;

end.
