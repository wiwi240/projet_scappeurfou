require "nokogiri"
require "open-uri"

# MÉTHODE 1 : Récupérer l'e-mail d'UNE seule mairie (Ton code déjà testé !)
def get_townhall_email(townhall_url)
    page = Nokogiri::HTML(URI.open(townhall_url))
    mairie = page.xpath('//h1').text
    email = page.xpath('//*[@id="contentContactEmail"]/span[2]/a').text

    return { mairie => email }
end