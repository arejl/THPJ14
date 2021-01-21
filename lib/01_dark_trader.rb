require "open-uri"
require "nokogiri"
PAGE_URL = "https://coinmarketcap.com/all/views/all/"

def currency_names
  puts "Récupération des noms de devises..."
  doc = Nokogiri::HTML(URI.open(PAGE_URL))
  names_xml = doc.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--left cmc-table__cell--sort-by__symbol"]/div')
  names_arr = Array.new
  names_xml.each do |name|
    names_arr << name.text
  end
  return names_arr
end

def currency_prices
  puts "Récupération des cours des devises..."
  doc = Nokogiri::HTML(URI.open(PAGE_URL))
  prices_xml = doc.xpath('//td[@class="cmc-table__cell cmc-table__cell--sortable cmc-table__cell--right cmc-table__cell--sort-by__price"]/div/a/text()')
  prices_arr = Array.new
  prices_xml.each do |price|
    prices_arr << price.text
  end
  return prices_arr
end

def currency_pairs(names_arr,prices_arr)
  puts "Mise en forme du résultat..."
  currencies = Hash[names_arr.zip(prices_arr)]
  result = Array.new
  currencies.each do |pair|
    result << pair
  end
  result.map! { |k, v| { k => v.delete("$").to_f} }
  return result
end

def perform
  names_arr=currency_names
  prices_arr=currency_prices
  result = currency_pairs(names_arr, prices_arr)
  puts "Voici les devises et leurs cours indiqués actuellement sur le site CoinMarketCap : #{result}"
end

perform
