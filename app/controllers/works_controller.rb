class WorksController < ApplicationController
  def index
    @works = Work.all
  end

  def home
    @works = Work.all
  end

  def show
   work_id = params[:id]
   @work = Work.find_by(id: work_id)
    if @work.nil?
      flash[:error] = "Media page does not exist! Here's a list of all Media available!"
      redirect_to works_path
    end
  end

  def new
    @work = Work.new
  end

  def create
    @work = Work.new(work_params) 
    if @work.save 
      flash[:success] = "Media added successfully!"
      redirect_to work_path(@work.id)
      return
    else 
      flash[:error] = "Media cannot be added!"
      render :new, status: :bad_request 
      return
    end
  end


  def edit
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    end
  end

  def update
    @work= Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return 
    elsif @work.update(work_params)
      flash[:success] = "Media updated successfully"
      redirect_to work_path(@work.id)
      return
    else
      flash[:error] = "Something happened, Media update unsuccessful!"
      render :edit
      return
    end
  end

  def destroy
    @work = Work.find_by(id: params[:id])
    if @work.nil?
      head :not_found
      return
    elsif 
      @work.votes.destroy_all
      @work.destroy
      redirect_to works_path
      return
    else
      render :show
      return
    end
  end

  def work_params
    return params.require(:work).permit(:category, :title, :creator, :publication_year, :description)
  end
end


