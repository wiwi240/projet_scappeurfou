require_relative '../lib/mairie_christmas'

describe "Scraping Val d'Oise" do
  it "returns an array of URLs" do
    urls = get_townhall_urls
    expect(urls).to be_a(Array)
    expect(urls.length).to be >= 20 
  end

  it "extracts an email containing @" do
    # On utilise Ableiges, beaucoup plus stable pour les tests RSpec
    sample_url = "https://lannuaire.service-public.gouv.fr/ile-de-france/val-d-oise/mairie-95002-01"
    result = get_townhall_email(sample_url)
    
    # On vérifie que le résultat n'est pas nul et contient un @
    expect(result).not_to be_nil
    expect(result.values.first).to include("@")
  end
end