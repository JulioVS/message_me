class MessagesController < ApplicationController
  before_action :require_user

  def create
    # El metodo "current_user" nos da el usuario actualmente logueado, a quien va a pertenecer
    # el nuevo mensaje de chat que aqui estamos recibiendo desde la pagina web.
    # Como a nivel de Model y  DB tenemos vinculados User y Message en una relacion 1 a n,
    # cada "user" tendra accesible como atributo una coleccion de "messages", que es lo que
    # aqui se usa para de un solo paso crear un nuevo mensaje de chat en memoria/DB y que ya sea
    # de. usuario logueado, en un solo paso de codigo.-
    #
    message = current_user.messages.build(message_params)

    # Si no hubo problemas al grabar el mensaje, simpemente se refresca la pagina para que se
    # despliegue en la caja de chats.-
    #
    if message.save
      # redirect_to root_path
      ActionCable.server.broadcast "chatroom_channel", { foo: message.body }   
    end
  end

  private

  def message_params
    params.require(:message).permit(:body) 
  end
end