class PagesController < ApplicationController

    def index
        @works = Work.all
    end

end
