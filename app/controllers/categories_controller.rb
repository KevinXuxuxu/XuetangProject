class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy, :upward, :downward, :generate_privilege]

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.find_top_categories
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    validate read_priv_level
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/1/edit
  def edit
    validate edit_priv_level
  end

  # GET /category/1/upward
  def upward
    validate edit_priv_level
    @category.upward
    redirect_to :back
  end

  # GET /category/1/downward
  def downward
    validate edit_priv_level
    @category.downward
    redirect_to :back
  end

  # POST /categories
  # POST /categories.json
  # TODO: Set privilege check for create
  def create
    @category = Category.new_with_parent_name(category_params)

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @category }
      else
        format.html { render action: 'new' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    validate edit_priv_level
    respond_to do |format|
      if @category.update_with_patent_name(category_params)
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    validate create_priv_level
    @category.destroy
    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :no_content }
    end
  end

  # POST /categories/1/generate_privileges
  # TODO: Implement this method
  def generate_privilege
    if params.has_key? :data

    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
      @sub_categories = @category.children
    end

    # Never trust parameters from the scary internet, only allow the white list through.

    def category_params
      params[:category].permit(:name, :description, :parent)
    end

    def validate privilege_level
      unless @category.validate privilege_level, currentUser
        flash[:notice] = 'You are not authorized!'
        redirect_to :back
      end
    end

end
