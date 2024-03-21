# frozen_string_literal: true

module SubstitutionCipher
  # the Caesar Cipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      document = document.to_s # Ensure document is a string
      ciphertext = ''
      document.each_char do |char|
        encrypted_char = (char.ord + key).chr
        ciphertext += encrypted_char
      end
      ciphertext
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      document = document.to_s # Ensure document is a string
      plaintext = ''
      document.each_char do |char|
        decrypted_char = (char.ord - key).chr
        plaintext += decrypted_char
      end
      plaintext
    end
  end

  # Encrypts document using key
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      # rng is used to initialize a random number generator with a seed value derived from the provided key
      # lookup_table is an array of integers from 0 to 127, shuffled using the random number generator
      document = document.to_s # Ensure document is a string
      rng = Random.new(key)
      lookup_table = (0..127).to_a.shuffle(random: rng)

      encrypted_document = ''
      document.each_char do |char|
        # encrypted_char is the character at the index of the character's ASCII value in the lookup_table
        encrypted_char = lookup_table[char.ord].chr
        # encrypted_document is the concatenation of the encrypted characters
        encrypted_document += encrypted_char
      end
      encrypted_document
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      # Create the same shuffled lookup table based on the key
      document = document.to_s # Ensure document is a string
      rng = Random.new(key)
      lookup_table = (0..127).to_a.shuffle(random: rng)

      decrypted_document = ''
      document.each_char do |char|
        # decrypted_char is the character at the index of the character's ASCII value in the lookup_table
        decrypted_char = lookup_table.index(char.ord).chr
        # decrypted_document is the concatenation of the decrypted characters
        decrypted_document += decrypted_char
      end
      decrypted_document
    end
  end
end
