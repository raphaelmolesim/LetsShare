class Person
  def about
    puts 1
  end
end

class Developer < Person
  def about
    2
  end
end

dev = Developer.new
dev.instance_eval { remove_method :about }
puts dev.about