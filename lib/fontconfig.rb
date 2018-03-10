require "fontconfig/version"
require "fontconfig/fc"
require "fontconfig/ffi_helpers"
require "fontconfig/blanks"
require "fontconfig/config"
require "fontconfig/object_set"
require "fontconfig/pattern"
require "fontconfig/font_set"
require "fontconfig/str_set"
require "fontconfig/str_list"

module Fontconfig
  def init_load_config
    Config.new(Fc.FcInitLoadConfig)
  end
  module_function :init_load_config

  def init_load_config_and_fonts
    Config.new(Fc.FcInitLoadConfigAndFonts)
  end
  module_function :init_load_config_and_fonts

  def init
    Fc.FcInit == Fc::FcTrue
  end
  module_function :init

  def fini
    Fc.FcFini
  end
  module_function :fini

  def version
    Fc.FcGetVersion
  end
  module_function :version

  def init_reinitialize
    Fc.FcInitReinitialize == Fc::FcTrue
  end
  module_function :init_reinitialize

  def init_bring_up_to_date
    Fc.FcInitBringUptoDate == Fc::FcTrue
  end
  module_function :init_bring_up_to_date
end
