require 'rails_helper'

RSpec.describe PoolsController, type: :controller do
  let(:user) { create :user }
  let(:grade) { create :grade }
  let(:speciality) { create :speciality }
  let(:profile) { create :profile, user: user, grade: grade, 
  speciality: speciality }

  before { sign_in user }

  describe '#index' do
    subject { process :index }
    
    it 'manager render index template' do
      subject
      expect(response).to render_template :index
    end
  end

  describe '#create' do
    subject { process :create, method: :post, params: params }

    context 'when params is valid' do
      let(:params) { { pool: attributes_for(:pool, profile_id: profile) } }

      it 'creates a pool' do
        user.add_role :manager
        expect { subject }.to change { Pool.count }.by(1)
      end

      it 'redirect to poot path' do
        subject
        expect(response).to redirect_to root_path
      end

      it 'assigns pool to current user' do
        subject
        expect(assigns(:pool).profile).to eq profile
      end
    end

    context 'when params is invalid' do
      let(:params) { { pool: attributes_for(:pool, type: "Manager") } }

      it 'doesnt create a pool' do
        expect { subject }.not_to change { Pool.count }
      end

      it 'dont redirect to pool path' do
        expect(subject).to redirect_to root_path
      end
    end

    context 'check policies' do
      let(:params) { { pool: attributes_for(:pool, profile_id: profile, type: "Employee") } }

      it 'manager create pool' do
        user.add_role :manager
        expect { subject }.to change { Pool.count }.by(1)
        expect(subject).to redirect_to root_path
      end

      it 'user try create pool' do
        user.add_role :user
        expect { subject }.not_to change { Pool.count }
        expect(subject).to redirect_to root_path
      end
    end
  end

  describe "#destroy" do

    context 'destroy pool' do

      let!(:pool) { create :pool, profile: profile }

      subject { process :destroy, method: :delete, params: { id: pool.id } }
      
      it 'delete pool' do
        user.add_role :manager
        expect { subject }.to change { Pool.count }.by(-1)
      end

    end

    context 'check policies' do
      let!(:pool) { create :pool, profile: profile }

      subject { process :destroy, method: :delete, params: { id: pool.id } }

      it 'manager destroy pool' do
        user.add_role :manager
        expect { subject }.to change { Pool.count }.by(-1)
        expect(subject).to redirect_to root_path
      end

      it 'user try destroy pool' do
        user.add_role :user
        expect { subject }.not_to change { Pool.count }
        expect(subject).to redirect_to root_path
      end
    end
  end
end
