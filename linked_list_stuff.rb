class LinkedList
  attr_accessor :next, :value
  def initialize(value = nil, next_node = nil)
    @value = value
    @next = next_node
  end

  def length
    count = 0
    cur_node = self
    until cur_node == nil
      cur_node = cur_node.next
      count += 1
    end

    count
  end

  def is_circular?
    slow_runner = self
    fast_runner = self

    until fast_runner == nil || fast_runner.next == nil
      slow_runner = slow_runner.next
      fast_runner = fast_runner.next.next
      return true if slow_runner == fast_runner
    end

    false
  end

  def find_loop_start
    slow_runner = self
    fast_runner = self

    until fast_runner == nil || fast_runner.next == nil
      slow_runner = slow_runner.next
      fast_runner = fast_runner.next.next
      break if slow_runner == fast_runner
      return nil if fast_runner == nil || fast_runner.next == nil
    end

    slow_runner = self
    until slow_runner == fast_runner
      slow_runner = slow_runner.next
      fast_runner = fast_runner.next
    end

    return fast_runner
  end

  def intersects?(other_list)
    this_node = self
    other_node = other_list

    this_node = this_node.next until this_node.next == nil
    other_node = other_node.next until other_node.next == nil

    this_node == other_node
  end

  def find_intersection(other_list)
    this_length, other_length = 0, 0
    this_node = self
    other_node = other_list

    until this_node.next == nil
      this_node = this_node.next
      this_length += 1
    end

    until other_node.next == nil
      other_node = other_node.next
      other_length += 1
    end

    return nil if this_node != other_node

    longer_list, shorter_list = nil, nil
    if this_length >= other_length
      longer_list = self
      shorter_list = other_list
    else
      shorter_list = self
      longer_list = other_list
    end

    diff = (this_length - other_length).abs

    diff.times { longer_list = longer_list.next }

    until longer_list == shorter_list
      longer_list = longer_list.next
      shorter_list = shorter_list.next
    end

    return longer_list
  end

  def is_palindrome?
    slow = self
    fast = self
    stack = []

    until fast.nil? || fast.next.nil?
      stack.push(slow.value)
      slow = slow.next
      fast = fast.next.next
    end

    unless fast.nil?
      slow = slow.next
    end

    until slow.nil?
      return false unless slow.value == stack.pop
      slow = slow.next
    end

    true
  end

  def reverse_sum(other_node, carry = 0)
    return self.value if other_node.nil?

    result = LinkedList.new()
    value = carry + self.value + other_node.value
    result.value = value % 10

    other_node = other_node.next
    carry = value >= 10 ? 1 : 0

    if self.next
      more = self.next.reverse_sum(other_node, carry)
      result.next = more
    end

    return result
  end

  def zero_pad_left(desired_length)
    diff = desired_length - length
    return self if diff <= 0
    new_list = LinkedList.new(0)
    new_length = 1
    until new_length = diff
      new_list.next = LinkedList.new(0)
      new_list = new_list.next
      new_length += 1
    end
    new_list.next = self

    new_list
  end

  def inspect
    result = []
    cur_node = self

    until cur_node == nil
      result << cur_node.value
      cur_node = cur_node.next
    end
    "<LinkedList> #{result.join("->")}".inspect
  end
end
