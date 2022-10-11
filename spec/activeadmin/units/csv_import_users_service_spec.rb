require 'rails_helper'

RSpec.describe CsvImportUsersService do
  describe ".import" do
    it "redirects to the home page" do
      allow(Profile).to receive(:import).with("test_ok.cs")
      post :import, file: "test_ok.csv"
      expect(response).to redirect_to admin_users_path
    end





  end
end
