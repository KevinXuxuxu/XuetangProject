class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    redirect_to :back
  end

  # GET /comments/new
  def new
    @comment = Comment.new
    render :nothing => true
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    #params[:comment][:post]
    @comment = Comment.new(comment_params)
    target_post = Post.find(params[:post_id].to_i)
    @comment.post = target_post
    @comment.author = currentUser

    if @comment.content =~ /Replying (.*):/
      name = $1
      Message.create({kind: "reply", url: "posts/#{target_post.id}##{@comment.author.name.gsub(' ','_')}", status: "active", user: User.find_by_name(name)})
      flag = User.find_by_name(name) == target_post.author ? false : true
    end

    if target_post.author != @comment.author and flag
      Message.create({kind: "comment", url: "posts/#{target_post.id}##{@comment.author.name.gsub(' ','_')}", status: "active", user: target_post.author})
    end

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @comment.post, notice: 'Comment was successfully created.' }
        format.json { render action: 'show', status: :created, location: @comment }
      else
        format.html { render action: 'new' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to @comment, notice: 'Comment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :author, :post)
    end
end
