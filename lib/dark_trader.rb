require 'nokogiri'
require 'open-uri'

def get_crypto_data
  # 1. DEFINITION DE LA SOURCE
  # On stocke l'adresse du site dans une variable pour plus de clarté.
  url = "https://coinmarketcap.com/all/views/all/"
  
  # 2. CAPTURE DU HTML
  # URI.open(url) télécharge la page.
  # Nokogiri::HTML(...) transforme ce téléchargement en un objet structuré (DOM) que Ruby peut fouiller.
  page = Nokogiri::HTML(URI.open(url))

  # 3. EXTRACTION DES DONNEES BRUTES (NodeSets)
  # .xpath cherche dans l'objet 'page' tous les éléments correspondant au chemin.
  # On récupère ici des collections d'objets HTML (pas encore du texte pur).
  symbols_list = page.xpath('//td[contains(@class, "cmc-table__cell--sort-by__symbol")]')
  prices_list = page.xpath('//td[contains(@class, "cmc-table__cell--sort-by__price")]')

  # 4. INITIALISATION DU CONTENEUR FINAL
  # On crée un tableau vide qui accueillera nos futurs Hashs.
  crypto_array = []

  # 5. BOUCLE DE TRAITEMENT ET D'ASSOCIATION
  # .each_with_index parcourt la liste des symboles et nous donne 'index' (0, 1, 2...) pour chaque tour.
  symbols_list.each_with_index do |symbol_node, index|
    
    # a. Nettoyage du prix :
    # .text extrait la String (ex: "$5,245.12") de l'objet HTML.
    # .delete enlève les caractères gênants.
    # .to_f convertit le texte restant en nombre décimal (Float).
    clean_price = prices_list[index].text.delete("$").delete(",").to_f
    
    # b. Création du Hash :
    # On crée une paire { "NOM" => PRIX }
    crypto_hash = { symbol_node.text => clean_price }
    
    # c. Stockage :
    # L'opérateur << ajoute le petit hash dans le grand tableau.
    crypto_array << crypto_hash
    
    # d. Feedback (Effet Hacker) :
    # Affiche l'avancement dans le terminal pendant l'exécution.
    puts "#{symbol_node.text} => #{clean_price}"
  end

  # 6. RETOUR DE LA METHODE
  # En Ruby, la dernière ligne évaluée est renvoyée par la méthode.
  crypto_array
end