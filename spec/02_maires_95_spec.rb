require_relative '../lib/02_maires_95.rb'

describe "the get_city_names method" do
  it "should include all cities in Val D'oise" do
    expect(get_city_names).to include("GROSLAY")
    expect(get_city_names).to include("MOUSSY")
  end
end

describe "the get_townhall_url method" do
  it "should include correct URLs" do
    expect(get_townhall_url).to include("http://annuaire-des-mairies.com/95/fosses.html")
  end
end