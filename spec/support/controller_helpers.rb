module ControllerHelpers
  #хелпер для операции аунтификации пользователя в тестах контроллеров
  def login(user)
    @request.env['devise.mapping'] = Devise.mappings[:user] #указываем Devise, что нужно работать с моделью User
    sign_in user
  end
end
