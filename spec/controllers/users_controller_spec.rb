require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'post #create' do
    before(:each) do
      create(:user)
      allow(subject).to receive(:current_user).and_return(User.last)
    end

    context 'With valid user params' do
      before(:each) do
        post :create, params: { user: {username: 'Johnny Apple', password: 'password'}}
      end

      it 'valid params' do 
        expect(user.username).to eq('Johnny Apple')
        expect(user.password).to eq('password')
      end

      it 'redirects_to user show page' do 
        expect(response).to redirects_to(user_url(user))
      end
    end

    context 'With invalid user params' do

      before(:each) do
        post :create, params: { user: {username: 'Johnny Wrong', password: 'wrong_password'}}
      end

      it 'invalid params' do 
        expect(user.username).to_not eq('Johnny Apple')
        expect(user.password).to_not eq('password')
      end

      it 'renders to new session' do
        expect(response).to render_template(:new)
        expect(flash.now[:errors]).to be_present 
      end
    end
  end

  describe 'GET #new' do
    
    it 'renders to make new user' do
      expect(response).to render_template(:new)
    end
  end

end
