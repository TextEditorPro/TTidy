unit Tidy.Consts;

interface

const
  DEFAULT_LIBRARY_NAME = 'Tidy.dll';

resourcestring
  sTidyFailedToSetOptions = 'Failed to set Tidy options.';
  sTidyFailedToLoadDLL = 'Failed to load Tidy DLL.';

type
  TTidyProcName = record
  const
    BufAlloc = 'tidyBufAlloc';
    BufAppend = 'tidyBufAppend';
    BufFree = 'tidyBufFree';
    BufInit = 'tidyBufInit';
    CleanAndRepair = 'tidyCleanAndRepair';
    Create = 'tidyCreate';
    OptSetBool = 'tidyOptSetBool';
    OptSetInt = 'tidyOptSetInt';
    OptSetValue = 'tidyOptSetValue';
    ParseBuffer = 'tidyParseBuffer';
    Release = 'tidyRelease';
    RunDiagnostics = 'tidyRunDiagnostics';
    SaveBuffer = 'tidySaveBuffer';
    SetErrorBuffer = 'tidySetErrorBuffer';
  end;

  TTidyOptionId = record
  const
    AccessibilityCheckLevel = 1; // Accessibility check level
    AltText = 2;                 // Default text for alt attribute
    AnchorAsName = 3;            // Define anchors as name attributes
    AsciiChars = 4;              // Convert quotes and dashes to nearest ASCII char
    //BlockTags = 5;             // Teaching: Declared block tags
    BodyOnly = 6;                // Output BODY content only
    BreakBeforeBR = 7;           // Output newline before <br> or not?
    CSSPrefix = 10;              // CSS class naming for clean option
    CharEncoding = 8;            // In/out character encoding
    CoerceEndTags = 9;           // Coerce end tags from start tags where probably intended
    DecorateInferredUL = 12;     // Mark inferred UL elements with no indent CSS
    Doctype = 13;                // User specified doctype
    DropEmptyElems = 15;         // Discard empty elements
    DropEmptyParas = 16;         // Discard empty p elements
    DropPropAttrs = 17;          // Discard proprietary attributes
    //DuplicateAttrs = 18;       // Keep first or last duplicate attribute
    Emacs = 19;                  // If true; format error output for GNU Emacs
    //EmptyTags = 21;            // Teaching: Declared empty tags
    EncloseBlockText = 22;       // If yes text in blocks is wrapped in P's
    EncloseBodyText = 23;        // If yes text at body is wrapped in P's
    ErrFile = 24;                // File name to write errors to
    EscapeCdata = 25;            // Replace <![CDATA[]]> sections with escaped text
    EscapeScripts = 26;          // Escape items that look like closing tags in script tags
    FixBackslash = 27;           // Fix URLs by replacing \ with /
    FixComments = 28;            // Fix comments with adjacent hyphens
    FixUri = 29;                 // Applies URI encoding if necessary
    ForceOutput = 30;            // Output document even if errors were found
    GDocClean = 31;              // Clean up HTML exported from Google Docs
    HideComments = 32;           // Hides all (real) comments in output
    HtmlOut = 33;                // Output plain HTML; even for XHTML input.
    InCharEncoding = 34;         // Input character encoding (if different)
    IndentAttributes = 35;       // Newline+indent before each attribute
    IndentCdata = 36;            // Indent <!CDATA[ ... ]]> section
    IndentContent = 37;          // Indent content of appropriate tags
    IndentSpaces = 38;           // Indentation n spaces/tabs
    //InlineTags = 39;           // Teaching: Declared inline tags
    JoinClasses = 40;            // Join multiple class attributes
    JoinStyles = 41;             // Join multiple style attributes
    KeepFileTimes = 42;          // If yes last modied time is preserved
    KeepTabs = 43;               // If yes keep input source tabs
    LiteralAttribs = 44;         // If true attributes may use newlines
    LogicalEmphasis = 45;        // Replace i by em and b by strong
    LowerLiterals = 46;          // Folds known attribute values to lower case
    MakeBare = 47;               // Replace smart quotes; em dashes; etc with ASCII
    MakeClean = 48;              // Replace presentational clutter by style rules
    Mark = 49;                   // Add meta element indicating tidied doc
    MergeDivs = 50;              // Merge multiple DIVs
    MergeEmphasis = 51;          // Merge nested B and I elements
    MergeSpans = 52;             // Merge multiple SPANs
    MetaCharset = 53;            // Adds/checks/fixes meta charset in the head; based on document type
    //MuteReports = 54;          // Filter these messages from output.
    //MuteShow = 55;             // Show message ID's in the error table
    NCR = 56;                    // Allow numeric character references
    Newline = 57;                // Output line ending (default to platform)
    NumEntities = 58;            // Use numeric entities
    OmitOptionalTags = 59;       // Suppress optional start tags and end tags
    OutCharEncoding = 60;        // Output character encoding (if different)
    OutFile = 61;                // File name to write markup to
    OutputBOM = 62;              // Output a Byte Order Mark (BOM) for UTF-16 encodings
    PPrintTabs = 63;             // Indent using tabs instead of spaces
    //PreTags = 65;              // Teaching: Declared pre tags
    PreserveEntities = 64;       // Preserve entities
    PriorityAttributes = 66;     // Attributes to place first in an element
    PunctWrap = 67;              // consider punctuation and breaking spaces for wrapping
    Quiet = 68;                  // No 'Parsing X'; guessed DTD or summary
    QuoteAmpersand = 69;         // Output naked ampersand as &amp;
    QuoteMarks = 70;             // Output " marks as &quot;
    QuoteNbsp = 71;              // Output non-breaking space as entity
    ReplaceColor = 72;           // Replace hex color attribute values with names
    ShowErrors = 73;             // Number of errors to put out
    ShowFilename = 74;           // If true; the input filename is displayed with the error messages
    ShowInfo = 75;               // If true; info-level messages are shown
    ShowMarkup = 76;             // If false; normal output is suppressed
    ShowMetaChange = 77;         // show when meta http-equiv content charset was changed - compatibility
    ShowWarnings = 78;           // However errors are always shown
    SkipNested = 79;             // Skip nested tags in script and style CDATA
    SortAttributes = 80;         // Sort attributes
    StrictTagsAttr = 81;         // Ensure tags and attributes match output HTML version
    StyleTags = 82;              // Move style to head
    TabSize = 83;                // Expand tabs to n spaces
    UpperCaseAttrs = 84;         // Output attributes in upper not lower case
    UpperCaseTags = 85;          // Output tags in upper not lower case
    UseCustomTags = 86;          // Enable //Tidy to use autonomous custom tags
    VertSpace = 87;              // Degree to which markup is spread out vertically
    WarnPropAttrs = 88;          // Warns on proprietary attributes
    Word2000 = 89;                // Draconian cleaning for Word2000
    WrapAsp = 90;                // Wrap within ASP pseudo elements
    WrapAttVals = 91;            // Wrap within attribute values
    WrapJste = 92;               // Wrap within JSTE pseudo elements
    WrapLen = 93;                // Wrap margin
    WrapPhp = 94;                // Wrap consecutive PHP pseudo elements
    WrapScriptlets = 95;         // Wrap within JavaScript string literals
    WrapSection = 96;            // Wrap within <![ ... ]> section tags
    WriteBack = 97;              // If true then output tidied markup
    XhtmlOut = 98;               // Output extensible HTML
    XmlDecl = 99;                // Add <?xml?> for XML docs
    XmlOut = 100;                // Create output as XML
    // XmlPIs = 101;             // This option is automatically set if the input is in XML.
    XmlSpace = 102;              // If set to yes adds xml:space attr as needed
    XmlTags = 103;               // Treat input as XML
  end;

