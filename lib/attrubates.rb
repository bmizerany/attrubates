module Attrubates
  def attrubates(options={})
    raise 'You need to specifiy :meta' unless options[:meta] && !options[:meta].empty?
    raise 'You need to specifiy :attrs' unless options[:attrs] || respond_to?(:columns)
    define_method(:attrubated) { @attrubates ||= options[:defaults] || {} }
    define_method(:attrubate) { |state, value| attrubated[state] = value }
    define_method(:attrubated_name) { |a| "#{a}_#{attrubated[a]}" }
    options[:attrs] ||= self.class.columns.map { |c| c.name =~ /_id$/ ? nil : c.name.to_sym }.compact
    options[:attrs] << :self
    options[:meta].each do |meta|
      define_method("#{meta}_attrubate") { |m| attrubated[m] = meta }
      options[:attrs].each do |name|
        define_method("#{meta}_#{name}?") { attrubated[name] == meta }
      end
    end
  end 
end

Object.send(:extend, Attrubates)
