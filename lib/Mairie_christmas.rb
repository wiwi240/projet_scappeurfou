require"nokogiri"
require"open-uri"

def get_townhall_email(townhall_url) 
page = Nokogiri::HTML(URI.open(townhall_url))

# On utilise 'mairie' au lieu de 'liste_mairie' pour correspondre au puts plus bas
mairie = page.xpath('//h1').text 

# On utilise 'adress_email' au lieu de 'liste_adresse_mail'
adress_email = page.xpath('//*[@id="contentContactEmail"]/span[2]/a').text

resultat = { mairie => adress_email }

# Maintenant, Ruby va trouver 'mairie' et 'adress_email' sans problème
puts "la mairie #{mairie} a pour adresse email : #{adress_email}"
return resultat

end