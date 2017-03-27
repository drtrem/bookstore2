require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validates' do

    it "validates the user first_name it's not emty" do
      user = User.new(first_name: '')
      user.save
      user.valid?
      expect(user.errors[:first_name]).to eq(["can't be blank", "only allows letters"])
    end
  end

  describe 'roles' do
    it 'admin' do
      user = User.new(role: 'admin')
      expect(user.admin?).to be_truthy
    end

    it 'not admin' do
      expect(subject.admin?).to be_falsey
    end

    it 'guest' do
      allow(subject).to receive(:guest_token) { true }
      expect(subject.is_guest?).to be_truthy
    end

    it 'not guest' do
      expect(subject.is_guest?).to be_falsey
    end

    it 'create by token increases User' do
      expect{User.create_by_token}.to change {User.count}.by(1)
    end

    it 'set fake password changes password' do
      expect{subject.set_fake_password}.to change { subject.password }
    end
  end
end
