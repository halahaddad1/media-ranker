class Work < ApplicationRecord
    has_many :votes

    validates :category, presence: true
    validates :title, presence: true
    validates :creator, presence: true
    validates :publication_year, presence: true
    validates :description, presence: true
    CATEGORIES = [:movie,:book,:album]

    def self.spotlight
        return Work.all.max_by { |work| work.votes.count }
    end

    def self.movies_list
       @movies= Work.where(category: "movie")
       return @movies.sort_by { |work| work.votes.count }.reverse!
    end

    def self.books_list
        @books=Work.where(category: "book")
        return @books.sort_by { |work| work.votes.count }.reverse!
    end

    def self.albums_list
        @albums=Work.where(category: "album")
        return @albums.sort_by { |work| work.votes.count }.reverse!
    end


    
end

