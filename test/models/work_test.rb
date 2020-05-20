require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange

      @work = Work.new(category:"movie",title: 'test movie', creator: "test creator",publication_year: "test date",description: "test description")
    end

    it 'is valid when all fields are present' do
      # Act
      result = @work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      # Arrange
      @work.title = nil
    
      # Act
      result = @work.valid?
    
      # Assert
      expect(result).must_equal false
      expect(@work.errors.messages).must_include :title
    end
  end

  describe 'methods' do
    before do
      # Arrange
      @works = Work.all

      @random_media = Work.random_spotlight
    end

  
    it 'can return a random media item' do
    
      result = @random_media.valid?
      
      # Assert
      expect(result).must_equal true
    end
  end

  it 'can return a list of movies' do
    
    result = Work.movies_list.count
    
    # Assert
    expect(result).must_equal 1
  end

  it 'can return a list of books' do
    
    result = Work.books_list.count
    
    # Assert
    expect(result).must_equal 1
  end

  it 'can return a list of albums' do
    
    result = Work.albums_list.count
    
    # Assert
    expect(result).must_equal 1
  end




end


  

    

    
  

  

   
