class CreateCasaAdminService
  def initialize(current_organization, params)
    @current_organization = current_organization
    @params = params
  end

  def build
    processed_params = CasaAdminParameters.new(@params)
      .with_password(SecureRandom.hex(10))
      .with_organization(@current_organization)
      .without(:active, :type)
    @casa_admin = CasaAdmin.new(processed_params)
  end

  def create!
    @casa_admin.save!
    @casa_admin.invite!
    @casa_admin
  end
end
