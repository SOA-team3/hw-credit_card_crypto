# frozen_string_literal: true

# Double Transposition Cipher
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext

    # Step 1: Determine the number of rows and columns for the matrix ( _ stands for rows)
    document = document.to_s # Ensure document is a string
    _, cols = matrix_dimensions(document.length)

    # Step 2: Break the plaintext into evenly sized blocks
    blocks = document.chars.each_slice(cols).to_a

    # Step 3: Sort rows in a predictably random way using key as seed
    sorted_rows = blocks.shuffle(random: Random.new(key.to_i))

    # Step 4: Sort columns of each row in a predictably random way
    sorted_matrix = sorted_rows.map { |row| row.shuffle(random: Random.new(key.to_i)) }

    # Step 5: Return joined ciphertext
    # puts "s: #{sorted_matrix.flatten.join('')}"
    sorted_matrix.flatten.join('')
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    # Step 1: Determine the number of rows and columns for the matrix
    _, cols = matrix_dimensions(ciphertext.length)

    # Step 2: Break the ciphertext into evenly sized blocks
    blocks = ciphertext.chars.each_slice(cols).to_a

    # Step 3: Sort rows in a predictably random way using key as seed
    sorted_rows = blocks.shuffle(random: Random.new(key.to_i))

    # Step 4: Sort columns of each row in the original order
    sorted_matrix = sorted_rows.map { |row| row.sort_by.with_index { |_, i| i } }

    # Step 5: Return joined plaintext
    sorted_matrix.flatten.join('')
  end

  def self.matrix_dimensions(length)
    # Find the nearest square root
    square_root = Math.sqrt(length).round

    # Ensure the matrix is nearly square by taking the closest factor downward
    cols = square_root.downto(1).find { |n| (length % n).zero? }
    rows = length / cols

    [rows, cols]
  end
end
