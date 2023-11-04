unit Tidy.Types;

interface

uses
  Winapi.Windows;

type
  PTidyAllocatorVtbl = ^TTidyAllocatorVtbl;
  PTidyAllocator = ^TTidyAllocator;
  PTidyBuffer = ^TTidyBuffer;

  TTidyAllocator = record
    Vtbl: PTidyAllocatorVtbl;
  end;

  TTidyAlloc = function(ASelf: PTidyAllocator; ABytes: Cardinal): Pointer; cdecl;
  TTidyRealloc = function(ASelf: PTidyAllocator; ABlock: Pointer; ABytes: Cardinal): Pointer; cdecl;
  TTidyFree = procedure(ASelf: PTidyAllocator; APlock: Pointer); cdecl;
  TTidyPanic = procedure(ASelf: PTidyAllocator; AMessage: PAnsiChar); cdecl;

  TTidyAllocatorVtbl = record
    Alloc: TTidyAlloc;
    Realloc: TTidyRealloc;
    Free: TTidyFree;
    Panic: TTidyPanic;
  end;

  TTidyBuffer = record
    Allocator: PTidyAllocator;
    Bytes: PByte;
    Size: Cardinal;
    Allocated: Cardinal;
    Next: Cardinal;
  end;

  TTidyBufAlloc = procedure(ABuffer: PTidyBuffer; ASize: Cardinal); cdecl;
  TTidyBufAppend = procedure(ABuffer: PTidyBuffer; AValue: Pointer; ASize: Cardinal); cdecl;
  TTidyBufFree = procedure(ABuffer: PTidyBuffer); cdecl;
  TTidyBufInit = procedure(ABuffer: PTidyBuffer); cdecl;
  TTidyCleanAndRepair = function(ADocument: Pointer): Integer; cdecl;
  TTidyCreate = function: Pointer; cdecl;
  TTidyOptSetBool = function(ADocument: Pointer; AOptionId: Cardinal; AValue: Bool): LongBool; cdecl;
  TTidyOptSetInt = function(ADocument: Pointer; AOptionId: Cardinal; AValue: Cardinal): LongBool; cdecl;
  TTidyOptSetValue = function(ADocument: Pointer; AOptionId: Cardinal; AValue: PAnsiChar): LongBool; cdecl;
  TTidyParseBuffer = function(ADocument: Pointer; ABuffer: PTidyBuffer): Integer; cdecl;
  TTidyRelease = procedure(ADocument: Pointer); cdecl;
  TTidyRunDiagnostics = function(ADocument: Pointer): Integer; cdecl;
  TTidySaveBuffer = function(ADocument: Pointer; ABuffer: PTidyBuffer): Integer; cdecl;
  TTidySetErrorBuffer = function(ADocument: Pointer; ABuffer: PTidyBuffer): Integer; cdecl;

  TTidyProcs = record
    BufAlloc: TTidyBufAlloc;
    BufAppend: TTidyBufAppend;
    BufFree: TTidyBufFree;
    BufInit: TTidyBufInit;
    CleanAndRepair: TTidyCleanAndRepair;
    Create: TTidyCreate;
    OptSetBool: TTidyOptSetBool;
    OptSetInt: TTidyOptSetInt;
    OptSetValue: TTidyOptSetValue;
    ParseBuffer: TTidyParseBuffer;
    Release: TTidyRelease;
    RunDiagnostics: TTidyRunDiagnostics;
    SaveBuffer: TTidySaveBuffer;
    SetErrorBuffer: TTidySetErrorBuffer;
  end;

  TTidyAccessibilityCheck = (acNone, acPriorityLevel1, acPriorityLevel2, acPriorityLevel3);
  TTidyBoolean = (tbAuto, tbNo, tbYes);
  TTidyEncoding = (teAscii, teLatin0, teLatin1, teUtf8, teIso2022, teMac, teWin1252, teIbm858, teUtf16LE,
    teUtf16BE, teUtf16, teBig5, teShiftJIS);
  TTidyNewLine = (nlLF, nlCRLF, nlCR);
  TTidyCustomTags = (ctNo, ctBlocklevel, ctEmpty, ctInline, ctPre);
  TTidyRepeatedAttributes = (raKeepFirst, raKeepLast);
  TTidyUppercaseAttributes = (uaNo, uaYes, uaPreserve);
  TTidySortAttributes = (saNone, saAlpha);

  TTidyCleanupOption = (coDropEmptyElements, coDropEmptyParagraphs, coDropProprietaryAttributes, coGoogleDocClean,
    coLogicalEmphasis, coMakeBare, coMakeClean, coStripOutWord2000Inserts);
  TTidyCleanupOptions = set of TTidyCleanupOption;

  TTidyDiagnosticsOption = (doForceOutput, doShowMetaChange, doWarnProprietaryAttributes);
  TTidyDiagnosticsOptions = set of TTidyDiagnosticsOption;

  TTidyDocumentDisplayOption = (doEmacs, doQuiet, doShowFilename, doShowInfo, doShowMarkup, doShowWarnings);
  TTidyDocumentDisplayOptions = set of TTidyDocumentDisplayOption;

  TTidyDocumentInAndOutOption = (dioAddMetaCharset, dioAddXMLDeclaration, dioAddXMLSpace, dioInputXML, dioOutputHTML,
    dioOutputXHTML, dioOutputXML);
  TTidyDocumentInAndOutOptions = set of TTidyDocumentInAndOutOption;

  TTidyFileInputOutputOption = (fioKeepFileTimes, fioWriteBack);
  TTidyFileInputOutputOptions = set of TTidyFileInputOutputOption;

  TTidyEntitiesOption = (eoASCIIChars, eoAllowNumericCharacterReferences, eoUseNumericEntities, eoPreserveEntities,
    eoQuoteAmpersand, eoQuoteMarks, eoQuoteNonBreakingSpace);
  TTidyEntitiesOptions = set of TTidyEntitiesOption;

  TTidyPrettyPrintOption = (ppBreakBeforeBR, ppIndentAttributes, ppIndentCDATA, ppIndentWithTabs, ppKeepTabs,
    ppOmitOptionalTags, ppPunctuationWrap, ppTidyMetaMark, ppWrapASP, ppWrapAttibutes, ppWrapJSTE, ppWrapPHP,
    ppWrapScriptLiterals, ppWrapSections);
  TTidyPrettyPrintOptions = set of TTidyPrettyPrintOption;

  TTidyRepairOption = (roAnchorAsName, roCoerceEndTags, roEncloseBlockText, roEncloseBodyText, roEscapeScripts,
    roFixBackslash, roFixURI, roLiteralAttributes, roLowerLiterals, roMoveStyleToHead, roSkipNested,
    roStrictTagsAndAttributes, roUpperCaseTags);
  TTidyRepairOptions = set of TTidyRepairOption;

  TTidyTransformationOption = (toDecorateInferredUL, toEscapeCDATA, toHideComments, toJoinClasses, toJoinStyles,
    toMergeEmphasis, toReplaceColor);
  TTidyTransformationOptions = set of TTidyTransformationOption;

  TTidyDefault = record
  const
    CleanupOptions = [coDropEmptyElements, coDropEmptyParagraphs];
    CSSPrefix = 'c';
    DiagnosticsOptions = [doForceOutput, doWarnProprietaryAttributes];
    DisplayOptions = [doShowMarkup, doQuiet, doShowWarnings];
    DocType = 'auto';
    DocumentInAndOutOptions = [dioOutputHTML];
    EntitiesOptions = [eoAllowNumericCharacterReferences, eoQuoteAmpersand, eoQuoteNonBreakingSpace];
    FileInputOutputOptions = [];
    PrettyPrintOptions = [ppWrapASP, ppWrapJSTE, ppWrapSections];
    RepairOptions = [roAnchorAsName, roCoerceEndTags, roEscapeScripts, roFixBackslash, roFixURI, roLowerLiterals,
      roMoveStyleToHead, roSkipNested];
    TransformationOptions = [toJoinStyles, toMergeEmphasis];
  end;

  function TidyBooleanToAnsiStr(const AValue: TTidyBoolean): AnsiString;
  function TidyCustomTagToAnsiStr(const AValue: TTidyCustomTags): AnsiString;
  function TidyEncodingToAnsiStr(const AValue: TTidyEncoding): AnsiString;
  function TidyNewLineToAnsiStr(const AValue: TTidyNewLine): AnsiString;
  function TidyPriorityAttributesToAnsiStr(const AValue: TTidyRepeatedAttributes): AnsiString;
  function TidySortAttributesToAnsiStr(const AValue: TTidySortAttributes): AnsiString;
  function TidyUpperCaseAttributesToAnsiStr(const AValue: TTidyUppercaseAttributes): AnsiString;

