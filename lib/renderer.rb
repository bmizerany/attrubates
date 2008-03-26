module Attrubates
  module Renderer
    ###
    # See README.rdoc
    def render_attrubate(o, *args)
      raise "The object must attrubate!" unless o.respond_to?(:attrubated)
      options, a = extract_options_from_args!(args) || {}, args[0]
      local_name = o.class.name.underscore
      prefix = normalize_prefix(options.delete(:prefix))
      options[:locals] ||= {}
      options[:locals][local_name] = o unless options[:locals].has_key?(local_name)
      parts = [prefix, local_name, "#{a ? a.to_s + '_' : ''}#{options[:force] || o.attrubated[a || :self]}"]
      template_path = File.join(*parts)
      if respond_to?(:partial)
        partial(template_path, options)
      else
        render(options.merge(:partial => template_path))
      end
    end

    module Merb
      def normalize_prefix(prefix); prefix || Merb.dir_for(:attrubates) || Merb.dir_for(:view) + '/attrubates'; end
    end
    
    module Rails
      def extract_options_from_args!(args); args.extract_options!; end
      def normalize_prefix(prefix); prefix || 'shared/attrubates'; end
    end
  end
end
