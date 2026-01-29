require"nokogiri"
require "httparty"
require "open-uri"

def get_crypto_data
  # Cette URL charge la vue d'ensemble complète
  url = "https://coinmarketcap.com/all/views/all/"
  page = Nokogiri::HTML(URI.open(url))

  # XPaths précis pour la structure du tableau complet
  symbols_list = page.xpath('//td[contains(@class, "cmc-table__cell--sort-by__symbol")]')
  prices_list = page.xpath('//td[contains(@class, "cmc-table__cell--sort-by__price")]')

  crypto_final_array = []

  symbols_list.each_with_index do |symbol_node, index|
    symbol = symbol_node.text
    price = prices_list[index].text.delete("$").delete(",").to_f
    
    crypto_final_array << { symbol => price }
    puts "Récupéré : #{symbol} => #{price}"
  end

  crypto_final_array
end