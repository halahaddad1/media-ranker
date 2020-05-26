class VotesController < ApplicationController

    def create
        if @user.nil?
        flash[:error] = "Please Log In to vote!"
        redirect_to request.referrer
        return
        end
    
        work = Work.find_by(id: params[:work_id])
        if work.nil?
        head :not_found 
        return
        end
    
        @vote = Vote.new(work_id: work.id, user_id: @user.id)
    
        if @vote.save
        flash[:success] = "Upvote Successful!"
        redirect_to request.referrer
        return
        else
        flash[:error] = "Cannot Upvote this work!"
        flash[:reason] = "Already Voted! cannot vote twice!"
        redirect_to request.referrer
        return
        end
    end

end
