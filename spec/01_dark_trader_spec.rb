require_relative '../lib/01_dark_trader.rb'

describe "the currency_pairs method" do
  names_arr=currency_names
  prices_arr=currency_prices
  it "should return an array" do
    expect(currency_pairs(names_arr, prices_arr)).is_a? Array
  end
  it "should return an array that is not empty" do
    expect(currency_pairs(names_arr, prices_arr)).not_to match_array([])
  end
end