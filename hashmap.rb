require_relative "my_linked_list/linked_list"
require_relative "my_linked_list/node"
require 'pry-byebug'

class HashMap
  attr_accessor :buckets
  HASHMAP_SIZE = 16
  def initialize
    self.buckets = Array.new(HASHMAP_SIZE, nil)
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
    curr_bucket = self.buckets[index]
    bucket_size = curr_bucket.size
    return if curr_bucket.nil?
 
    curr_bucket.traverse_list do |prev_node, curr_node|
      puts prev_node.key
      puts curr_node.key

      if curr_node.key == key 
 
        if curr_node.next_node.nil? && bucket_size > 1
          prev_node.next_node = nil
          curr_bucket.tail = prev_node
          return

        elsif curr_node.next_node.nil? && bucket_size == 1
          return curr_bucket.head = nil

        else 
          prev_node.next_node = curr_node.next_node
          curr_node = nil
          return
        end
      end
    end
  end

  def length
    count = 0

    self.buckets.each do |bucket| 
      next if bucket == nil

      count += bucket.size
    end
    return count
  end

  def clear
    self.buckets = Array.new(HASHMAP_SIZE, nil)
  end

  def keys
    key_arr = []

    self.for_each_node {|node| key_arr << node.key}
    return key_arr
  end

  def values
    value_arr = []

    self.for_each_node {|node| value_arr << node.value}
    return value_arr
  end

  def entries
    key_value_pair = []

    self.for_each_node {|node| key_value_pair << [node.key, node.value]}
    return key_value_pair
  end

  private 

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code % self.buckets.size
  end

  def for_each_node
    self.buckets.each do |bucket| 
      next if bucket == nil
      
      tmp = bucket.head

      while (tmp != nil)
        yield(tmp)
        tmp = tmp.next_node
      end 
    end
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
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')
p test.entries
test.remove('lion')
test.remove('kite')
p test.entries
p test.keys
p test.values
puts test.length