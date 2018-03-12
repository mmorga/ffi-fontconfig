module Fontconfig
  module ConfigMethods
    def reference
      Config.new(Fc.FcConfigReference(self))
    end

    def up_to_date?
      Fc.FcConfigUptoDate(self)
    end

    def build_fonts
      Fc.FcConfigBuildFonts(self)
    end

    def font_dirs
      StrListManaged.new(Fc.FcConfigGetFontDirs(self))
    end

    def config_dirs
      StrListManaged.new(Fc.FcConfigGetConfigDirs(self))
    end

    def config_files
      StrListManaged.new(Fc.FcConfigGetConfigFiles(self))
    end

    def cache_dirs
      StrListManaged.new(Fc.FcConfigGetCacheDirs(self))
    end

    def rescan_interval
      Fc.FcConfigGetRescanInterval(self)
    end

    def rescan_interval=(interval)
      Fc.FcConfigSetRescanInterval(self, interval)
    end

    def fonts(set_name)
      FontSet.new(Fc.FcConfigGetFonts(self, set_name))
    end

    def app_font_add_file(file)
      Fc.FcConfigAppFontAddFile(self, file)
    end

    def app_font_add_dir(dir)
      Fc.FcConfigAppFontAddDir(self, dir)
    end

    def app_font_clear
      Fc.FcConfigAppFontClear(self)
    end

    def substitute_with_pat(pat1, pat2, match_kind)
      Fc.FcConfigSubstituteWithPat(self, pat1, pat2, match_kind)
    end

    def substitute(pat, match_kind)
      Fc.FcConfigSubstitute(self, pat, match_kind)
    end

    def sys_root
      ptr = Fc.FcConfigGetSysRoot(self)
      return nil if ptr.null?
      ptr.read_string
    end

    def sys_root=(path)
      Fc.FcConfigSetSysRoot(self, path)
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
      FFI_Helpers.ptr_to_string(Fc.FcConfigHome)
    end

    def self.enable_home(bool)
      Fc.FcConfigEnableHome(bool ? Fc::FcTrue : Fc::FcFalse)
    end

    def self.filename(file)
      FFI_Helpers.ptr_to_string(Fc.FcConfigFilename(file))
    end

    def self.current=(config)
      Fc.FcConfigSetCurrent(config)
    end

    def self.current
      Config.new(Fc.FcConfigGetCurrent)
    end

    # TODO: this segfaults - I'm not sure why
    def self.default_langs
      StrList.new(Fc.FcGetDefaultLangs)
    end
  end
end
