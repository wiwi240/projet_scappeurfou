# Importation des bibliothèques nécessaires
require "nokogiri"   # Pour analyser (parser) le HTML
require "open-uri"   # Pour ouvrir une URL comme un fichier local
require "httparty"   # (Optionnel ici car on utilise open-uri pour la connexion)

def get_crypto_data
  # 1. Définition de la source
  url = "https://coinmarketcap.com/all/views/all/"
  
  # 2. Capture du contenu HTML
  # URI.open télécharge la page, Nokogiri l'organise en un objet explorable
  page = Nokogiri::HTML(URI.open(url))

  # 3. Extraction des données cibles via XPath
  # On récupère deux "NodeSets" (sortes de listes) contenant les balises HTML correspondantes
  symbols_list = page.xpath('//td[contains(@class, "cmc-table__cell--sort-by__symbol")]')
  prices_list = page.xpath('//td[contains(@class, "cmc-table__cell--sort-by__price")]')

  # 4. Initialisation du contenant final
  # On prépare un tableau vide pour y stocker nos futurs Hashs
  crypto_final_array = []

  # 5. Boucle de traitement et d'assemblage
  # On parcourt la liste des symboles, 'index' permet de retrouver le prix correspondant
  symbols_list.each_with_index do |symbol_node, index|
    
    # Extraction du texte pur de la balise symbole
    symbol = symbol_node.text
    
    # Nettoyage du prix : on retire les symboles monétaires et on convertit en nombre décimal (Float)
    price = prices_list[index].text.delete("$").delete(",").to_f
    
    # Création d'un petit Hash et ajout (shovel) dans le tableau final
    crypto_final_array << { symbol => price }
    
    # Affichage en temps réel pour vérifier que le programme travaille
    puts " : #{symbol} => #{price}"
  end

  # 6. Retour de la donnée
  # La méthode renvoie le tableau complet une fois la boucle terminée
  crypto_final_array
end