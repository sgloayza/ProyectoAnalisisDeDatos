
class Juego
  attr_accessor :nombre, :imagen, :descuento, :precio, :href, :fechaLanzamiento, :plataformas, :resenia, :bloqueoDeEdad, :descripcion, :etiquetas, :desarrollador, :editor, :genero,:metacritic,:origen


  def initialize(nombre,descuento,precio,plataformas,genero,href,imagen,descripcion,
                 fechaLanzamiento="",resenia="",bloqueoDeEdad="",etiquetas="",
                 desarrollador="",editor="",metacritic="",origen="")
    @nombre = nombre
    @descuento = descuento
    @precio = precio
    @plataformas = plataformas
    @genero = genero
    @href=href
    @imagen = imagen
    @descripcion=descripcion
    @fechaLanzamiento=fechaLanzamiento
    @resenia=resenia
    @bloqueoDeEdad=bloqueoDeEdad
    @etiquetas=etiquetas
    @desarrollador=desarrollador
    @editor=editor
    @metacritic = metacritic
    @origen = "Steam"
  end


  def registrarSteam()
    CSV.open('juegosSteam.csv','a') do |csv|
      csv << [@nombre,@descuento,@precio,@fechaLanzamiento,@plataformas,@resenia,@bloqueoDeEdad,@etiquetas,@desarrollador,@editor,@genero,@metacritic,@href,@imagen,@descripcion]
    end
  end


  def registrarFanatical()
    CSV.open('juegosFanatical.csv','a') do |csv|
      csv << [@nombre,@descuento,@precio,@plataformas,@origen,@genero,@href,@imagen,@descripcion]
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
           "\nMetacritic= "+@metacritic+
           "\nOrigen= "+@origen
  end


end
