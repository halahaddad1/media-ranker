require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange

      @example_work = Work.new(category:"movie",title: 'test movie', creator: "test creator",publication_year: "test date",description: "test description")
    end

    it 'can be instantiated when all fields are present' do
      # Act
      result = @example_work.valid?

      # Assert
      expect(result).must_equal true
    end

    it "will have all required fields" do
      expect(@example_work.category).wont_be_nil
      expect(@example_work.title).wont_be_nil
      expect(@example_work.creator).wont_be_nil
      expect(@example_work.publication_year).wont_be_nil
      expect(@example_work.description).wont_be_nil

      [:category, :title, :creator, :publication_year, :description].each do |attribute|
        expect(@example_work).must_respond_to attribute
      end
  end

    it 'is invalid without a title' do
      @example_work.title = nil
    
      result = @example_work.valid?
    
      expect(result).must_equal false
      expect(@example_work.errors.messages).must_include :title
    end

    it "must have a category" do
      invalid_work_category = Work.create(category: nil, title: "Test Title", creator: "Test book creator", publication_year: 2017, description: "Test book description")

      expect(invalid_work_category.valid?).must_equal false
      expect(invalid_work_category.errors.messages).must_include :category
      expect(invalid_work_category.errors.messages[:category]).must_equal ["can't be blank"]
    end
    
    it "must have a title" do
      invalid_work_title = Work.create(category: "book", title: nil, creator: "Test book creator", publication_year: 2017, description: "Test book description")

      expect(invalid_work_title.valid?).must_equal false
      expect(invalid_work_title.errors.messages).must_include :title
      expect(invalid_work_title.errors.messages[:title]).must_equal ["can't be blank"]
    end
  end

    describe "relationships" do
      it "can have many votes" do
        @example_work = Work.create(category:"movie",title: 'test movie', creator: "test creator",publication_year: "test date",description: "test description")
        @example_user = User.create(username: "someone")
        @example_vote = Vote.create(work_id:@example_work.id,user_id:@example_user.id)

        expect(@example_work.votes.count).must_be :>=, 0
        @example_work.votes.each do |vote|
          expect(@example_vote).must_be_instance_of Vote
        end
      end
    end

    describe 'methods' do
      before do
        @works = Work.all
        @users = User.all
        @votes = Vote.all

        @spotlight_media = Work.spotlight
        @sample_work = Work.create(category:"movie",title: 'test movie', creator: "test creator",publication_year: "test date",description: "test description")
        @sample_vote = Vote.create(work_id:@sample_work.id,user_id:@users.first.id)

      end

      it 'can return a top media item for spotlight' do
      
        result = @spotlight_media.valid?
        
        expect(result).must_equal true
        expect(@spotlight_media).must_be_instance_of Work
        expect(@works.max_by { |work| work.votes.count }).must_equal @spotlight_media
      end
    

    it 'can return a list of movies' do
      
      result = Work.movies_list.count
      
      expect(result).must_equal 2
    end

    it 'can return a list of books' do
      
      result = Work.books_list.count
      
      expect(result).must_equal 1
    end

    it 'can return a list of albums' do
      
      result = Work.albums_list.count
    
      expect(result).must_equal 1
    end

    it "returns work votes count" do
      expect(@sample_work.votes.count).must_equal 1

    end
  end

  describe "top media" do
    describe "highest voted movies" do
      before do
        @works = Work.all
        @users = User.all
        @votes = Vote.all 
        @movie_vote = Vote.create(work_id:Work.movies_list.first.id,user_id:@users.first.id)
      end 

      it "returns accurate top movies with most votes" do
        expect(@works.first.votes.count).must_equal 1
      end

      it "only includes movies" do
        Work.movies_list.each do |work|
          expect(work.category).must_equal "movie"
        end
      end

      it "returns empty list if no movies" do
        Vote.destroy_all
        Work.destroy_all
        expect(Work.movies_list.count).must_equal 0
        expect(Work.movies_list).must_be_empty
      end
    end

    describe "top_books" do
      before do
        @works = Work.all
        @users = User.all
        @votes = Vote.all 
        @book_vote = Vote.create(work_id:Work.books_list.first.id,user_id:@users.first.id)
    
      end 

      it "returns accurate top books with most votes" do
        expect(Work.books_list.first.votes.count).must_equal 1
      end

      it "only includes books" do
        Work.books_list.each do |work|
          expect(Work.books_list.first.category).must_equal "book"
        end
      end

      it "returns empty list if no books" do
        Vote.destroy_all
        Work.destroy_all
        expect(Work.books_list.count).must_equal 0
        expect(Work.books_list).must_be_empty
      end
    end

    describe "top_ten_albums" do
      before do
        @works = Work.all
        @users = User.all
        @votes = Vote.all 
        @album_vote = Vote.create(work_id:Work.albums_list.first.id,user_id:@users.first.id)
      end 

      it "returns accurate top albums with most votes" do
        expect(Work.albums_list.first.votes.count).must_equal 2
      end

      it "only includes albums" do
        Work.albums_list.each do |work|
          expect(Work.albums_list.first.category).must_equal "album"
        end
      end

      it "returns empty list if no albums" do
        Vote.destroy_all
        Work.destroy_all
        expect(Work.albums_list.count).must_equal 0

        expect(Work.albums_list).must_be_empty
      end
    end
  end
end

