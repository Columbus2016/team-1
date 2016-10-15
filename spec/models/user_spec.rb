RSpec.describe User, type: :model do
  describe "creation" do

  end

  describe "visibility" do
    let(:visible) { create(:user, invisible: false) }
    let(:invisible) { create(:user, invisible: true) }
    it "has a scope for visible users" do
      expect(User.visible).to contain_exactly(visible)
    end

    it "has a scope for invisible users" do
      expect(User.invisible).to contain_exactly(invisible)
    end
  end
end
