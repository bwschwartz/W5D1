class HashSet
  attr_reader :count, :store
  attr_accessor :num_buckets

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def insert(key)
    unless include?(key)
      @store[bucket(key)] << key
      @count += 1
    end
    resize! if count >= num_buckets

  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def remove(key)
    if include?(key)
      @store[bucket(key)].delete(key)
      @count -= 1
    end
  end

  private

  def bucket(key)
    key.hash % num_buckets
  end

  def resize!
    @num_buckets = num_buckets * 2
    old_arr = store
    @store = Array.new(@num_buckets) { Array.new }
    @count = 0
    old_arr.each do |bucket|
      bucket.each { |el| insert(el) }
    end
  end

end
