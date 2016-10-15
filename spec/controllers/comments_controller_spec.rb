require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  context "when logged in" do
    let(:shout) { create(:shout) }
    before(:each) do
      @user = create(:user)
      sign_in @user
    end

    describe "post #create" do
      let(:comment_params) do
        {comment: attributes_for(:comment).merge(shout_id: shout.id)}
      end

      it "creates a comment on the post" do
        expect do
          post :create,
            params: comment_params
        end.to change{Comment.count}.by(1)
      end

      it "creates a comment on the post" do
        expect do
          post :create,
            params: comment_params
        end.to change{shout.comments.reload.count}.by(1)
      end

      it "creates a comment for the user" do
        expect do
          post :create,
            params: comment_params
        end.to change{@user.comments.reload.count}.by(1)
      end
    end
  end
end
