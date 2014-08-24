class TagsController < ApplicationController

  # GET /tags.json
  def index
    @list = []
    @tags = Tag.all
    
    @tags.each do |tag|
      @list << tag.content
    end
    
    respond_to do |format|
      format.json { render json: @list }
    end
  end
end
