require_relative '../lib/03_deputes.rb'

describe "the get_PM_url method" do
  it "should return all French PM's pages' URLs" do
    expect(get_PM_url).not_to be_nil
    expect(get_PM_url).to have_attributes(size: (be > 500))
  end
end

