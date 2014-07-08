class IndexController < ApplicationController
  def index
    # navigator
    @top_categories = Category.find_top_categories
    # course table
    @belongs = Course.get_belongs #for filter

    @courses = []
    Course.all.each do |course|
      flag = true
      if params['content']
        params['content'].each do |param|
          temp = %Q{if course.#{param[0]}!= "#{param[1]}" and "#{param[1]}"!= ''
                      flag = false
                    end}
          if param[1]!= '' and param != ['belong', 'all']
            Class.class_eval(temp)
          end
        end
      end
      if flag
        @courses += [course]
      end
    end

    @course_table = []
    (1..6).each {
      temp = []
      (1..6).each { temp += [nil]}
      @course_table += [temp]
    }
    @courses.each do |course|
      (0..course.ctime.size).each do |i|
        if course.ctime[i] == '1'
          @course_table[(i-i%6)/6][i%6] = course
        end
      end
    end
  end
end
