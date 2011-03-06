class String
  
  alias :base_include? :include?
  
  def include? regex
    return base_include? regex if regex.class == String
    ret = self.match (regex)
    ret ? true : false
  end
  
end