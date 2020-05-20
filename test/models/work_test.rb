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
end


  

    

    
  

  

   
