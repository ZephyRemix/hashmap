require_relative "my_linked_list/linked_list"
require_relative "my_linked_list/node"
require 'pry-byebug'

class HashMap
  attr_accessor :buckets

  def initialize
    self.buckets = Array.new(16, nil)
  end

  # Use the following snippet whenever you access a bucket through an index. We want to raise an error if we try to access an out of bound index:
  # raise IndexError if index.negative? || index >= @buckets.length

  def set(key, value)
    index = self.hash(key)

    if self.buckets[index] != nil
      return self.buckets[index].append(key, value)
    end

    self.buckets[index] = LinkedList.new
    self.buckets[index].prepend(key, value)
  end

  def get(key)
    index = self.hash(key)

    node = self.buckets[index].find(key)
    return node.value
  end

  def has?(key)
    index = self.hash(key)

    self.buckets[index].contains?(key)
  end 

  private 

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code % self.buckets.size
  end
end 

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
puts test.get('banana')
puts test.has?('monkey')
# test.set('ice cream', 'white')
# test.set('jacket', 'blue')
# test.set('kite', 'pink')
# test.set('lion', 'golden')
# p test.inspect