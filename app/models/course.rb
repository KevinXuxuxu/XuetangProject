class Course < ActiveRecord::Base
  def self.get_belongs
    temp = []
    self.all.each do |course|
      if !temp.index(course.belong)
        temp += [course.belong]
      end
    end
    return temp
  end
end
