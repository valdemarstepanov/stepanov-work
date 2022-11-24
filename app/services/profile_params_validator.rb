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

    unless @params.dig(:profile, :grade_id).present? ||
        @params.dig(:profile, :grade_attributes, :name).present? &&
          @params.dig(:profile, :grade_attributes, :level).present?
      @errors << "Grade is not selected or set"
    end

    unless @params.dig(:profile, :speciality_id).present? ||
        @params.dig(:profile, :speciality_attributes, :name).present?
      @errors << "Speciality is not selected or set"
    end

    unless @params.dig(:profile, :user_attributes, :email).present? &&
        @params.dig(:profile, :user_attributes, :password).present? &&
          @params.dig(:profile, :user_attributes, :password_confirmation).present? &&
            @params.dig(:profile, :user_attributes, :role_ids).present?
      @errors << "User params not set"
    end

    unless @params.dig(:profile, :first_name).present? && @params.dig(:profile, :last_name).present?
      @errors << "Profile params not set"
    end

    if User.find_by(email: @params.dig(:profile, :user_attributes, :email)).present?
      @errors << "Email has already been taken"
    end
  end
end
