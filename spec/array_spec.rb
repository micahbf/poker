require 'array'
require 'towers_of_hanoi'

describe Array do

  describe "#my_uniq" do
    subject(:test_array) { [1, 1, 2, 2, 3] }

    it "should take in an array and return a new array" do
      duped_test_array = test_array.dup
      duped_test_array.my_uniq
      duped_test_array.should == test_array
    end

    it "returns an array without duplicates" do
      test_array.my_uniq.should == [1, 2, 3]
    end
  end


  describe "#two_sum" do
    subject(:test_array) { [-1, 0, 2, -2, 1] }
    it "should return a pair of indices that return to zero" do
      test_array.two_sum.should == [[0,4], [2,3]]
    end

    it "should return the paired indices in dictionary order" do
      test_array.two_sum.should_not == [[2,3], [0,4]]
    end
  end

  describe '#my_transpose' do
    subject(:test_array) { [ [0, 1, 2], [3, 4, 5], [6, 7, 8] ] }
    it "should transpose the array" do
      test_array.my_transpose.should == [ [0, 3, 6], [1, 4, 7], [2, 5, 8] ]
    end
  end
end

describe TowersOfHanoi do
  subject(:game) { TowersOfHanoi.new(3) }
  let(:pile1) { []}

  describe '#render' do
    it "" do
    end
  end

  describe '#towers' do
    it "should return the towers as an array of arrays" do
      game.towers.should == [[3,2,1],[],[]]
    end
  end

  describe '#move' do
    it "should move a disc from one array to another" do
      game.move(0,1)
      game.towers.should == [[3,2],[1],[]]
    end

    it "should raise an error if you try to move a big disc on to a smaller disc" do
      expect do
        game.move(0,1)
        game.move(0,1)
      end.to raise_error
    end
  end

  describe '#won?' do
    before (:each) do
      game.move(0,2)
      game.move(0,1)
      game.move(2,1)
      game.move(0,2)
      game.move(1,0)
      game.move(1,2)
      game.move(0,2)
    end

    it "return true with a winning sequence" do
      game.won?.should == true
    end

    it "should return false with a losing sequence" do
      game.move(2,1)
      game.won?.should == false
    end
  end
end