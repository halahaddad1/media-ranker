class Work < ApplicationRecord
    has_many :votes

    validates :category, presence: true
    validates :title, presence: true
    validates :creator, presence: true
    validates :publication_year, presence: true
    validates :description, presence: true
    CATEGORIES = [:movie,:book,:album]

    def self.random_spotlight
        offset = rand(Work.count)
        rand_record = Work.offset(offset).first
        return rand_record
    end

    def self.movies_list
       @movies= Work.where(category: "movie")
       return @movies
    end

    def self.books_list
        @books=Work.where(category: "book")
        return @books
    end

    def self.albums_list
        @albums=Work.where(category: "album")
        return @albums
    end


    
end
