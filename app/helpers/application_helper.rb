# frozen_string_literal: true

module ApplicationHelper
  def javascript(properties = {})
    @properties = properties
    @path = "#{params['controller']}/#{params['action']}"
    render 'javascript'
  end
end
