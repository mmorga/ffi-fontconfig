module Fontconfig
  module ObjectSetMethods
    # attach_function :FcObjectSetAdd, [ObjectSetManaged.by_ref, :string], :FcBool
  end

  class ObjectSetManaged < FFI::ManagedStruct
    include ObjectSetMethods

    def initialize(pointer)
      pointer = Fc.FcObjectSetCreate unless pointer
      super(pointer)
    end

    def self.build(*args)
      first_arg = args.shift
      args.push(nil)
      args = args.zip(Array.new(args.size, :string)).flatten
      Fc.FcObjectSetBuild(first_arg, :string, *args)
    end

    def self.release(ptr)
      Fc.FcObjectSetDestroy(ptr)
    end
  end

  class ObjectSet < FFI::Struct
    include ObjectSetMethods
  end
end
