require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "validation" do
    it "requies a shout" do
      expect(build(:comment, shout: nil)).to_not be_valid
    end
  end
end
