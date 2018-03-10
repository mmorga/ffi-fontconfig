require "test_helper"

class FontconfigTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil Fontconfig::VERSION
  end

  def test_init_load_config
    config = Fontconfig.init_load_config_and_fonts
    assert_kind_of Fontconfig::Config, config
  end

  def test_init_load_config_and_fonts
    config = Fontconfig.init_load_config_and_fonts
    assert_kind_of Fontconfig::Config, config
  end

  def test_init
    assert Fontconfig.init
  end

  def test_fini
    skip "May be breaking other tests"
    Fontconfig.init
    fini = Fontconfig.fini
    assert_nil fini
  end

  def test_version
    version = Fontconfig.version
    assert_kind_of Integer, version
    assert version > 1000
  end

  def test_init_reinitialize
    assert Fontconfig.init_reinitialize
  end

  def test_init_bring_up_to_date
    assert Fontconfig.init_bring_up_to_date
  end
end
