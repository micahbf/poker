class StockPicker

  def stock_picker(stock)
    best_profit = 0
    buy_sell_days = []

    stock.each_with_index do |buy_price, buy_index|
      stock.each_with_index do |sell_price, sell_index|
        next if sell_index <= buy_index
        if sell_price - buy_price > best_profit
          best_profit = sell_price - buy_price
          buy_sell_days = [buy_index, sell_index]
        end
      end
    end
    buy_sell_days
  end
end
