class MessagesController < ApplicationController
  before_action :require_user

  def create
    # El metodo "current_user" nos da el usuario actualmente logueado, a quien va a pertenecer
    # el nuevo mensaje de chat que aqui estamos recibiendo desde la pagina web.
    # Como a nivel de Model y DB tenemos vinculados User y Message en una relacion 1 a n,
    # cada "user" tendra accesible como atributo una coleccion de "messages", que es lo que
    # aqui se usa para de un solo paso crear un nuevo mensaje de chat en memoria/DB y que ya sea
    # de. usuario logueado, en un solo paso de codigo.-
    #
    new_message = current_user.messages.build(message_params)

    # Si no hubo problemas al grabar el mensaje, simpemente se refresca la pagina para que se
    # despliegue en la caja de chats.-
    #
    if new_message.save
      # redirect_to root_path
      ActionCable.server.broadcast "chatroom_channel", { message: message_render(new_message) } 
    end
  end

  private

  def message_params
    params.require(:message).permit(:body) 
  end

  # Este metodo hace el render de una vista parcial, desde el CONTROLADOR (y no desde otra vista!)
  # El partial que queremos ejecutar es el "message" (/views/messages/_message.html.erb) que es
  # el que formatea la linea de mensaje de chat a partir de un objeto Message que le pasamos
  # por memoria en la variable @message, y crea la linea "Usuario en Italica + : + Mensaje ingresado"
  #
  # En definitiva si lo invocamos aqui por su nombre mediante el metodo "render()" y le pasamos
  # el objeto Message recien creado en la accion "create" de este mismo controller (ver arriba)
  # lo que vamos a recibir es un render HTML en memoria con el mensaje formateado para luego
  # poder pasarselo 'as is' (o sea directo en HTML) a la caja de chats mediante un "append()" 
  # de Javascript!!!
  #
  def message_render(my_message)
    render(partial: 'message', locals: {message: my_message})
  end
end