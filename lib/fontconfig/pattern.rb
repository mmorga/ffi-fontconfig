module Fontconfig
  module PatternMethods
    # TODO: What does the 3rd param to FcPatternGetString do?
    def string(name)
      ptr = FFI::MemoryPointer.new(:pointer, 1)
      if Fc.FcPatternGetString(self, name, 0, ptr) == :FcResultMatch
        Fontconfig.read_string_ptr(ptr)
      else
        nil
      end
    end

    def default_substitute
      Fc.FcDefaultSubstitute(self)
    end

  end

  class PatternManaged < FFI::AutoPointer
    include PatternMethods

    def initialize(pointer = nil)
      pointer = Fc.FcPatternCreate unless pointer
      super(pointer, PatternManaged.method(:release))
    end

    def self.release(ptr)
      Fc.FcPatternDestroy(ptr)
    end
  end

  class Pattern < FFI::Pointer
    include PatternMethods

    def self.parse(name)
      Pattern.new(Fc.FcNameParse(name))
    end

    def self.font_match(config, pat)
      resultptr = FFI::MemoryPointer.new(:int, 1)
      font = Fc.FcFontMatch(config, pat, resultptr);
      result = resultptr.read_int
      if font && result == 0
        font = PatternManaged.new(font)
      end
    end
  end
end
