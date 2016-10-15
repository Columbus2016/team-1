FactoryGirl.factories.map(&:name).each do |fname|
  RSpec.describe "The #{fname} factory" do
    it "is valid" do
      expect(create(fname)).to be_valid
    end
  end
end
