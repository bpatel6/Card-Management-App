require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  def setup
    OmniAuth.config.mock_auth[:google]
  end
  
  describe 'create' do
    it 'successfully creates a new user' do
      user = User.create(name: 'sam', provider: 'google', uid: '12345', account_id: 12435, email: 'selt@gmail.com', encrypted_password: nil, session_token: SecureRandom.base64, role: 'owner', active_session: 654321)
      expect(User.last.name).to eq('sam')
    end
  end

  describe 'createDeck' do
    it 'successfully creates a new deck' do
      controller.createDeck(1, 'full deck', 123)
      deck = Card.where(pile_id: 123)
      expect(deck.length).to eq(52)
    end

  end

  describe 'destroy a session' do
    it 'should redirect to the session new path' do
      user = User.create(name: 'sam', provider: 'google', uid: '12345', account_id: 12435, email: 'selt@gmail.com', encrypted_password: nil, session_token: SecureRandom.base64, role: 'owner', active_session: 654321)
      get :destroy
      expect(response).to redirect_to(sessions_new_path)
    end
  end
  before :each do
    @google_hash = OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new(
        {
            'uid': '12345',
            'provider': 'google'
        }
    )
    setup
  end
  describe 'create a session' do
    it 'should call the create method' do
      fake = User.create(id: 1, role:'owner')
      expect(User).to receive(:from_omniauth).with(@google_hash).and_return(fake)
      get :create, params: {provider: 'google'}
    end
  end
end
