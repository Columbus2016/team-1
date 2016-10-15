require 'rails_helper'

describe CancerPolicy do
  PERMISSIONS = [:show?, :create?, :update?, :destroy?]
  let(:user) { create(:user) }
  let(:cancer) { create(:cancer) }
  subject { described_class }

  context "when an admin" do
    let(:user) { create(:user, authority: "admin") }
    permissions(*PERMISSIONS) do
      it "allows an admin" do
        expect(subject).to permit(user, cancer)
      end
    end
  end

  context "when a normal user" do
    let(:user) { create(:user) }
    permissions(*PERMISSIONS) do
      it "disallows normal users" do
        expect(subject).to_not permit(user, cancer)
      end
    end
  end
end
