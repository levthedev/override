class SomeClass
  def my_method
    puts "foo"   # => nil, nil
  end
end

a = SomeClass.new  # => #<SomeClass:0x007fda6b004d10>
a.my_method        # => nil

#in the test suite, this is the stubbed singleton method
#__________________________________________________________
copy = a.method(:my_method)                                  # => #<Method: SomeClass#my_method>
a.send(:define_singleton_method, :my_method) { puts "bar" }  # => :my_method
#__________________________________________________________

a.my_method  # => nil

#this is the reversion back to the old method
#__________________________________________________
a.define_singleton_method(:my_method) { copy.call }  # => :my_method
#__________________________________________________

a.my_method  # => nil

# >> foo
# >> bar
# >> foo
# everything works as expected - method is saved as a copy that can be referenced later.
