class WorksController < ApplicationController
  def index
    if @works = Work.all
      render :index
    else 
      render :index1
    end
  end

  def show
   work_id = params[:id]
   @work = Work.find_by(id: work_id)
    if @work.nil?
      head :not_found
      return
    end
  end
end
