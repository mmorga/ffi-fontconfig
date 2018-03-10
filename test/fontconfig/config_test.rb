require "test_helper"

module Fontconfig
  class ConfigTest < Minitest::Test
    def test_create_destroy
      config = ConfigManaged.new
      assert_kind_of FFI::Pointer, config.to_ptr
    end

    def test_home
      assert_kind_of String, Config.home
    end

    def test_enable_home
      Config.enable_home(false)
      assert_nil Config.home
      Config.enable_home(true)
      refute_nil Config.home
    end

    def test_filename
      refute_nil Config.filename(nil)
    end

    def test_current
      original_current = Config.current
      assert_kind_of Config, original_current
      replacement_current = ConfigManaged.new
      assert Config.current = replacement_current
      assert_equal replacement_current, Config.current
    end

    def test_default_langs
      skip "For some reason this segfaults"
      Config.default_langs.each {|lang| puts lang}
      assert Config.default_langs.all? { |lang| puts lang; lang.is_a?(String) }
    end

    def test_sys_root
      assert_nil Fontconfig.init_load_config.sys_root
    end
  end
end
