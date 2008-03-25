require 'helper'
require 'ostruct'

require File.dirname(__FILE__) + '/../lib/attrubates'

context "Attrubates (happy with attrs)" do
  
  setup do
    @klass = Class.new
    @klass.attrubates :meta => [:show, :edit, :hide],
                      :attrs => [:foo, :bar],
                      :defaults => {:foo => :show, :bar => :edit, :self => :show}
  end
  
  specify "should use defaults" do
    assert @klass.new.show_foo?
  end
  
  specify "should be false if no default" do
    assert !@klass.new.edit_foo?
  end
  
  specify "should return true if meta matches change" do
    k = @klass.new 
    k.edit_attrubate(:foo)
    k.edit_foo?
  end
  
  specify "should give partial name" do
    assert_equal "foo_show", @klass.new.attrubated_name(:foo)
  end
  
  specify "self can have a default" do
    assert_equal :show, @klass.new.attrubated[:self]
  end

  specify "self is already included" do
    assert @klass.new.show_self?
  end

  specify "should use columns if available" do
    @klass = Class.new
    @klass.class.send(:define_method, :columns) { [OpenStruct.new(:name => 'blake')] }
    @klass.attrubates :meta => [:show, :edit, :preview]
    assert @klass.new.respond_to?(:show_blake?)
  end

  specify "should raise error if not :attrs and :columns not available" do
    @klass = Class.new
    assert_raises(RuntimeError) do
      @klass.attrubates :meta => [:show, :edit, :preview]
    end
  end

  specify "should raise error if :meta not available" do
    @klass = Class.new
    assert_raises(RuntimeError) do
      @klass.attrubates :attrs => [:foo]
    end
  end

end

