
class Juego
  attr_accessor :nombre, :imagen, :descuento, :precio, :href, :fechaLanzamiento, :plataformas, :resenia, :bloqueoDeEdad, :descripcion, :etiquetas, :desarrollador, :editor, :genero,:metacritic



  def initialize(nombre,imagen,descuento,precio,href,fechaLanzamiento,plataformas,resenia,bloqueoDeEdad,descripcion,etiquetas,desarrollador,editor,genero,metacritic)
    @nombre = nombre
    @imagen = imagen
    @descuento = descuento
    @precio = precio
    @href = href
    @fechaLanzamiento = fechaLanzamiento
    @plataformas = plataformas
    @resenia = resenia
    @bloqueoDeEdad = bloqueoDeEdad
    @descripcion = descripcion
    @etiquetas = etiquetas
    @desarrollador = desarrollador
    @editor = editor
    @genero = genero
    @metacritic = metacritic
  end

  def registrarSteam()
    CSV.open('juegosSteam.csv','a') do |csv|
      csv << [@nombre,@descuento,@precio,@fechaLanzamiento,@plataformas,@resenia,@bloqueoDeEdad,@etiquetas,@desarrollador,@editor,@genero,@metacritic,@href,@imagen,@descripcion]
    end
  end

  def toString()
    puts "Nombre= "+@nombre+
           "\nImagen= "+@imagen+
           "\nDescuento= "+@descuento+
           "\nPrecio= "+@precio+
           "\nhref= "+@href+
           "\nFechaLanzamiento= "+@fechaLanzamiento+
           "\nPlataformas= "+@plataformas+
           "\nResenia= "+@resenia.to_s+
           "\nBloqueoDeEdad= "+@bloqueoDeEdad.to_s+
           "\nDescripción= "+@descripcion+
           "\nEtiquetas= "+@etiquetas+
           "\nDesarrollador= "+@desarrollador+
           "\nEditor= "+@editor+
           "\nGénero= "+@genero+
           "\nMetacritic= "+@metacritic
  end


end
