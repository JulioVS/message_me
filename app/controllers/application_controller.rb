class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def current_user
    # El significado de ||= en Ruby/Rails es:
    #
    # Si la variable de la izquierda no esta definida (es decir aun no existe en memoria)
    # o tiene un valor nulo, entonces evaluo la expresion de la derecha y le asigno
    # su resultado a la variable.-
    #
    # Si la variable de la izquierda ya existe y no tiene valor nulo, entones no hago nada
    # (o sea la variable conserva su valor anterior a esta sentencia y sigue de largo)
    #
    @current_user ||= User.find(session[:user_id]) if session[:user_id] 
  end

  def logged_in?
    # La doble negacion hace que este metodo siempre devuelva un valor booleano, 
    # haya o no un usuario cargado en @current_user.
    # En el caso de que efectivamente haya usuario logueado, queremos que devuelva "true"
    # y NO el usuario logueado en si.-
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:error] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
end
