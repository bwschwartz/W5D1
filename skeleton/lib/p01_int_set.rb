require 'byebug'

class MaxIntSet
  attr_reader :max, :store

  def initialize(max)
    @max = max
    @store = Array.new(max, false)
  end

  def insert(num)
    invalid_range?(num)
    @store[num] = true #unless include?(num)
  end

  def remove(num)
    invalid_range?(num)
    @store[num] = false
  end

  def include?(num)
    invalid_range?(num)
    store[num] == true
  end

  private
  def invalid_range?(num)
    raise "Out of bounds" if num < 0 || num > max
  end
end


class IntSet
  attr_reader :num_buckets, :max, :store
  def initialize(num_buckets = 20)
    @max = num_buckets
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    @store[bucket(num)] << num
    true
  end

  def remove(num)
    @store[bucket(num)].delete(num)
  end

  def include?(num)
    @store[bucket(num)].include?(num)
  end

  private
  def bucket(num)
    bucket = num % store.length
  end

end

class ResizingIntSet
  attr_reader :store
  attr_accessor :num_buckets, :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(num)
    unless include?(num)
      @store[bucket(num)] << num
      @count += 1
    end
    resize! if count >= num_buckets

  end

  def remove(num)
    if include?(num)
      @store[bucket(num)].delete(num)
      @count -= 1
    end

  end

  def include?(num)
    store[bucket(num)].include?(num)
  end

  private

  def bucket(num)
    num % num_buckets
  end

  def num_buckets
    @store.length
  end

  def resize!
    # debugger
    @num_buckets = num_buckets * 2
    old_arr = store
    @store = Array.new(@num_buckets) { Array.new }
    @count = 0
    old_arr.each do |bucket|
      bucket.each { |el| insert(el) }
    end
  end
end
