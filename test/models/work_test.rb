require "test_helper"

describe Work do
  describe 'validations' do
    before do
      # Arrange

      @example_work = Work.new(category:"movie",title: 'test movie', creator: "test creator",publication_year: "test date",description: "test description")
    end

    it 'is valid when all fields are present' do
      # Act
      result = @example_work.valid?

      # Assert
      expect(result).must_equal true
    end

    it 'is invalid without a title' do
      @example_work.title = nil
    
      result = @example_work.valid?
    
      expect(result).must_equal false
      expect(@example_work.errors.messages).must_include :title
    end
  end

  describe 'methods' do
    before do
      @works = Work.all

      @spotlight_media = Work.spotlight
    end

  
    it 'can return a top media item for spotlight' do
    
      result = @spotlight_media.valid?
      
      expect(result).must_equal true
    end
  end

  it 'can return a list of movies' do
    
    result = Work.movies_list.count
    
    expect(result).must_equal 1
  end

  it 'can return a list of books' do
    
    result = Work.books_list.count
    
    expect(result).must_equal 1
  end

  it 'can return a list of albums' do
    
    result = Work.albums_list.count
    
    # Assert
    expect(result).must_equal 1
  end

end

