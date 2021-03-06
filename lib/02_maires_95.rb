require "open-uri"
require "nokogiri"
PAGE_URL2 = "http://annuaire-des-mairies.com/val-d-oise.html"

def get_city_names
  #On récupère le nom de tous les liens, c'est-à-dire la liste des villes du 95.
  #Ce sera la key du hash final.
  puts "Récupération de la liste des villes en cours..."
  doc = Nokogiri::HTML(URI.open(PAGE_URL2))
  city_names_xml = doc.xpath('//a[@class="lientxt"]/text()')
  city_names = Array.new
  city_names_xml.each do |city|
    city_names << city.text
  end
  puts "Liste des villes récupérée"
  return city_names
end

def get_townhall_url
  #On récupère les URL des liens des villes.
  puts "Récupération des URL des sites des villes en cours..."
  doc = Nokogiri::HTML(URI.open(PAGE_URL2))
  townhall_url_xml = doc.xpath('//a[@class="lientxt"]/@href')
  townhall_url = Array.new
  townhall_url_xml.each do |link|
    townhall_url << "http://annuaire-des-mairies.com/#{link.text[2..-1]}"
  end
  puts "URL des sites des villes récupérées"
  return townhall_url
end

def get_townhall_email(townhall_url)
  #A partir de la liste d'URL de la méthode précédente, cette méthode va ouvrir chaque URL et y récupérer l'e-mail cherché.
  puts "Récupération des emails en cours..."
  townhall_email = Array.new
  townhall_url.each do |city_url|
    doc = Nokogiri::HTML(URI.open(city_url))
    townhall_email_xml = doc.xpath('//td[contains(text(),"@")]')
    townhall_email << townhall_email_xml.text
  end
  puts "Liste des e-mails récupérée"
  return townhall_email
end

def combine_city_mail(city_names, townhall_email)
  #On associe noms des villes et emails récupérés précédemment dans un array de hashes.
  puts "Formatage en cours"
  city_and_email = Hash[city_names.zip(townhall_email)]
  result = Array.new
  city_and_email.each do |pair|
    result << pair
  end
  result.map! { |k, v| { k => v } }
  return result
end

def perform
  city_names = get_city_names
  townhall_url = get_townhall_url
  townhall_email = get_townhall_email(townhall_url)
  result = combine_city_mail(city_names, townhall_email)
  puts "Voici les adresses : #{result}"
end

perform
