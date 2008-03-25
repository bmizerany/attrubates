module Attrubates

  ###
  # Methods for rendering attrubated partials
  module Renderer

    ###
    # Render attrubated partials
    # 
    # Assuming operations on:
    #   class Foo
    #     attrubates :meta => [:show, :edit, :hide],
    #                :attrs => [:foo, :bar],
    #                :defaults => {:foo => :show, :bar => :edit, :self => :show}
    #   end
    #
    # === Options:
    #
    # <tt>:force</tt> overrides rendering of attrubated state
    #
    # === Usage:
    #   
    #   render_attrubate @foo                   # => views/shared/attrubates/foo/_show
    #   render_attrubate @foo, :force => :edit  # => views/shared/attrubates/foo/_edit
    #   render_attrubate @foo, :bar             # => views/shared/attrubates/foo/_bar_edit
    #   
    # ===== Assuming defaults are not set
    #
    #   render_attrubate @foo                   # => views/shared/attrubates/foo/_default
    #   render_attrubate @foo, :bar             # => views/shared/attrubates/foo/_bar_default
    #
    # = And now if:
    #   
    #   @foo.edit_attrubate(:bar)
    #   render_attrubate @foo, :bar             # => views/shared/attrubates/foo/_bar_edit
    # === Locals
    # <tt>render_attrubate</tt> will assign <tt>:locals => { :foo => @foo }</tt> for free
    def render_attrubate(*args)
      options = args.extract_options!
      raise "0 for 1 arguments supplied" unless args.size > 0
      o, a = args[0..1]
      raise "The object must attrubate!" unless o.respond_to?(:attrubated)
      local_name = o.class.name.underscore
      prefix = options.delete(:prefix) || 'shared/attrubates'
      options[:locals] ||= {}
      options[:locals][local_name] = o unless options[:locals].has_key?(local_name)
      parts = [prefix, local_name, "#{a ? a.to_s + '_' : ''}#{options[:force] || o.attrubated[a || :self]}"]
      render(options.merge(:partial => File.join(*parts)))
    end
  end
end
