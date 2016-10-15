require 'rails_helper'

RSpec.describe ShoutsController, type: :controller do
  context "when logged in" do
    before(:each) do
      @user = create(:user)
      sign_in @user
    end

    describe "post #create" do
      let(:atts) { {shout: (attributes_for(:shout))} }
      it "creates a new shout" do
        expect{post :create, params: atts}.to change{Shout.count}.by(1)
      end

      it "creates a new shout under the user" do
        expect do
          post :create, params: atts
        end.to change{@user.shouts.count}.by(1)
      end
    end
  end
end
