# frozen_string_literal: true

require_relative '../credit_card'
require_relative '../substitution_cipher'
require_relative '../double_trans_cipher'
require_relative '../sk_cipher'
require 'minitest/autorun'

describe 'Test card info encryption' do
  before do
    @cc = CreditCard.new('4916603231464963', 'Mar-30-2020',
                         'Soumya Ray', 'Visa')
    @key = 3
  end

  # Test that LuhnValidator module is included in CreditCard class
  ciphers = [
    { module: SubstitutionCipher::Caesar, name: 'Caesar Cipher' },
    { module: SubstitutionCipher::Permutation, name: 'Permutation Cipher' },
    { module: DoubleTranspositionCipher, name: 'Double Transposition Cipher' }
  ]

  ciphers.each do |cipher|
    describe "Using #{cipher[:name]}" do
      it 'should encrypt card information' do
        enc = cipher[:module].encrypt(@cc, @key)
        _(enc).wont_equal @cc.to_s
        _(enc).wont_be_nil
      end

      it 'should decrypt text' do
        enc =  cipher[:module].encrypt(@cc, @key)
        dec =  cipher[:module].decrypt(enc, @key)
        _(dec).must_equal @cc.to_s
      end
    end
  end

  describe 'Using Modern Symmetric Key cipher' do
    key = ModernSymmetricCipher.generate_new_key
    it 'should encrypt card information' do
      enc = ModernSymmetricCipher.encrypt(@cc, key)
      _(enc).wont_equal @cc.to_s
      _(enc).wont_be_nil
    end

    it 'should decrypt text' do
      # key = ModernSymmetricCipher.generate_new_key
      enc = ModernSymmetricCipher.encrypt(@cc, key)
      dec = ModernSymmetricCipher.decrypt(enc, key)
      puts "here: #{dec}"
      _(dec).must_equal @cc.to_s
    end
  end
end
