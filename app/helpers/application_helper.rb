module ApplicationHelper
  def append_query_string(url, key, value)
    "#{url}#{url.index('?') ? '&' : '?'}#{key}=#{value}"
  end
end

