require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  
  describe '#index' do
    subject { process :index }
    
    it 'render index template' do
      subject
      expect(response).to render_template :index
    end
  end
end