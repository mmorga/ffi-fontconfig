module Fontconfig
  class Blanks < FFI::ManagedStruct
    def initialize(pointer = nil)
      pointer = Fc.FcBlankCreate unless pointer
      super(pointer)
    end

    def add(char)
      Fc.FcBlanksAdd(to_ptr, char) != 0
    end

    def member?(char)
      Fc.FcBlanksIsMember(to_ptr, char) != 0
    end

    def self.release(ptr)
      Fc.FcBlanksDestroy(ptr)
    end
  end
end
