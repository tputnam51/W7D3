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

  subject(:user) do 
    FactoryBot.build(:user,
    username: "Johnny Apple",
    password: "password")
  end

  describe 'validations' do
    it {should validate_presence_of(:username)}
    it {should validate_presence_of(:password_digest)}
    it {should validate_presence_of(:session_token)}
    it {should validate_uniqueness_of(:username)}
    it {should validate_length_of(:password).is_at_least(6)}
  end

  describe '::find_by_credentials' do

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

    context '' do

    end

    
  end

  describe '#reset_session_token' do

     context '' do
    
    end

  end
 

end
