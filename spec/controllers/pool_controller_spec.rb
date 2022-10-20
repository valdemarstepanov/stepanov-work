require 'rails_helper'

RSpec.describe PoolsController, type: :controller do
  let(:user) { create :user }
  let(:grade) { create :grade }
  let(:speciality) { create :speciality }
  let(:profile) { create :profile, user_id: user.id, grade_id: grade.id, 
  speciality_id: speciality.id }

  before { sign_in user }

  describe '#index' do
    subject { process :index }
    
    it 'render index template' do
      subject
      expect(response).to render_template :index
    end
  end

  describe '#create' do
    subject { process :create, method: :post, params: params }

    context 'when params is valid' do
      let(:params) { { pool: attributes_for(:pool, profile_id: profile.id) } }

      it 'creates a post' do
        expect { subject }.to change(Pool, :count).by(1)
      end

      it 'redirect to post path' do
        subject
        expect(response).to redirect_to root_path
      end

      it 'assigns post to current user' do
        subject
        expect(assigns(:pool).profile).to eq profile
      end
    end

    context 'when params is invalid' do
      let(:params) { { pool: attributes_for(:pool, type: "Manager") } }

      it 'doesnt create a post' do
        expect { subject }.not_to change(Pool, :count)
      end

      it 'dont redirect to post path' do
        expect(subject).to redirect_to new_pool_path
      end
    end
  end

  describe "#destroy" do
    let!(:pool) { create :pool, profile_id: profile.id }

    subject { process :destroy, method: :delete, params: { id: pool.id } }
    
    it 'unlikes post' do
      expect { subject }.to change(Pool, :count).by(-1)
    end
  end
end
