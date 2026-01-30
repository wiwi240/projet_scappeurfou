require_relative '../lib/dark_trader'

describe "the get_crypto_data method" do
it "returns an array of hashes" do
    expect(get_crypto_data).to be_an_instance_of(Array)
    expect(get_crypto_data.all? { |i| i.is_a?(Hash) }).to be true
end

it "contains specific cryptocurrencies" do
    result = get_crypto_data
    # Vérification de la présence de clés symboles courantes
    symbols = result.map(&:keys).flatten
    expect(symbols).to include("BTC")
    expect(symbols).to include("ETH")
end

it "is not empty and has a minimum size" do
    expect(get_crypto_data.length).to be >= 20
    end
end