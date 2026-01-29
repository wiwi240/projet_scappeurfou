require_relative '../lib/mairie_christmas'

describe "La méthode get_townhall_email" do
  # On teste avec Avernes comme demandé dans l'énoncé
  let(:townhall_url) { "https://lannuaire.service-public.gouv.fr/ile-de-france/val-d-oise/mairie-95040-01" }

  it "doit retourner un Hash" do
    expect(get_townhall_email(townhall_url)).to be_a(Hash)
  end

  it "doit retourner un email valide" do
    result = get_townhall_email(townhall_url)
    # Vérifie que la valeur du hash contient un "@"
    expect(result.values.first).to include("@")
  end
end

