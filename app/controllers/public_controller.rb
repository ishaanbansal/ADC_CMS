class PublicController < ApplicationController

  layout 'public'

  before_action :setup_navigation

  def index
    # intro text
  end

  def search
    # search text
    @query=params[:query]
    @search_results=Section.visible.where("name LIKE '%#{@query}%' OR content LIKE '%#{@query}%'").sorted
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

  private

    def setup_navigation
      @subjects = Subject.visible.sorted
    end

end
