class User < ApplicationRecord
  def check_user(user_params)
    if user_params["age"] < 18
      return {"error": true, "desc_error": {"transactionUUID": "#{SecureRandom.uuid}","error": "A idade deve ser maior que 18 anos"}}
    end


    if user_params["name"].nil?
      return {"error": true, "desc_error": {"transactionUUID": "#{SecureRandom.uuid}", "error": "Nome não pode ser nulo"}}
    end
  end
end
