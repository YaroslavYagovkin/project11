class LinksController < ApplicationController
  before_action only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, exept: [:index]

  def index
    if user_signed_in?
      @links = current_user.links
    end
  end

  def new
    @link = current_user.links.build
  end

  def edit
    @link = current_user.links.find(link_id_params)
  end

  def create
    @link = current_user.links.new(link_params)
    
    if @link.save
      redirect_to links_path
    else 
      render 'new'
    end
  end

  def update
    @link = current_user.links.find(link_id_params)

    if @link.update_attributes(link_params)
      redirect_to links_path
    else 
      render 'edit'
    end
  end

  def destroy
    @link = current_user.links.find(link_id_params)
    @link.destroy
    
    redirect_to links_path
  end

  def show_all_tags
    @tag = []

    tags = current_user.links
    

    tags.each do |t|
      @tag += t.tags.split(',')
    end

    @tag=@tag.uniq
    
  end

  def show_link_by_tag_name
      tags = current_user.links
      @tag = tag_params
      @links = []

      tags.each do |t|
        if t.tags.include? @tag
          @links << t
        end
      end
  end

  private
    def link_params
      params.require(:link).permit(:link_text, :tags, :descriptio)
    end

    def link_id_params
      return params[:id]
    end 

    def tag_params 
      return params[:tags]
    end  

end   