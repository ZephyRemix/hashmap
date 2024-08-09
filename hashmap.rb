require_relative "my_linked_list/linked_list"
require_relative "my_linked_list/node"

class HashMap
  def initialize
  end

  # Use the following snippet whenever you access a bucket through an index. We want to raise an error if we try to access an out of bound index:
  # raise IndexError if index.negative? || index >= @buckets.length

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set(key, value)
    # get hashmap index

    # access hashmap => self[index]
    # 
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
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')