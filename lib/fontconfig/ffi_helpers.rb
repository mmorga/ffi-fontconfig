module Fontconfig
  module FFI_Helpers
    def ptr_to_string(ptr)
      return nil if ptr.null?
      ptr.read_string
    end
    module_function :ptr_to_string
  end
end
