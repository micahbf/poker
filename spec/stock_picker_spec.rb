require "stock_picker"

describe StockPicker do
  describe '#stock_picker' do
    subject(:stock_picker) { StockPicker.new }
    let(:stock) { [2,8,3,1,7,9] }
    it "should return the most profitable days" do
      stock_picker.stock_picker(stock).should == [3,5]
    end
  end

end