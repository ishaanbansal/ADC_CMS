class PublicController < ApplicationController

  layout 'public'
  before_action :confirm_user_logged_in, :except => [:login, :attempt_login, :index, :contact, :products]
  
  before_action :setup_navigation

  def index
    # intro text
  end

  def search
    # search text
    query_final=" "
    @query=params[:query].tr('^A-Za-z0-9', ' ')
    @query_arr=@query.split 
    @query_arr.each { |x| 
      query_final+="name LIKE '%#{x}%' OR content LIKE '%#{x}%' OR "
    }
    query_final+="name LIKE '"+@query+"' OR content LIKE '"+@query+"'"
    @search_results=Section.visible.where(query_final).sorted
  end

  def show
    @page = Page.where(:permalink => params[:permalink], :visible => true).first
    if @page.nil?
      redirect_to(:action => 'index')
    else
      # display the page content using show.html.erb
    end
  end

  def contact
  end

  def products
  end

  private

    def setup_navigation
      @subjects = Subject.visible.sorted
    end

end
