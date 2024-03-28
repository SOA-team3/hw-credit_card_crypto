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

    # Step 1: Determine the number of rows and columns for the matrix
    document = document.to_s # Ensure document is a string
    key = key.to_i # Ensure key is an integer
    rows, cols = matrix_dimensions(document.length)

    # Step 2: Break the plaintext into evenly sized blocks
    # Calculate the number of characters needed for padding
    (document.length % cols)
    # Break the plaintext into evenly sized blocks and add padding to the last block
    blocks = document.chars.each_slice(cols).map { |block| block.join.ljust(cols, ' ') }

    # Step 3: Sort rows in a predictably random way using key as seed
    # Step 4: Sort columns of each row in a predictably random way
    # Get sorted rows and sorted matrix using the provided key, number of rows, and columns
    sorted_rows, sorted_matrix = sorted_rows_and_cols(key, rows, cols)

    # Step 5: Return joined ciphertext
    # Encrypt the blocks using transposition and return the ciphertext
    # convert_blocks(blocks, rows, cols, sorted_rows, sorted_matrix, :encrypt)
    convert_blocks(blocks: blocks, rows: rows, cols: cols, sorted_rows: sorted_rows, sorted_matrix: sorted_matrix,
                   mode: :encrypt)
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    # Step 1: Determine the number of rows and columns for the matrix
    rows, cols = matrix_dimensions(ciphertext.length)

    # Step 2: Break the ciphertext into evenly sized blocks
    blocks = ciphertext.chars.each_slice(cols).map { |block| block.join.ljust(cols, ' ') }

    # Step 3: Sort rows in a predictably random way using key as seed
    # Step 4: Sort columns of each row in the original order
    sorted_rows, sorted_matrix = sorted_rows_and_cols(key, rows, cols)

    # Step 5: Return joined plaintext
    # convert_blocks(blocks, rows, cols, sorted_rows, sorted_matrix, :decrypt)
    convert_blocks(blocks: blocks, rows: rows, cols: cols, sorted_rows: sorted_rows, sorted_matrix: sorted_matrix,
                   mode: :decrypt)
  end

  class << self
    private

    def matrix_dimensions(length)
      # Find the nearest square root
      square_root = Math.sqrt(length).round
      # Ensure the matrix is nearly square by taking the closest factor downward
      cols = square_root.downto(1).find { |n| (length % n).zero? }
      rows = length / cols
      [rows, cols]
    end

    def sorted_rows_and_cols(key, rows, cols)
      sorted_rows = (0...rows).to_a.shuffle(random: Random.new(key))
      sorted_matrix = (0...cols).to_a.shuffle(random: Random.new(key))
      [sorted_rows, sorted_matrix]
    end

    def convert_blocks(options)
      blocks = options[:blocks]
      rows = options[:rows]
      cols = options[:cols]
      sorted_rows = options[:sorted_rows]
      sorted_matrix = options[:sorted_matrix]
      mode = options[:mode]
      converted_blocks = initialize_blocks(rows, cols)

      process_transposition(blocks, sorted_rows, sorted_matrix, mode, converted_blocks)
      join_blocks(converted_blocks, mode)
    end

    def initialize_blocks(rows, cols)
      Array.new(rows) { Array.new(cols) }
    end

    def process_transposition(blocks, sorted_rows, sorted_matrix, mode, converted_blocks)
      sorted_rows.each_with_index do |row, i|
        sorted_matrix.each_with_index do |col, j|
          perform_transposition(blocks: blocks, converted_blocks: converted_blocks, row: row,
                                col: col, index_i: i, index_j: j, mode: mode)
        end
      end
    end

    def perform_transposition(options)
      blocks, converted_blocks, row, col, index_i, index_j, mode =
        options.values_at(:blocks, :converted_blocks, :row, :col, :index_i, :index_j, :mode)

      converted_blocks[row][col] = blocks[index_i][index_j] if mode == :encrypt && blocks[index_i][index_j]
      converted_blocks[index_i][index_j] = blocks[row].chars[col] if mode == :decrypt
    end

    def join_blocks(converted_blocks, mode)
      if mode == :encrypt
        converted_blocks.map(&:join).join
      elsif mode == :decrypt
        converted_blocks.flatten.join.rstrip
      end
    end
  end
end
