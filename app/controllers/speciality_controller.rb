class SpecialityController < ApplicationController
  
    def index
    end

    def create
        @speciality = Speciality.create(speciality_params)
    end

    private

    def speciality_params
        params.require(:speciality).permit(:id, :name)
    end
end
