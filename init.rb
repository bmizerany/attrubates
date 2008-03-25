require File.dirname(__FILE__) + '/lib/attrubates'
require File.dirname(__FILE__) + '/lib/renderer'

ActionView::Base.send(:include, Attrubates::Renderer)
