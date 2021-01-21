require "open-uri"
require "nokogiri"
PAGE_URL = "https://coinmarketcap.com/all/views/all/"

doc = Nokogiri::HTML(URI.open(PAGE_URL))

names_xml = doc.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol"]/div')
Names_arr = Array.new
names_xml.each do |name|
  Names_arr << name.text
end

prices_xml = doc.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]/div/a/text()')
Prices_arr = Array.new
prices_xml.each do |price|
  Prices_arr << price.text
end

def currency_pairs
  currencies = Hash[Names_arr.zip(Prices_arr)]
  result = Array.new
  currencies.each do |pair|
    result << pair
  end
  result.map! { |k, v| { k => v.delete("$").to_f } }
  return result
end

def perform
result=currency_pairs
puts "Voici les devises et leurs cours indiqués actuellement sur le site CoinMarketCap : #{result}"
end

perform
