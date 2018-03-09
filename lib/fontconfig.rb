require "fontconfig/version"
require "fontconfig/fc"
require "fontconfig/blanks"
require "fontconfig/config"
require "fontconfig/object_set"
require "fontconfig/pattern"
require "fontconfig/font_set"

module Fontconfig
  def init_load_config
    Config.new(Fc.FcInitLoadConfig)
    # Fc.FcInitLoadConfig
  end
  module_function :init_load_config

  def init_load_config_and_fonts
    Config.new(Fc.FcInitLoadConfigAndFonts)
    # Fc.FcInitLoadConfigAndFonts
  end
  module_function :init_load_config_and_fonts

  def init
    Fc.FcInit
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
    Fc.FcInitReinitialize
  end
  module_function :init_reinitialize

  def init_bring_up_to_date
    Fc.FcInitBringUptoDate
  end
  module_function :init_bring_up_to_date

  def read_string_ptr(ptr)
    strPtr = ptr.read_pointer()
    return strPtr.null? ? nil : strPtr.read_string()
  end
  module_function :read_string_ptr
end
