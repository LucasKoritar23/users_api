
class User < ApplicationRecord
  def check_user(user_params)
    errors = []

    if user_params["name"].nil? or user_params["name"] == ""
      error =  "Nome não pode ser nulo ou em branco" 
      errors << error
    end

    if user_params["email"].nil? or user_params["email"] == ""
      error = "Email não pode ser nulo ou em branco" 
      errors << error
    end

    unless valid_email(user_params) 
      error = "Email inválido"
      errors << error
    end

    if user_params["age"].nil? or user_params["age"] == ""
      error = "Idade não pode ser nula ou em branco" 
      errors << error
    end

    if check_age_int(user_params["age"]) == false or user_params["age"].class == String
      error = "Idade deve ser númérica" 
      errors << error
    elsif user_params["age"] < 18
      error = "Idade deve ser superior ou igual a 18 anos"
      errors << error
    end

    begin
      if user_params["name"].length > 120
        error = "O campo nome deve possuir no máximo 120 caracteres"
        errors << error
      elsif user_params["name"].length <= 2
        error = "O campo nome deve possuir no mínimo 3 caracteres"
        errors << error
      end
    rescue NoMethodError
      error = "O campo nome deve ser string"
      errors << error
    end

    begin 
      if user_params["email"].length > 120
        error = "O campo email deve possuir no máximo 120 caracteres"
        errors << error
      end
    rescue NoMethodError
        error = "Email deve ser string"
        errors << error
    end


    if user_params["age"].to_s.length > 3
      error = "o campo idade deve possuir no máximo 3 caracteres"
      errors << error
    end

    if check_already_exists(user_params) != []
      error = "Já existe um usuário criado com este email"
      errors << error
    end

    if errors != []
      final_error = default_error
      final_error[:total_errors] = errors.count
      final_error[:errors] = errors
      return final_error
    end
  end

  def default_error
    {"transaction_uuid": SecureRandom.uuid}
  end

  def check_age_int(age)
    Integer(age) rescue false
  end

  def check_already_exists(user_params)
    db = Db.new
    query = "SELECT * FROM users WHERE email = '#{user_params["email"]}'"
    result_query = db.select(query)
  end

  def valid_email(user_params)
    begin
      return user_params["email"].match?('[a-z0-9]+[_a-z0-9\.-]*[a-z0-9]+@[a-z0-9-]+(\.[a-z0-9-]+)*(\.[a-z]{2,4})')
    rescue NoMethodError
      return false
    end
  end
end
