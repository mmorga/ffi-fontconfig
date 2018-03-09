module Fontconfig
  module ConfigMethods
    # TODO: Should this return a managed reference or a regular struct?
    def reference
      Fc.FcConfigReference(to_ptr)
    end

    def up_to_date?
      Fc.FcConfigUptoDate(to_ptr)
    end

    def build_fonts
      Fc.FcConfigBuildFonts(to_ptr)
    end

    # TODO: Convert result
    def font_dirs
      str_lits_ptr = Fc.FcConfigGetFontDirs(to_ptr)

    end

    # TODO: Convert result
    def config_dirs
      str_lits_ptr = Fc.FcConfigGetConfigDirs(to_ptr)

    end

    # TODO: Convert result
    def config_files
      str_lits_ptr = Fc.FcConfigGetConfigFiles(to_ptr)

    end

    def cache
      Fc.FcConfigGetCache(to_ptr)
    end

    # TODO convert
    def blanks
      Fc.FcConfigGetBlanks(to_ptr)
    end

    # TODO convert
    def cache_dirs
      Fc.FcConfigGetCacheDirs(to_ptr)
    end

    def rescan_interval
      Fc.FcConfigGetRescanInterval(to_ptr)
    end

    def rescan_interval=(interval)
      Fc.FcConfigSetRescanInterval(to_ptr, interval)
    end

    # TODO: Check FcSetName
    def fonts(set_name)
      Fc.FcConfigGetFonts(to_ptr, set_name)
    end

    def app_font_add_file(file)
      Fc.FcConfigAppFontAddFile(to_ptr, file)
    end

    def app_font_add_dir(dir)
      Fc.FcConfigAppFontAddDir(to_ptr, dir)
    end

    def app_font_clear
      Fc.FcConfigAppFontClear(to_ptr)
    end

    def substitute_with_pat(pat1, pat2, match_kind)
      Fc.FcConfigSubstituteWithPat(to_ptr, pat1, pat2, match_kind)
    end

    def substitute(pat, match_kind)
      Fc.FcConfigSubstitute(to_ptr, pat, match_kind)
    end

    def sys_root
      Fc.FcConfigGetSysRoot(to_ptr)
    end

    def sys_root=(path)
      Fc.FcConfigSetSysRoot(to_ptr, path)
    end
  end

  class ConfigManaged < FFI::AutoPointer
    include ConfigMethods

    def initialize
      super(Fc.FcConfigCreate, ConfigManaged.method(:release))
    end

    def self.release(ptr)
      Fc.FcConfigDestroy(ptr)
    end
  end

  class Config < FFI::Pointer
    include ConfigMethods

    def self.home
      Fc.FcConfigHome
    end

    def self.enable_home(bool)
      Fc.FcConfigEnableHome(bool)
    end

    def self.filename(file)
      Fc.FcConfigFilename(file)
    end

    def self.current=(config)
      Fc.FcConfigSetCurrent(config)
    end

    def self.current
      Fc.FcConfigGetCurrent
    end

    # TODO: convert strings
    def self.default_langs
      Fc.FcGetDefaultLangs
    end

    def self.default_substitute(pat)
      Fc.FcDefaultSubstitute(pat)
    end
  end
end
