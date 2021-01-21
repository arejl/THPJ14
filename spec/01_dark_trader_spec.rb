require_relative '../lib/01_dark_trader.rb'

describe "the currency_pairs method" do
  it "should return an array" do
    expect(currency_pairs).is_a? Array
  end
  it "should return an array that is not empty" do
    expect(currency_pairs).not_to match_array([])
  end
end