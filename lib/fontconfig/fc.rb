require "ffi"

module Fontconfig
  module ObjectSetLayout
    def self.included(base)
      base.class_eval do
        layout :nobject, :int,
               :sobject, :int,
               :objects, :pointer
      end
    end
  end

  class ObjectSet < FFI::Struct
    include ObjectSetLayout
  end

  class ObjectSetManaged < FFI::ManagedStruct
    include ObjectSetLayout
  end

  class FontSet < FFI::Struct
    layout :nfont, :int,
           :sfont, :int,
           :fonts, :pointer  # :FcPatternPtrPtr
  end

  module Fc
    extend ::FFI::Library
    ffi_lib "libfontconfig"

    typedef :uchar, :FcChar8
    typedef :pointer, :string # TODO: this is just :string
    typedef :pointer, :stringPtr # TODO: this is just a :pointer to :string
    typedef :ushort, :FcChar16
    typedef :uint, :FcChar32
    typedef :pointer, :FcChar32Ptr
    typedef :int, :FcBool
    typedef :pointer, :stringPtr
    typedef :pointer, :FcBoolPtr
    typedef :pointer, :intPtr
    typedef :pointer, :doublePtr

    # TODO: Dunno if this is right, but may not really matter
    # It's used to mark the last enum value and wouldn't normally be referenced
    INT_MAX = FIXNUM_MAX = (2**(0.size * 8 -2) -1)

    # /*
    #  * Current Fontconfig version number.  This same number
    #  * must appear in the fontconfig configure.in file. Yes,
    #  * it'a a pain to synchronize version numbers like this.
    #  */

    FC_MAJOR = 2
    FC_MINOR = 12
    FC_REVISION = 6

    FC_VERSION = ((FC_MAJOR * 10000) + (FC_MINOR * 100) + (FC_REVISION))

    # /*
    #  * Current font cache file format version
    #  * This is appended to the cache files so that multiple
    #  * versions of the library will peacefully coexist
    #  *
    #  * Change this value whenever the disk format for the cache file
    #  * changes in any non-compatible way.  Try to avoid such changes as
    #  * it means multiple copies of the font information.
    #  */

    # FC_CACHE_VERSION_NUMBER = 7
    # _FC_STRINGIFY_(s) = #s
    # _FC_STRINGIFY(s) = _FC_STRINGIFY_(s)
    # FC_CACHE_VERSION = _FC_STRINGIFY(FC_CACHE_VERSION_NUMBER)
    FC_CACHE_VERSION = "7"

    FcTrue = 1
    FcFalse = 0

    FC_FAMILY = "family"    # /*String */
    FC_STYLE = "style"   # /*String */
    FC_SLANT = "slant"   # /*Int */
    FC_WEIGHT = "weight"    # /*Int */
    FC_SIZE = "size"    # /*Range (double) */
    FC_ASPECT = "aspect"    # /*:doublePtr/
    FC_PIXEL_SIZE = "pixelsize"   # /*:doublePtr/
    FC_SPACING = "spacing"   # /*Int */
    FC_FOUNDRY = "foundry"   # /*String */
    FC_ANTIALIAS = "antialias"   # /*Bool (depends) */
    FC_HINTING = "hinting"   # /*Bool (true) */
    FC_HINT_STYLE = "hintstyle"   # /*Int */
    FC_VERTICAL_LAYOUT = "verticallayout"  # /*Bool (false) */
    FC_AUTOHINT = "autohint"    # /*Bool (false) */
    # /*FC_GLOBAL_ADVANCE is deprecated. this is simply ignored on freetype 2.4.5 or later */
    FC_GLOBAL_ADVANCE = "globaladvance" # /*Bool (true) */
    FC_WIDTH = "width"   # /*Int */
    FC_FILE = "file"    # /*String */
    FC_INDEX = "index"   # /*Int */
    FC_FT_FACE = "ftface"    # /*FT_Face */
    FC_RASTERIZER = "rasterizer"  # /*String (deprecated) */
    FC_OUTLINE = "outline"   # /*Bool */
    FC_SCALABLE = "scalable"    # /*Bool */
    FC_COLOR = "color"   # /*Bool */
    FC_SCALE = "scale"   # /*double (deprecated) */
    FC_SYMBOL = "symbol"    # /*Bool */
    FC_DPI = "dpi"   # /*:doublePtr/
    FC_RGBA = "rgba"    # /*Int */
    FC_MINSPACE = "minspace"    # /*Bool use minimum line spacing */
    FC_SOURCE = "source"    # /*String (deprecated) */
    FC_CHARSET = "charset"   # /*CharSet */
    FC_LANG = "lang"    # /*String RFC 3066 langs */
    FC_FONTVERSION = "fontversion" # /*:int 'head' table */
    FC_FULLNAME = "fullname"    # /*String */
    FC_FAMILYLANG = "familylang"  # /*String RFC 3066 langs */
    FC_STYLELANG = "stylelang"   # /*String RFC 3066 langs */
    FC_FULLNAMELANG = "fullnamelang"  # /*String RFC 3066 langs */
    FC_CAPABILITY = "capability"  # /*String */
    FC_FONTFORMAT = "fontformat"  # /*String */
    FC_EMBOLDEN = "embolden"    # /*Bool - true if emboldening needed*/
    FC_EMBEDDED_BITMAP = "embeddedbitmap"  # /*Bool - true to enable embedded bitmaps */
    FC_DECORATIVE = "decorative"  # /*Bool - true if style is a decorative variant */
    FC_LCD_FILTER = "lcdfilter"   # /*Int */
    FC_FONT_FEATURES = "fontfeatures"  # /*String */
    FC_NAMELANG = "namelang"    # /*String RFC 3866 langs */
    FC_PRGNAME = "prgname"   # /*String */
    FC_HASH = "hash"    # /*String (deprecated) */
    FC_POSTSCRIPT_NAME = "postscriptname"  # /*String */

    FC_CACHE_SUFFIX = ".cache-" + FC_CACHE_VERSION
    FC_DIR_CACHE_FILE = "fonts.cache-" + FC_CACHE_VERSION
    FC_USER_CACHE_FILE = ".fonts.cache-" + FC_CACHE_VERSION

    # /*Adjust outline rasterizer */
    FC_CHARWIDTH = "charwidth" # /*Int */
    FC_CHAR_WIDTH = FC_CHARWIDTH
    FC_CHAR_HEIGHT = "charheight"# /*Int */
    FC_MATRIX = "matrix"    # /*FcMatrix */

    FC_WEIGHT_THIN = 0
    FC_WEIGHT_EXTRALIGHT = 40
    FC_WEIGHT_ULTRALIGHT = FC_WEIGHT_EXTRALIGHT
    FC_WEIGHT_LIGHT = 50
    FC_WEIGHT_DEMILIGHT = 55
    FC_WEIGHT_SEMILIGHT = FC_WEIGHT_DEMILIGHT
    FC_WEIGHT_BOOK = 75
    FC_WEIGHT_REGULAR = 80
    FC_WEIGHT_NORMAL = FC_WEIGHT_REGULAR
    FC_WEIGHT_MEDIUM = 100
    FC_WEIGHT_DEMIBOLD = 180
    FC_WEIGHT_SEMIBOLD = FC_WEIGHT_DEMIBOLD
    FC_WEIGHT_BOLD = 200
    FC_WEIGHT_EXTRABOLD = 205
    FC_WEIGHT_ULTRABOLD = FC_WEIGHT_EXTRABOLD
    FC_WEIGHT_BLACK = 210
    FC_WEIGHT_HEAVY = FC_WEIGHT_BLACK
    FC_WEIGHT_EXTRABLACK = 215
    FC_WEIGHT_ULTRABLACK = FC_WEIGHT_EXTRABLACK

    FC_SLANT_ROMAN = 0
    FC_SLANT_ITALIC = 100
    FC_SLANT_OBLIQUE = 110

    FC_WIDTH_ULTRACONDENSED = 50
    FC_WIDTH_EXTRACONDENSED = 63
    FC_WIDTH_CONDENSED = 75
    FC_WIDTH_SEMICONDENSED = 87
    FC_WIDTH_NORMAL = 100
    FC_WIDTH_SEMIEXPANDED = 113
    FC_WIDTH_EXPANDED = 125
    FC_WIDTH_EXTRAEXPANDED = 150
    FC_WIDTH_ULTRAEXPANDED = 200

    FC_PROPORTIONAL = 0
    FC_DUAL = 90
    FC_MONO = 100
    FC_CHARCELL = 110

    # /*sub-pixel order */
    FC_RGBA_UNKNOWN = 0
    FC_RGBA_RGB = 1
    FC_RGBA_BGR = 2
    FC_RGBA_VRGB = 3
    FC_RGBA_VBGR = 4
    FC_RGBA_NONE = 5

    # /*hinting style */
    FC_HINT_NONE = 0
    FC_HINT_SLIGHT = 1
    FC_HINT_MEDIUM = 2
    FC_HINT_FULL = 3

    # /*LCD filter */
    FC_LCD_NONE = 0
    FC_LCD_DEFAULT = 1
    FC_LCD_LIGHT = 2
    FC_LCD_LEGACY = 3

    enum :FcType, [
      :FcTypeUnknown, -1,
      :FcTypeVoid,
      :FcTypeInteger,
      :FcTypeDouble,
      :FcTypeString,
      :FcTypeBool,
      :FcTypeMatrix,
      :FcTypeCharSet,
      :FcTypeFTFace,
      :FcTypeLangSet,
      :FcTypeRange
    ]

    class FcMatrix < FFI::Struct
      layout :xx, :double,
             :xy, :double,
             :yx, :double,
             :yy, :double
    end
    typedef :pointer, :FcMatrixPtr
    typedef :pointer, :FcMatrixPtrPtr

    # FcMatrixInit(m) = ((m)->xx = (m)->yy = 1, \
    #    (m)->xy = (m)->yx = 0)

    # /*
    #  * A data structure to represent the available glyphs in a font.
    #  * This is represented as a sparse boolean btree.
    #  */

    typedef :pointer, :FcCharSetPtr
    typedef :pointer, :FcCharSetPtrPtr

    class FcObjectType < FFI::Struct
      layout :object, :string,
             :type, :FcType
    end

    # class Fcant < FFI::Struct
    #   layout :name, :string,
    #          :object, :string,
    #          :value, :int
    # end
    # typedef :pointer, :FcantPtr

    enum :FcResult, [
      :FcResultMatch, :FcResultNoMatch, :FcResultTypeMismatch, :FcResultNoId,
      :FcResultOutOfMemory
    ]
    typedef :pointer, :FcResultPtr

    enum :FcValueBinding, [
        :FcValueBindingWeak, :FcValueBindingStrong, :FcValueBindingSame,
        # /*to make sure sizeof (FcValueBinding) == 4 even with -fshort-enums */
        :FcValueBindingEnd, INT_MAX
    ]
    typedef :pointer, :FcValueBindingPtr

    typedef :pointer, :FcPatternPtr
    typedef :pointer, :FcPatternPtrPtr

    typedef :pointer, :FcLangSetPtr

    typedef :pointer, :FcRangePtr
    typedef :pointer, :FcRangePtrPtr

    class FcValueU < FFI::Union
      layout :s, :string,
             :i, :int,
             :b, :FcBool,
             :d, :double,
             :m, :FcMatrixPtr,
             :c, :FcCharSetPtr,
             :f, :int, # TODO: this is supposed to be :void, but FFI doesn't like that
             :l, :FcLangSetPtr,
             :r, :FcRangePtr
    end

    class FcValue < FFI::Struct
      layout :type, :FcType,
             :u, FcValueU
    end
    typedef :pointer, :FcValuePtr

    typedef :pointer, :FcFontSetPtrPtr

    enum :FcMatchKind, [
      :FcMatchPattern, :FcMatchFont, :FcMatchScan
    ]

    enum :FcLangResult, [
      :FcLangEqual, 0,
      :FcLangDifferentCountry, 1,
      :FcLangDifferentTerritory, 1,
      :FcLangDifferentLang, 2
    ]

    enum :FcSetName, [
      :FcSetSystem, 0,
      :FcSetApplication, 1
    ]

    typedef :pointer, :FcAtomicPtr

    enum :FcEndian, [:FcEndianBig, :FcEndianLittle]

    typedef :pointer, :FcConfigPtr

    typedef :pointer, :FcFileCachePtr

    typedef :pointer, :FcBlanksPtr

    typedef :pointer, :FcStrListPtr

    typedef :pointer, :FcStrSetPtr

    typedef :pointer, :FcCachePtr

    # /*fcblanks.c */
    attach_function :FcBlanksCreate, [], :FcBlanksPtr

    attach_function :FcBlanksDestroy, [:FcBlanksPtr], :void

    attach_function :FcBlanksAdd, [:FcBlanksPtr, :FcChar32], :FcBool

    attach_function :FcBlanksIsMember, [:FcBlanksPtr, :FcChar32], :FcBool

    # /*fccache.c */

    attach_function :FcCacheDir, [:FcCachePtr], :string

    attach_function :FcCacheCopySet, [:FcCachePtr], FontSet.by_ref

    attach_function :FcCacheSubdir, [:FcCachePtr, :int], :string

    attach_function :FcCacheNumSubdir, [:FcCachePtr], :int

    attach_function :FcCacheNumFont, [:FcCachePtr], :int

    attach_function :FcDirCacheUnlink, [:string, :FcConfigPtr], :FcBool

    attach_function :FcDirCacheValid, [:string], :FcBool

    attach_function :FcDirCacheClean, [:string, :FcBool], :FcBool

    attach_function :FcCacheCreateTagFile, [:FcConfigPtr], :void

    # /*fccfg.c */
    attach_function :FcConfigHome, [], :string

    attach_function :FcConfigEnableHome, [:FcBool], :FcBool

    attach_function :FcConfigFilename, [:string], :string

    attach_function :FcConfigCreate, [], :FcConfigPtr

    attach_function :FcConfigReference, [:FcConfigPtr], :FcConfigPtr

    attach_function :FcConfigDestroy, [:FcConfigPtr], :void

    attach_function :FcConfigSetCurrent, [:FcConfigPtr], :FcBool

    attach_function :FcConfigGetCurrent, [], :FcConfigPtr

    attach_function :FcConfigUptoDate, [:FcConfigPtr], :FcBool

    attach_function :FcConfigBuildFonts, [:FcConfigPtr], :FcBool

    attach_function :FcConfigGetFontDirs, [:FcConfigPtr], :FcStrListPtr

    attach_function :FcConfigGetConfigDirs, [:FcConfigPtr], :FcStrListPtr

    attach_function :FcConfigGetConfigFiles, [:FcConfigPtr], :FcStrListPtr

    attach_function :FcConfigGetCache, [:FcConfigPtr], :string

    attach_function :FcConfigGetBlanks, [:FcConfigPtr], :FcBlanksPtr

    attach_function :FcConfigGetCacheDirs, [:FcConfigPtr], :FcStrListPtr

    attach_function :FcConfigGetRescanInterval, [:FcConfigPtr], :int

    attach_function :FcConfigSetRescanInterval, [:FcConfigPtr, :int], :FcBool

    attach_function :FcConfigGetFonts, [:FcConfigPtr, :FcSetName], FontSet.by_ref

    attach_function :FcConfigAppFontAddFile, [:FcConfigPtr, :FcChar8], :FcBool

    attach_function :FcConfigAppFontAddDir, [:FcConfigPtr, :FcChar8], :FcBool

    attach_function :FcConfigAppFontClear, [:FcConfigPtr], :void

    attach_function :FcConfigSubstituteWithPat, [:FcConfigPtr, :FcPatternPtr, :FcPatternPtr, :FcMatchKind], :FcBool

    attach_function :FcConfigSubstitute, [:FcConfigPtr, :FcPatternPtr, :FcMatchKind], :FcBool

    attach_function :FcConfigGetSysRoot, [:FcConfigPtr], :string

    attach_function :FcConfigSetSysRoot, [:FcConfigPtr, :string], :void

    # /*fccharset.c */
    attach_function :FcCharSetCreate, [], :FcCharSetPtr

    # /*deprecated alias for FcCharSetCreate */
    # attach_function :FcCharSetNew, [], :FcCharSetPtr

    attach_function :FcCharSetDestroy, [:FcCharSetPtr], :void

    attach_function :FcCharSetAddChar, [:FcCharSetPtr, :FcChar32], :FcBool

    attach_function :FcCharSetDelChar, [:FcCharSetPtr, :FcChar32], :FcBool

    attach_function :FcCharSetCopy, [:FcCharSetPtr], :FcCharSetPtr

    attach_function :FcCharSetEqual, [:FcCharSetPtr, :FcCharSetPtr], :FcBool

    attach_function :FcCharSetIntersect, [:FcCharSetPtr, :FcCharSetPtr], :FcCharSetPtr

    attach_function :FcCharSetUnion, [:FcCharSetPtr, :FcCharSetPtr], :FcCharSetPtr

    attach_function :FcCharSetSubtract, [:FcCharSetPtr, :FcCharSetPtr], :FcCharSetPtr

    attach_function :FcCharSetMerge, [:FcCharSetPtr, :FcCharSetPtr, :FcBoolPtr], :FcBool

    attach_function :FcCharSetHasChar, [:FcCharSetPtr, :FcChar32], :FcBool

    attach_function :FcCharSetCount, [:FcCharSetPtr], :FcChar32

    attach_function :FcCharSetIntersectCount, [:FcCharSetPtr, :FcCharSetPtr], :FcChar32

    attach_function :FcCharSetSubtractCount, [:FcCharSetPtr, :FcCharSetPtr], :FcChar32

    attach_function :FcCharSetIsSubset, [:FcCharSetPtr, :FcCharSetPtr], :FcBool

    # TODO:
    # FC_CHARSET_MAP_SIZE = (256/32)
    # FC_CHARSET_DONE = ((FcChar32) -1)

    # attach_function :FcCharSetFirstPage, [:FcCharSetPtr,
    #         FcChar32      map[FC_CHARSET_MAP_SIZE],
    #         :FcChar32Ptr], :FcChar32

    # attach_function :FcCharSetNextPage, [FcCharSet  *a,
    #        FcChar32     map[FC_CHARSET_MAP_SIZE],
    #        :FcChar32Ptr], :FcChar32

    # /*
    #  * old coverage API, rather hard to use correctly
    #  */

    attach_function :FcCharSetCoverage, [:FcCharSetPtr, :FcChar32, :FcChar32Ptr], :FcChar32

    # /*fcdbg.c */
    attach_function :FcValuePrint, [FcValue], :void

    attach_function :FcPatternPrint, [:FcPatternPtr], :void

    attach_function :FcFontSetPrint, [FontSet.by_ref], :void

    # /*fcdefault.c */
    attach_function :FcGetDefaultLangs, [], :FcStrSetPtr

    attach_function :FcDefaultSubstitute, [:FcPatternPtr], :void

    # /*fcdir.c */
    attach_function :FcFileIsDir, [:string], :FcBool

    attach_function :FcFileScan, [FontSet.by_ref, :FcStrSetPtr, :FcFileCachePtr, :FcBlanksPtr, :FcChar8, :FcBool], :FcBool

    attach_function :FcDirScan, [FontSet.by_ref, :FcStrSetPtr, :FcFileCachePtr, :FcBlanksPtr, :FcChar8, :FcBool], :FcBool

    attach_function :FcDirSave, [FontSet.by_ref, :FcStrSetPtr, :string], :FcBool

    attach_function :FcDirCacheLoad, [:string, :FcConfigPtr, :string], :FcCachePtr

    attach_function :FcDirCacheRescan, [:string, :FcConfigPtr], :FcCachePtr

    attach_function :FcDirCacheRead, [:string, :FcBool, :FcConfigPtr], :FcCachePtr

    # TODO
    # attach_function :FcDirCacheLoadFile, [:string, struct stat *file_stat], :FcCachePtr

    attach_function :FcDirCacheUnload, [:FcCachePtr], :void

    # /*fcfreetype.c */
    attach_function :FcFreeTypeQuery, [:string, :int, :FcBlanksPtr, :intPtr], :FcPatternPtr

    # /*fcfs.c */

    attach_function :FcFontSetCreate, [], FontSet.by_ref

    attach_function :FcFontSetDestroy, [FontSet.by_ref], :void

    attach_function :FcFontSetAdd, [FontSet.by_ref, :FcPatternPtr], :FcBool

    # /*fcinit.c */
    attach_function :FcInitLoadConfig, [], :FcConfigPtr # Config.by_ref

    attach_function :FcInitLoadConfigAndFonts, [], :FcConfigPtr # Config.by_ref

    attach_function :FcInit, [], :FcBool

    attach_function :FcFini, [], :void

    attach_function :FcGetVersion, [], :int

    attach_function :FcInitReinitialize, [], :FcBool

    attach_function :FcInitBringUptoDate, [], :FcBool

    # /*fclang.c */
    attach_function :FcGetLangs, [], :FcStrSetPtr

    attach_function :FcLangNormalize, [:string], :string

    attach_function :FcLangGetCharSet, [:string], :FcCharSetPtr

    attach_function :FcLangSetCreate, [], :FcLangSetPtr

    attach_function :FcLangSetDestroy, [:FcLangSetPtr], :void

    attach_function :FcLangSetCopy, [:FcLangSetPtr], :FcLangSetPtr

    attach_function :FcLangSetAdd, [:FcLangSetPtr, :string], :FcBool

    attach_function :FcLangSetDel, [:FcLangSetPtr, :string], :FcBool

    attach_function :FcLangSetHasLang, [:FcLangSetPtr, :string], :FcLangResult

    attach_function :FcLangSetCompare, [:FcLangSetPtr, :FcLangSetPtr], :FcLangResult

    attach_function :FcLangSetContains, [:FcLangSetPtr, :FcLangSetPtr], :FcBool

    attach_function :FcLangSetEqual, [:FcLangSetPtr, :FcLangSetPtr], :FcBool

    attach_function :FcLangSetHash, [:FcLangSetPtr], :FcChar32

    attach_function :FcLangSetGetLangs, [:FcLangSetPtr], :FcStrSetPtr

    attach_function :FcLangSetUnion, [:FcLangSetPtr, :FcLangSetPtr], :FcLangSetPtr

    attach_function :FcLangSetSubtract, [:FcLangSetPtr, :FcLangSetPtr], :FcLangSetPtr

    # /*fclist.c */
    attach_function :FcObjectSetCreate, [], ObjectSetManaged.by_ref

    attach_function :FcObjectSetAdd, [ObjectSetManaged.by_ref, :string], :FcBool

    attach_function :FcObjectSetDestroy, [ObjectSetManaged.by_ref], :void

    # TODO
    # attach_function :FcObjectSetVaBuild, [:string, va_list va], ObjectSetManaged.by_ref

    attach_function :FcObjectSetBuild, [:string, :varargs], ObjectSetManaged.by_ref

    attach_function :FcFontSetList, [:FcConfigPtr, :FcFontSetPtrPtr, :int,
      :FcPatternPtr, ObjectSet.by_ref], FontSet.by_ref

    attach_function :FcFontList, [:FcConfigPtr, :FcPatternPtr, ObjectSetManaged.by_ref], FontSet.by_ref

    # /*fcatomic.c */

    attach_function :FcAtomicCreate, [:FcChar8], :FcAtomicPtr

    attach_function :FcAtomicLock, [:FcAtomicPtr], :FcBool

    attach_function :FcAtomicNewFile, [:FcAtomicPtr], :string

    attach_function :FcAtomicOrigFile, [:FcAtomicPtr], :string

    attach_function :FcAtomicReplaceOrig, [:FcAtomicPtr], :FcBool

    attach_function :FcAtomicDeleteNew, [:FcAtomicPtr], :void

    attach_function :FcAtomicUnlock, [:FcAtomicPtr], :void

    attach_function :FcAtomicDestroy, [:FcAtomicPtr], :void

    # /*fcmatch.c */
    attach_function :FcFontSetMatch, [:FcConfigPtr, :FcFontSetPtrPtr, :int, :FcPatternPtr, :FcResultPtr], :FcPatternPtr

    attach_function :FcFontMatch, [:FcConfigPtr, :FcPatternPtr, :FcResultPtr], :FcPatternPtr

    attach_function :FcFontRenderPrepare, [:FcConfigPtr, :FcPatternPtr, :FcPatternPtr], :FcPatternPtr

    attach_function :FcFontSetSort, [:FcConfigPtr, FontSet.by_ref, :int, :FcPatternPtr, :FcBool, :FcCharSetPtrPtr, :FcResultPtr], FontSet.by_ref

    attach_function :FcFontSort, [:FcConfigPtr, :FcPatternPtr, :FcBool, :FcCharSetPtrPtr, :FcResultPtr], FontSet.by_ref

    attach_function :FcFontSetSortDestroy, [FontSet.by_ref], :void

    # /*fcmatrix.c */
    attach_function :FcMatrixCopy, [:FcMatrixPtr], :FcMatrixPtr

    attach_function :FcMatrixEqual, [:FcMatrixPtr, :FcMatrixPtr], :FcBool

    attach_function :FcMatrixMultiply, [:FcMatrixPtr, :FcMatrixPtr, :FcMatrixPtr], :void

    attach_function :FcMatrixRotate, [:FcMatrixPtr, :double, :double], :void

    attach_function :FcMatrixScale, [:FcMatrixPtr, :double, :double], :void

    attach_function :FcMatrixShear, [:FcMatrixPtr, :double, :double], :void

    # /*fcname.c */

    # /*Deprecated.  Does nothing.  Returns FcFalse. */
    # attach_function :FcNameRegisterObjectTypes, [FcObjectType.by_ref, :int], :FcBool

    # /*Deprecated.  Does nothing.  Returns FcFalse. */
    # attach_function :FcNameUnregisterObjectTypes, [FcObjectType.by_ref, :int], :FcBool

    attach_function :FcNameGetObjectType, [:string], FcObjectType.by_ref

    # /*Deprecated.  Does nothing.  Returns FcFalse. */
    # attach_function :FcNameRegisterants, [:FcantPtr, :int], :FcBool

    # /*Deprecated.  Does nothing.  Returns FcFalse. */
    # attach_function :FcNameUnregisterants, [:FcantPtr, :int], :FcBool

    # attach_function :FcNameGetant, [:string], :FcantPtr

    # attach_function :FcNameant, [:string, :intPtr], :FcBool

    attach_function :FcNameParse, [:string], :FcPatternPtr

    attach_function :FcNameUnparse, [:FcPatternPtr], :string

    # /*fcpat.c */
    attach_function :FcPatternCreate, [], :FcPatternPtr

    attach_function :FcPatternDuplicate, [:FcPatternPtr], :FcPatternPtr

    attach_function :FcPatternReference, [:FcPatternPtr], :void

    attach_function :FcPatternFilter, [:FcPatternPtr, ObjectSet.by_ref], :FcPatternPtr

    attach_function :FcValueDestroy, [FcValue], :void

    attach_function :FcValueEqual, [FcValue, FcValue], :FcBool

    attach_function :FcValueSave, [FcValue], FcValue

    attach_function :FcPatternDestroy, [:FcPatternPtr], :void

    attach_function :FcPatternEqual, [:FcPatternPtr, :FcPatternPtr], :FcBool

    attach_function :FcPatternEqualSubset, [:FcPatternPtr, :FcPatternPtr, ObjectSet.by_ref], :FcBool

    attach_function :FcPatternHash, [:FcPatternPtr], :FcChar32

    attach_function :FcPatternAdd, [:FcPatternPtr, :string, FcValue, :FcBool], :FcBool

    attach_function :FcPatternAddWeak, [:FcPatternPtr, :string, FcValue, :FcBool], :FcBool

    attach_function :FcPatternGet, [:FcPatternPtr, :string, :int, :FcValuePtr], :FcResult

    attach_function :FcPatternGetWithBinding, [:FcPatternPtr, :string, :int, :FcValuePtr, :FcValueBindingPtr], :FcResult

    attach_function :FcPatternDel, [:FcPatternPtr, :string], :FcBool

    attach_function :FcPatternRemove, [:FcPatternPtr, :string, :int], :FcBool

    attach_function :FcPatternAddInteger, [:FcPatternPtr, :string, :int], :FcBool

    attach_function :FcPatternAddDouble, [:FcPatternPtr, :string, :double], :FcBool

    attach_function :FcPatternAddString, [:FcPatternPtr, :string, :string], :FcBool

    attach_function :FcPatternAddMatrix, [:FcPatternPtr, :string, :FcMatrixPtr], :FcBool

    attach_function :FcPatternAddCharSet, [:FcPatternPtr, :string, :FcCharSetPtr], :FcBool

    attach_function :FcPatternAddBool, [:FcPatternPtr, :string, :FcBool], :FcBool

    attach_function :FcPatternAddLangSet, [:FcPatternPtr, :string, :FcLangSetPtr], :FcBool

    attach_function :FcPatternAddRange, [:FcPatternPtr, :string, :FcRangePtr], :FcBool

    attach_function :FcPatternGetInteger, [:FcPatternPtr, :string, :int, :intPtr], :FcResult

    attach_function :FcPatternGetDouble, [:FcPatternPtr, :string, :int, :doublePtr], :FcResult

    attach_function :FcPatternGetString, [:FcPatternPtr, :string, :int, :stringPtr], :FcResult

    attach_function :FcPatternGetMatrix, [:FcPatternPtr, :string, :int, :FcMatrixPtrPtr], :FcResult

    attach_function :FcPatternGetCharSet, [:FcPatternPtr, :string, :int, :FcCharSetPtr], :FcResult

    attach_function :FcPatternGetBool, [:FcPatternPtr, :string, :int, :FcBoolPtr], :FcResult

    attach_function :FcPatternGetLangSet, [:FcPatternPtr, :string, :int, :FcLangSetPtr], :FcResult

    attach_function :FcPatternGetRange, [:FcPatternPtr, :string, :int, :FcRangePtrPtr], :FcResult

    # TODO
    # attach_function :FcPatternVaBuild, [:FcPatternPtr, va_list va], :FcPatternPtr

    attach_function :FcPatternBuild, [:FcPatternPtr, :varargs], :FcPatternPtr

    attach_function :FcPatternFormat, [:FcPatternPtr, :string], :string

    # /*fcrange.c */
    attach_function :FcRangeCreateDouble, [:double, :double], :FcRangePtr

    attach_function :FcRangeCreateInteger, [:FcChar32, :FcChar32], :FcRangePtr

    attach_function :FcRangeDestroy, [:FcRangePtr], :void

    attach_function :FcRangeCopy, [:FcRangePtr], :FcRangePtr

    attach_function :FcRangeGetDouble, [:FcRangePtr, :doublePtr, :doublePtr], :FcBool

    # /*fcweight.c */

    attach_function :FcWeightFromOpenType, [:int], :int

    attach_function :FcWeightToOpenType, [:int], :int

    # /*fcstr.c */

    attach_function :FcStrCopy, [:string], :string

    attach_function :FcStrCopyFilename, [:string], :string

    attach_function :FcStrPlus, [:string, :string], :string

    attach_function :FcStrFree, [:string], :void

    # /*These are ASCII only, suitable only for pattern element names */
        # FcIsUpper(c) = ((0101 <= (c) && (c) <= 0132))
        # FcIsLower(c) = ((0141 <= (c) && (c) <= 0172))
        # FcToLower(c) = (FcIsUpper(c) ? (c) - 0101 + 0141 : (c))

    attach_function :FcStrDowncase, [:string], :string

    attach_function :FcStrCmpIgnoreCase, [:string, :string], :int

    attach_function :FcStrCmp, [:string, :string], :int

    attach_function :FcStrStrIgnoreCase, [:string, :string], :string

    attach_function :FcStrStr, [:string, :string], :string

    attach_function :FcUtf8ToUcs4, [:string, :FcChar32Ptr, :int], :int

    attach_function :FcUtf8Len, [:FcChar8, :int, :intPtr, :intPtr], :FcBool

    FC_UTF8_MAX_LEN = 6

    # TODO
    # attach_function :FcUcs4ToUtf8, [:FcChar32, FcChar8 dest[FC_UTF8_MAX_LEN]], :int

    attach_function :FcUtf16ToUcs4, [:FcChar8, :FcEndian, :FcChar32Ptr, :int], :int     # /*in bytes */

    attach_function :FcUtf16Len, [:FcChar8, :FcEndian, :int,      # /*in bytes */
          :intPtr, :intPtr], :FcBool

    attach_function :FcStrDirname, [:string], :string

    attach_function :FcStrBasename, [:string], :string

    attach_function :FcStrSetCreate, [], :FcStrSetPtr

    attach_function :FcStrSetMember, [:FcStrSetPtr, :string], :FcBool

    attach_function :FcStrSetEqual, [:FcStrSetPtr, :FcStrSetPtr], :FcBool

    attach_function :FcStrSetAdd, [:FcStrSetPtr, :string], :FcBool

    attach_function :FcStrSetAddFilename, [:FcStrSetPtr, :string], :FcBool

    attach_function :FcStrSetDel, [:FcStrSetPtr, :string], :FcBool

    attach_function :FcStrSetDestroy, [:FcStrSetPtr], :void

    attach_function :FcStrListCreate, [:FcStrSetPtr], :FcStrListPtr

    attach_function :FcStrListFirst, [:FcStrListPtr], :void

    attach_function :FcStrListNext, [:FcStrListPtr], :string

    attach_function :FcStrListDone, [:FcStrListPtr], :void

    # /*fcxml.c */
    attach_function :FcConfigParseAndLoad, [:FcConfigPtr, :string, :FcBool], :FcBool

    attach_function :FcConfigParseAndLoadFromMemory, [:FcConfigPtr, :FcChar8, :FcBool], :FcBool

  end
end