const
  TidyCleanupOptionId: array[0..7] of Integer = (
    TTidyOptionId.DropEmptyElems,
    TTidyOptionId.DropEmptyParas,
    TTidyOptionId.DropPropAttrs,
    TTidyOptionId.GDocClean,
    TTidyOptionId.LogicalEmphasis,
    TTidyOptionId.MakeBare,
    TTidyOptionId.MakeClean,
    TTidyOptionId.Word2000);

  TidyDiagnosticsOptionId: array[0..2] of Integer = (
    TTidyOptionId.ForceOutput,
    TTidyOptionId.ShowMetaChange,
    TTidyOptionId.WarnPropAttrs);

  TidyDocumentDisplayOptionId: array[0..5] of Integer = (
    TTidyOptionId.Emacs,
    TTidyOptionId.Quiet,
    TTidyOptionId.ShowFilename,
    TTidyOptionId.ShowInfo,
    TTidyOptionId.ShowMarkup,
    TTidyOptionId.ShowWarnings);

  TidyDocumentInAndOutOptionId: array[0..6] of Integer = (
    TTidyOptionId.MetaCharset,
    TTidyOptionId.XmlDecl,
    TTidyOptionId.XmlSpace,
    TTidyOptionId.XmlTags,
    TTidyOptionId.HtmlOut,
    TTidyOptionId.XhtmlOut,
    TTidyOptionId.XmlOut);

  TidyEntitiesOptionId: array[0..6] of Integer = (
    TTidyOptionId.AsciiChars,
    TTidyOptionId.NCR,
    TTidyOptionId.NumEntities,
    TTidyOptionId.PreserveEntities,
    TTidyOptionId.QuoteAmpersand,
    TTidyOptionId.QuoteMarks,
    TTidyOptionId.QuoteNbsp
  );

  TidyFileInputOutputOptionId: array[0..1] of Integer = (
    TTidyOptionId.KeepFileTimes,
    TTidyOptionId.WriteBack);

  TidyPrettyPrintOptionId: array[0..13] of Integer = (
    TTidyOptionId.BreakBeforeBR,
    TTidyOptionId.IndentAttributes,
    TTidyOptionId.IndentCdata,
    TTidyOptionId.PPrintTabs,
    TTidyOptionId.KeepTabs,
    TTidyOptionId.OmitOptionalTags,
    TTidyOptionId.PunctWrap,
    TTidyOptionId.Mark,
    TTidyOptionId.WrapAsp,
    TTidyOptionId.WrapAttVals,
    TTidyOptionId.WrapJste,
    TTidyOptionId.WrapPhp,
    TTidyOptionId.WrapScriptlets,
    TTidyOptionId.WrapSection);

  TidyRepairOptionId: array[0..12] of Integer = (
    TTidyOptionId.AnchorAsName,
    TTidyOptionId.CoerceEndTags,
    TTidyOptionId.EncloseBlockText,
    TTidyOptionId.EncloseBodyText,
    TTidyOptionId.EscapeScripts,
    TTidyOptionId.FixBackslash,
    TTidyOptionId.FixUri,
    TTidyOptionId.LiteralAttribs,
    TTidyOptionId.LowerLiterals,
    TTidyOptionId.StyleTags,
    TTidyOptionId.SkipNested,
    TTidyOptionId.StrictTagsAttr,
    TTidyOptionId.UpperCaseTags);

  TidyTransformationOptionId: array[0..6] of Integer = (
    TTidyOptionId.DecorateInferredUL,
    TTidyOptionId.EscapeCdata,
    TTidyOptionId.HideComments,
    TTidyOptionId.JoinClasses,
    TTidyOptionId.JoinStyles,
    TTidyOptionId.MergeEmphasis,
    TTidyOptionId.ReplaceColor);

implementation

end.
