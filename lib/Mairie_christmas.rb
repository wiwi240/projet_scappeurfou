require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)
  begin
    # On ajoute des headers plus complets pour "humaniser" la requête
    options = {
      "User-Agent" => "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36",
      "Accept" => "text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,*/*;q=0.8",
      "Accept-Language" => "fr,fr-FR;q=0.8,en-US;q=0.5,en;q=0.3"
    }

    # On ouvre la page
    html = URI.open(townhall_url, options)
    page = Nokogiri::HTML(html)
    
    # On récupère le nom (souvent dans un h1)
    city_name = page.css('h1').text.strip
    
    # On cherche l'email dans le texte de la page qui ressemble à un email
    # C'est souvent plus fiable que le XPath quand le JS bloque les balises <a>
    email = page.to_s.match(/[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}/i).to_s

    return { city_name => email }
  rescue
    return nil
  end
end

def get_townhall_urls
  base_url = "https://lannuaire.service-public.gouv.fr"
  vdo_url = "https://lannuaire.service-public.gouv.fr/navigation/ile-de-france/val-d-oise/mairie"
  
  # Pareil ici, on met le User-Agent
  page = Nokogiri::HTML(URI.open(vdo_url, "User-Agent" => "Mozilla/5.0"))
  urls = []
  
  page.css('main ul li a').each do |link|
    href = link['href']
    urls << (href.start_with?("http") ? href : base_url + href)
  end
  return urls.uniq
end

def show_progress(current, total)
  percent = (current.to_f / total * 100).to_i
  bar = "█" * (percent / 5) + "-" * (20 - (percent / 5))
  print "\r|#{bar}| #{percent}% (#{current}/#{total} mairies)"
end

def perform
  final_data = []
  puts "1. Récupération des URLs..."
  urls = get_townhall_urls
  
  limit = 20
  target_urls = urls[0..(limit - 1)]
  
  puts "2. chargement des donnée en cours :"
  
  target_urls.each_with_index do |url, index|
    data = get_townhall_email(url)
    final_data << data if data && data.values.first != ""
    
    show_progress(index + 1, limit)
    
    # TRÈS IMPORTANT : On attend 0.5 seconde entre chaque mairie
    # Ça évite de se faire bannir pour "vitesse suspecte"
    sleep(0.5)
  end

  puts "\n\n✅ Terminé ! Voici les données :"
  p final_data
  return final_data
end

perform