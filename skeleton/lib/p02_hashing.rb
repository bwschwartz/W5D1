class Integer
  # Integer#hash already implemented for you
end

class Array
  def hash
    arr_int = self.each.with_index.inject(0) { |unique_sum, (el,i)| unique_sum += el*i }
    arr_int.to_s.to_i
  end
end

class String
  def hash
    str_int = self.each_char.with_index.inject(0) { |unique_sum, (char,i)| unique_sum += char.ord*i }
    str_int.to_s.to_i
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_int = self.inject(0) { |unique_sum, (k, v)| unique_sum += k.to_s.ord * v.ord }
    hash_int.to_s.to_i
  end

end
