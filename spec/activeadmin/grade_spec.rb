RSpec.describe GradeController, type: :controller do
    let(:grade) { create :grade }
    
    before { sign_in user }
  
    describe 'Grade create' do
      
      it 'creates an institution' do
        post :create, institution: { name: "test_name", email: "test@email.com" }
        expect(Institution.all.count).to eq(1)
      end

    end
  end
