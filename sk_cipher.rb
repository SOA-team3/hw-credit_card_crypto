# frozen_string_literal: true

require 'rbnacl'
require 'base64'
# Module for modern symmetric encryption and decryption using RbNaCl library.
module ModernSymmetricCipher
  def self.generate_new_key
    # TODO: Return a new key as a Base64 string
    key = RbNaCl::Random.random_bytes(RbNaCl::SecretBox.key_bytes)
    Base64.strict_encode64(key)
  end

  def self.encrypt(document, key)
    # TODO: Return an encrypted string
    #       Use base64 for ciphertext so that it is sendable as text
    document = document.to_s # Ensure document is a string
    decoded_key = Base64.strict_decode64(key)
    secret_box = RbNaCl::SecretBox.new(decoded_key)
    nonce = RbNaCl::Random.random_bytes(secret_box.nonce_bytes)
    ciphertext = secret_box.encrypt(nonce, document)
    send_text = nonce + ciphertext
    Base64.strict_encode64(send_text)
  end

  def self.decrypt(encrypted_cc, key)
    # TODO: Decrypt from encrypted message above
    #       Expect Base64 encrypted message and Base64 key
    decoded_key = Base64.strict_decode64(key)
    secret_box = RbNaCl::SecretBox.new(decoded_key)
    receive_text = Base64.strict_decode64(encrypted_cc)
    nonce = receive_text[0...RbNaCl::SecretBox.nonce_bytes]
    ciphertext = receive_text[RbNaCl::SecretBox.nonce_bytes..-1]
    secret_box.decrypt(nonce, ciphertext)
  end
end
