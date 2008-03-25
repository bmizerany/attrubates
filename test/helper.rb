require 'test/unit'

##
# test/spec/mini
# chris@ozmm.org
# http://ozmm.org/posts/testspecmini.html
def context(*args, &block)
  return super unless (name = args.first) && block
  require 'test/unit'
  klass = Class.new(Test::Unit::TestCase) do
    def self.specify(name, &block) define_method("test_#{name.gsub(/\W/,'_')}", &block) end
    def self.xspecify(*args) end
    def self.setup(&block) define_method(:setup, &block) end
    def self.teardown(&block) define_method(:teardown, &block) end
  end
  klass.class_eval &block
end
