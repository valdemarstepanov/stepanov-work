require 'rails_helper'

RSpec.describe SnapshotsController, type: :controller do
  let(:user) { create :user }

  before { sign_in user }
  
  describe '#index' do
    subject { process :index }
    
    it 'render index template' do
      subject
      expect(response).to render_template :index
    end
  end

  # describe '#show' do
  #   subject { process :show }
    
  #   it 'render show template' do
  #     subject
  #     expect(response).to render_template :show
  #   end
  # end

  # describe '#create' do
  #   subject { process :create, method: :post, params: params }

  #   context 'when params is valid' do

  #     let(:params) { { identifier: 'test' } }
  #     binding.pry
  #     it 'creates a new pool when user role has manager' do
  #       expect { subject }.to change { ActiveSnapshot::Snapshot.count }.by(1)
  #     end
  #   end
  # end

end

# ActiveSnapshot::Snapshot
