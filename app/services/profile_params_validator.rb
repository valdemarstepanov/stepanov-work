class ProfileParamsValidator

  attr_reader :errors

  def initialize(params)
    @errors = []
    @params = params
  end
  
  def valid?
    validate
    @errors.empty?
  end

  def validate
    if @params[:profile][:grade_id].present? ||
      @params[:profile][:grade_attributes][:name].present? && @params[:profile][:grade_attributes][:level].present?
    else
      @errors << "Grade is not selected or set"
    end

    if @params[:profile][:speciality_id].present? || @params[:profile][:speciality_attributes][:name].present?
    else
      @errors << "Speciality is not selected or set"
    end

    if @params[:profile][:user_attributes][:email].present? &&
      @params[:profile][:user_attributes][:password].present? &&
      @params[:profile][:user_attributes][:password_confirmation].present?
    else
      @errors << "User params not set"
    end

    if @params[:profile][:first_name].present? &&
      @params[:profile][:last_name].present?
    else
      @errors << "Profile params not set"
    end
  end
end
