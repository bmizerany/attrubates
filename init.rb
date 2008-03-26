require File.dirname(__FILE__) + '/lib/attrubates'
require File.dirname(__FILE__) + '/lib/renderer'

if defined?(ActionController::Base)
  ActionController::Base.send(:include, Attrubates::Renderer)
  ActionController::Base.send(:include, Attrubates::Renderer::Rails)
end

if defined?(ActionView::Base)
  ActionView::Base.send(:include, Attrubates::Renderer)
  ActionView::Base.send(:include, Attrubates::Renderer::Rails)
end
