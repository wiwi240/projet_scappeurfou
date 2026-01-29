require 'nokogiri'
require 'httparty'

def crypto_scrapper
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/")) # 1. Ouvrir l'URL
  nom = page.xpath("//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[1]/td[2]/div/a[2]")# 2. Récupérer les noms
  price = page.xpath("//*[@id="__next"]/div[2]/div[2]/div/div[1]/div/div[2]/div[3]/div/table/tbody/tr[1]/td[5]/div/span)# 3. Récupérer les prix
  data = [nom , price]# 4. Associer les deux dans un array de hashs
end