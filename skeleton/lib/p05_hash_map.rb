require_relative 'p04_linked_list'

class HashMap
  include Enumerable
  attr_accessor :count, :num_buckets
  attr_reader :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
    @num_buckets = num_buckets
  end

  def include?(key)
    @store[bucket(key)].include?(key)
  end

  def set(key, val)
    if include?(key)
      @store[bucket(key)].update(key, val)
    else
      @store[bucket(key)].append(key, val)
      @count += 1
      resize! if @count == num_buckets
    end
  end

  def get(key)
    @store[bucket(key)].get(key)
  end

  def delete(key)
    @store[bucket(key)].remove(key)
    @count -= 1
  end

  def each
    store.each do |list|
      list.each do |node|
        yield [node.key, node.val]
      end
    end
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    @num_buckets = num_buckets * 2
    old_arr = store
    @store = Array.new(@num_buckets) { LinkedList.new }
    @count = 0
    old_arr.each do |list|
      list.each { |node| set(node.key, node.val) }
    end
  end

  def bucket(key)
    key.hash % num_buckets
  end
end
