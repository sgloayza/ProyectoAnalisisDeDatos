
class Juego
  attr_accessor :nombre, :imagen, :descuento, :precio, :href, :fechaLanzamiento, :plataformas, :resenia, :confirmacionDeEdad, :descripcion, :etiquetas, :desarrollador, :editor, :genero



  def initialize(nombre,imagen,descuento,precio,href,fechaLanzamiento,plataformas,resenia,confirmacionDeEdad,descripcion,etiquetas,desarrollador,editor,genero)
    @nombre = nombre
    @imagen = imagen
    @descuento = descuento
    @precio = precio
    @href = href
    @fechaLanzamiento = fechaLanzamiento
    @plataformas = plataformas
    @reseñia = resenia
    @confirmacionDeEdad = confirmacionDeEdad
    @descripcion = descripcion
    @etiquetas = etiquetas
    @desarrollador = desarrollador
    @editor = editor
    @genero = genero
  end

  def registrar()
    CSV.open('juegos.csv','a') do |csv|
      csv << [@nombre,@imagen,@descuento,@precio,@href,@fechaLanzamiento,@plataformas,@resenia,@confirmacionDeEdad,@descripcion,@etiquetas,@desarrollador,@editor,@genero]
    end
  end



end
