module Fontconfig
  module StrListMethods
    def include?(str)
      Fc.FcStrListMember(to_ptr, str)
    end

    def ==(other)
      Fc.FcStrListEqual(to_ptr, other)
    end

    def add(str)
      Fc.FcStrListAdd(to_ptr, str)
    end

    def add_filename(str)
      Fc.FcStrListAddFilename(to_ptr, str)
    end

    def del(str)
      Fc.FcStrListDel(to_ptr, str)
    end
  end

  class StrListManaged < FFI::AutoPointer
    include Enumerable
    include StrListMethods

    def initialize(pointer = nil, str_set: nil)
      pointer = Fc.FcStrListCreate(str_set) if str_set
      super(pointer, StrListManaged.method(:release))
    end

    def self.release(ptr)
      Fc.FcStrListDone(ptr)
    end

    def each
      while !(ptr = Fc.FcStrListNext(self)).null?
        yield ptr.read_string
      end
    end
  end

  class StrList < FFI::Pointer
    include StrListMethods
  end
end
