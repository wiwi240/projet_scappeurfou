require_relative '../lib/Mairie_christmas' # On pointe vers ton fichier de code

describe "La méthode get_townhall_email" do
# On définit une URL de test (une mairie qui existe vraiment)
let(:townhall_url) { "https://lannuaire.service-public.gouv.fr/ile-de-france/val-d-oise/mairie-95039-01" }

it "devrait retourner un Hash" do
expect(get_townhall_email(townhall_url)).to be_a(Hash)
end

it "devrait retourner un email valide (contenant un @)" do
# On récupère la valeur du hash (l'email)
result = get_townhall_email(townhall_url)
expect(result.values.first).to include("@")
end

it "ne devrait pas retourner un résultat vide" do
expect(get_townhall_email(townhall_url)).not_to be_nil
end
end