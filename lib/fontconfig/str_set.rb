module Fontconfig
  module StrSetMethods
    def include?(str)
      Fc.FcStrSetMember(to_ptr, str)
    end

    def ==(other)
      Fc.FcStrSetEqual(to_ptr, other)
    end

    def add(str)
      Fc.FcStrSetAdd(to_ptr, str)
    end

    def add_filename(str)
      Fc.FcStrSetAddFilename(to_ptr, str)
    end

    def del(str)
      Fc.FcStrSetDel(to_ptr, str)
    end
  end

  class StrSetManaged < FFI::AutoPointer
    include StrSetMethods

    def initialize(pointer = nil)
      pointer = Fc.FcStrSetCreate unless pointer
      super(pointer, StrSetManaged.method(:release))
    end

    def self.release(ptr)
      Fc.FcStrSetDestroy(ptr)
    end
  end

  class StrSet < FFI::Pointer
    include StrSetMethods
  end
end
