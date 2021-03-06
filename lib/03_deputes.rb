require "open-uri"
require "nokogiri"
PAGE_URL = "https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

def get_PM_url
  puts "Récupération des pages personnelles des député.e.s en cours..."
  doc = Nokogiri::HTML(URI.open(PAGE_URL))
  pm_url_xml = doc.xpath('//div[@id="deputes-list"]/div/ul/li/a/@href')
  pm_url = Array.new
  pm_url_xml.each do |link|
    pm_url << "https://www2.assemblee-nationale.fr/#{link.text[2..-1]}"
  end
  puts "Liste des pages personnelles des député.e.s récupérée, #{pm_url.size} député.e.s trouvé.e.s."
  return pm_url
end

def get_PM_email
  puts "Récupération des e-mails en cours..."
  doc = Nokogiri::HTML(URI.open("https://mortchoisie.jimdofree.com/guide-pratique/d%C3%A9put%C3%A9s/"))
  pm_email = Array.new
  pm_first_name = Array.new
  pm_last_name = Array.new
  pm_email_xml = doc.xpath('//a/span[contains(text(),"@assemblee-nationale.fr")]')
  pm_email_xml.each do |mail|
    mail.text != nil ? pm_email << mail.text : pm_email << "(non fourni)"
    #Pour les lignes 30 à 36, on récupère le prénom et le nom de famille depuis l'email, qui a la forme prenom.nom@assemblee-nationale.fr.
    #On récupère donc le prénom en prenant tout ce qui est avant le premier point, et le nom en prenant ce qui est entre le premier point et l'arrobase.
    i = 0
    until mail.text[i] == "." || mail.text[i] == "@"
      string = mail.text[0..i]
      i += 1
    end
    mail.text[i] == "." ? pm_first_name << string.capitalize : pm_first_name << "(Non précisé)"
    mail.text[/\.(.*?)@/, 1] != nil ? pm_last_name << mail.text[/\.(.*?)@/, 1].capitalize : pm_last_name << "(non fourni)"
  end
  result = pm_first_name.zip(pm_last_name, pm_email)
  result.map! { |e| ["First Name", "Last Name", "Email"].zip(e).to_h }
  return result
end

def perform
  get_PM_url
  puts "Les adresses mails des député.e.s sont : #{get_PM_email}"
end

perform
