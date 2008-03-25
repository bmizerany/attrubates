module Attrubates

  ###
  # Methods for rendering attrubated partials
  module Renderer

    ###
    # See README.rdoc
    def render_attrubate(o, *args)
      raise "The object must attrubate!" unless o.respond_to?(:attrubated)
      options, a = args.extract_options!, args[0]
      local_name = o.class.name.underscore
      prefix = options.delete(:prefix) || 'shared/attrubates'
      options[:locals] ||= {}
      options[:locals][local_name] = o unless options[:locals].has_key?(local_name)
      parts = [prefix, local_name, "#{a ? a.to_s + '_' : ''}#{options[:force] || o.attrubated[a || :self]}"]
      render(options.merge(:partial => File.join(*parts)))
    end
  end
end
