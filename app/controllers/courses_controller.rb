class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  # GET /courses
  # GET /courses.json
  def index
    @courses = []
    Course.all.each do |course|
      t1 = course.ctime.index('1')
      temp = "#{t1%6 + 1}-#{t1/6 + 1}"
      if t2 = course.ctime.index('1',t1+1)
        temp += ", #{t2%6 + 1}-#{t2/6 + 1}"
      end
      @courses += [[course,temp]]
    end # will add filter soon
    @course_table = []
    (1..6).each {
      temp = []
      (1..6).each { temp += [nil]}
      @course_table += [temp]
    }
    @courses.each do |course|
      (0..course[0].ctime.size).each do |i|
        if course[0].ctime[i] == '1'
          @course_table[(i-i%6)/6][i%6] = course[0]
        end
      end
    end
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    t1 = @course.ctime.index('1')
    @time = "#{t1%6 + 1}-#{t1/6 + 1}"
    if t2 = @course.ctime.index('1',t1+1)
      @time += ", #{t2%6 + 1}-#{t2/6 + 1}"
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render action: 'show', status: :created, location: @course }
      else
        format.html { render action: 'new' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :description, :location, :ctime, :belong, :teacher)
    end
end
