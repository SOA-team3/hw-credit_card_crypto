# frozen_string_literal: true

require_relative '../credit_card'
require 'minitest/autorun'
require 'minitest/unit'
require 'minitest/rg'

# Feel free to replace the contents of cards with data from your own yaml file
card_details = [
  { num: '4916603231464963',
    exp: 'Mar-30-2020',
    name: 'Soumya Ray',
    net: 'Visa' },
  { num: '6011580789725897',
    exp: 'Sep-30-2020',
    name: 'Nick Danks',
    net: 'Visa' },
  { num: '5423661657234057',
    exp: 'Feb-30-2020',
    name: 'Lee Chen',
    net: 'Mastercard' }
]

card_details = card_details.map do |c|
  CreditCard.new(c[:num], c[:exp], c[:name], c[:net])
end

describe 'Test hashing requirements' do
  describe 'Test regular hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      it 'should produce the same regular hash if hashed repeatedly' do
        card_details.each do |card|
          hash1 = card.hash
          hash2 = card.hash
          assert_equal hash1, hash2
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it 'should produce a different regular hash than other cards' do
        hashed_values = []
        card_details.each do |card|
          hashed_value = card.hash
          _(hashed_values).wont_include _(hashed_value)
          hashed_values << hashed_value
        end
      end
    end
  end

  describe 'Test cryptographic hashing' do
    describe 'Check hashes are consistently produced' do
      # TODO: Check that each card produces the same hash if hashed repeatedly
      it 'should produce the same cryptographic hash if hashed repeatedly' do
        card_details.each do |card|
          hash1 = card.hash_secure
          hash2 = card.hash_secure
          assert_equal hash1, hash2
        end
      end
    end

    describe 'Check for unique hashes' do
      # TODO: Check that each card produces a different hash than other cards
      it 'should produces a different cryptographic hash than other cards' do
        hashed_values = []
        card_details.each do |card|
          hashed_value = card.hash_secure
          _(hashed_values).wont_include _(hashed_value)
          hashed_values << hashed_value
        end
      end
    end

    describe 'Check regular hash not same as cryptographic hash' do
      # TODO: Check that each card's hash is different from its hash_secure
      it 'should have difference between each card\'s hash and its hash_secure' do
        card_details.each do |card|
          regular_hash = card.hash
          crypto_hash = card.hash_secure
          _(regular_hash).wont_equal _(crypto_hash)
        end
      end
    end
  end
end
