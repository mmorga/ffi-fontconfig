module Fontconfig
  module FontSetMethods
    def nfont
      self[:nfont]
    end

    def sfont
      self[:sfont]
    end

    def fonts
      self[:fonts].get_array_of_pointer(0, nfont).map { |ptr| Pattern.new(ptr) }
    end
  end

  # class FontSetManaged < FFI::ManagedStruct
  #   include FontSetMethods

  #   def initialize(pointer)
  #     pointer = Fc.FcFontSetCreate unless pointer
  #     super(pointer)
  #   end

  #   def self.build(*args)
  #     first_arg = args.shift
  #     args.push(nil)
  #     args = args.zip(Array.new(args.size, :string)).flatten
  #     puts args.inspect
  #     Fc.FcFontSetBuild(first_arg, :string, *args)
  #   end

  #   def self.release(ptr)
  #     Fc.FcFontSetDestroy(ptr)
  #   end
  # end

  class FontSet < FFI::Struct
    include FontSetMethods

    def self.list(config, pat, os)
      Fc.FcFontList(config, pat, os)
    end
  end
end
