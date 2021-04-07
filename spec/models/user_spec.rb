# == Schema Information
#
# Table name: users
#
#  id              :bigint           not null, primary key
#  username        :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_length_of(:password).is_at_least(6)}
  end

  describe '::find_by_credentials' do
    before{user.save!}
    context 'when valid credentials was given' do

      it 'return valid user credentials' do 
        expect(User.find_by_credentials("Johnny Apple", "password")).to eq(user)
      end

    end

    context 'when invalid credential was given' do
      it 'returns nil' do 
        expect(User.find_by_credentials("Johnny Apple", "wrong_password")).to eq(nil)
      end
    end

  end

  describe '#is_password?' do
    context 'Checks password' do
      it 'verifies if the password is correct' do
        expect(User.is_password?('password')).to be true
      end
    end

    context 'Checks for wrong password' do
      it 'verifies if the password is incorrect' do
        expect(User.is_password?('wrongpassword')).to be false
      end
    end
  end

  describe '#reset_session_token' do
    context 'Starts a session' do
      it 'sets session token for user' do
        current_session_token = user.session_token
        user.reset_session_token
        expect(user.session_token).to_not eq(current_session_token)
      end

      it 'returns a new session token' do
        expect(user.reset_session_token).to eq(user.session_token)
      end
    end
  end
end
