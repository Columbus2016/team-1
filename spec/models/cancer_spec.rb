require 'rails_helper'

RSpec.describe Cancer, type: :model do
  describe "validation" do
    it "doesn't allow null" do
      expect do
        create(:cancer, name: nil)
      end.to raise_error(ActiveRecord::StatementInvalid)
    end
  end

end
