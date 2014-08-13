require 'test_helper'

module Dovecote
  class MsisdnTest < ActiveSupport::TestCase
    test "phone_numbers to msisdn" do
      # normalizes numbers containing (0)
      assert_equal "+49.1234567",     Msisdn.new("+49(0)12/3456-7").to_s
      assert_equal "+49.12345678",    Msisdn.new("+49(0)123456-78").to_s
      assert_equal "+49.123456789",   Msisdn.new("+49(0)12/345678-9").to_s
      assert_equal "+49.123456789",   Msisdn.new("+49(0)123-456789").to_s
      assert_equal "+49.1234567890",  Msisdn.new("+49(0)1234567890").to_s
      assert_equal "+49.1234567890",  Msisdn.new("+49-(0)12-34567890").to_s
      assert_equal "+49.12345678901", Msisdn.new("+49(0)1234567890-1").to_s

      # starting with double 00
      assert_equal "+7.123456789",    Msisdn.new("007123456789").to_s        # russia
      assert_equal "+49.1234567890",  Msisdn.new("0049 (123) 4567890").to_s  # germany
      assert_equal "+31.123456789",   Msisdn.new("0031123456789").to_s       # nl
      assert_equal "+41.123456789",   Msisdn.new("0041123456789").to_s       # ch
      assert_equal "+43.1234567890",  Msisdn.new("0043 123 456 7890").to_s   # at
      assert_equal "+48.123456789",   Msisdn.new("0048-123-456-789").to_s    # pl
      assert_equal "+91.1234567890",  Msisdn.new("00911234567890").to_s      # india
      assert_equal "+972.123456789",  Msisdn.new("00972(12)3456789").to_s    # izrael

      refute                          Msisdn.new("00253456789").valid? # "no phone code: 25"

      # starting with +phone_code i.e: +49
      assert_equal "+90.123456789",   Msisdn.new("+90123456789").to_s  # turkey
      assert_equal "+49.1234567890",  Msisdn.new("+49.12.34 567 890").to_s
      assert_equal "+49.12345678901", Msisdn.new("+49123/45 678 901").to_s
      assert_equal "+7.9857621716",   Msisdn.new("+79857621716").to_s

      # starting with (0) or 0
      refute                          Msisdn.new("(0)12-34567-890").valid?
      assert_equal "+49.1234567890",  Msisdn.new("(0)12-34567-890", :de).to_s
      refute                          Msisdn.new("0 12-34567-89").valid?
      assert_equal "+49.1234567890",  Msisdn.new("0 12-34567-890", :de).to_s

      refute                          Msisdn.new("123-456-789").valid?
      refute                          Msisdn.new("123.456.789").valid?
      assert_equal "+48.123456789",   Msisdn.new("123-456-789", :pl).to_s
      assert_equal "+48.123456789",   Msisdn.new("123.456.789", :pl).to_s

      refute                          Msisdn.new("(030) 12345678").valid?
      assert_equal "+49.3012345678",  Msisdn.new("(030) 12345678", :de).to_s
      refute                          Msisdn.new("(0351) 1234 5678").valid?
      assert_equal "+49.35112345678", Msisdn.new("(0351) 1234 5678", :de).to_s

      # too short
      refute Msisdn.new("0054554").valid?
      refute Msisdn.new("+49(0)893943").valid?
      refute Msisdn.new("009731234").valid?

      # too long
      refute Msisdn.new("+48.123456789012").valid?

      # bad format
      refute Msisdn.new("49.123-456-789").valid?
      assert_equal "+49.49123456789", Msisdn.new("49.123-456-789", :de).to_s

      # phone numbers in different formats with country_code provided
      assert_equal "+49.1234567",     Msisdn.new("123-456-7", :de).to_s
      assert_equal "+49.1234567",     Msisdn.new("(123) 456-7", :de).to_s
      assert_equal "+49.1234567",     Msisdn.new("123.456.7", :de).to_s
    end
  end
end
