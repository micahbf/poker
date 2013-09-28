class Array
  def my_uniq
    uniq_array = []
    self.each do |el|
      uniq_array << el unless uniq_array.include?(el)
    end
    uniq_array
  end

  def two_sum
    two_sums = []
    self.each_index do |index1|
      ((index1 + 1)...self.length).each do |index2|
        two_sums << [index1, index2] if self[index1] + self[index2] == 0
      end
    end
    two_sums
  end

  def my_transpose
    result_array = [[],[],[]]
    (0..2).each do |i|
      self.each_with_index do |row, row_index|
        result_array[i] << row[i]
      end
    end
    result_array
  end


end