implementation

function TidyBooleanToAnsiStr(const AValue: TTidyBoolean): AnsiString;
begin
  case AValue of
    tbAuto:
      Result := 'auto';
    tbNo:
      Result := 'no';
    tbYes:
      Result := 'yes';
  end;
end;

function TidyCustomTagToAnsiStr(const AValue: TTidyCustomTags): AnsiString;
begin
  case AValue of
    ctNo:
      Result := 'no';
    ctBlocklevel:
      Result := 'blocklevel';
    ctEmpty:
      Result := 'empty';
    ctInline:
      Result := 'inline';
    ctPre:
      Result := 'pre';
  end;
end;

function TidyEncodingToAnsiStr(const AValue: TTidyEncoding): AnsiString;
begin
  case AValue of
    teAscii:
      Result := 'ascii';
    teLatin0:
      Result := 'latin0';
    teLatin1:
      Result := 'latin1';
    teUtf8:
      Result := 'utf8';
    teIso2022:
      Result := 'iso2022';
    teMac:
      Result := 'mac';
    teWin1252:
      Result := 'win1252';
    teIbm858:
      Result := 'ibm858';
    teUtf16LE:
      Result := 'utf16le';
    teUtf16BE:
      Result := 'utf16be';
    teUtf16:
      Result := 'utf16';
    teBig5:
      Result := 'bih5';
    teShiftJIS:
      Result := 'shiftjis';
  end;
end;

function TidyNewLineToAnsiStr(const AValue: TTidyNewLine): AnsiString;
begin
  case AValue of
    nlLF:
      Result := 'LF';
    nlCRLF:
      Result := 'CRLF';
    nlCR:
      Result := 'CR';
  end;
end;

function TidyPriorityAttributesToAnsiStr(const AValue: TTidyRepeatedAttributes): AnsiString;
begin
  case AValue of
    raKeepFirst:
      Result := 'keep-first';
    raKeepLast:
      Result := 'keep-last';
  end;
end;

function TidySortAttributesToAnsiStr(const AValue: TTidySortAttributes): AnsiString;
begin
  case AValue of
    saNone:
      Result := 'none';
    saAlpha:
      Result := 'alpha';
  end;
end;

function TidyUpperCaseAttributesToAnsiStr(const AValue: TTidyUppercaseAttributes): AnsiString;
begin
  case AValue of
    uaNo:
      Result := 'no';
    uaYes:
      Result := 'yes';
    uaPreserve:
      Result := 'preserve';
  end;
end;

end.
