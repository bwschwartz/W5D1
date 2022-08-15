require 'byebug'

class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    next_node, prev_node  = self.next, self.prev
    prev_node.next = next_node
    next_node.prev = prev_node
  end
end

class LinkedList
  include Enumerable

  attr_reader :tail, :head
  def initialize
    @tail = Node.new
    @head = Node.new
    @tail.prev = @head
    @head.next = @tail
  end

  def empty?
    head.next == tail
  end

  def [](i)
    node_num = 0
    node = head.next
    until node_num == i
      node = node.next
      node_num += 1
    end
    node

  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def get(key)
    node = head.next
    until node == tail
      return node.val if node.key == key
      node = node.next
    end
    nil

  end

  def include?(key)
    node = head.next
    until node == tail
      return true if node.key == key
      node = node.next
    end
    false
  end

  def append(key, val)
    last = tail.prev
    last.next = Node.new(key, val)
    tail.prev = last.next
    last.next.next = tail
    last.next.prev = last
  end

  def update(key, val)
    node = head.next
    until node == tail
      node.val = val if node.key == key
      node = node.next
    end
  end

  def remove(key)
    node = head.next
    until node == tail
      return node.remove if node.key == key
      node = node.next
    end
  end

  def each
    node = head.next
    until node == tail
      yield node
      node = node.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
