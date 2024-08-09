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
      existing_node = self.buckets[index].find(key)
      return existing_node.update_node(value) if !existing_node.nil?
      return self.buckets[index].append(key, value)
    end

    self.buckets[index] = LinkedList.new
    self.buckets[index].prepend(key, value)
  end

  def get(key)
    index = self.hash(key)

    if self.buckets[index] == nil || self.buckets[index].find(key) == nil
      return nil
    end

    return self.buckets[index].find(key).value
  end

  def has?(key)
    index = self.hash(key)

    self.buckets[index].contains?(key)
  end 

  def remove(key)
    index = self.hash(key)

    curr_node = self.buckets[index].find(key)
    # require implementation of #remove_at(index) within linked_list
    # return deleted_value
  end

  def length
    count = 0

    self.buckets.each do |bucket| 
      next if bucket == nil

      count += bucket.size
    end
    return count
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
test.set('apple', 'new value!!!!')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
puts test.get('hat')
puts test.has?('monkey')

test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
puts test.length