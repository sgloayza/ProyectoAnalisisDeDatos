
class Juego
  attr_accessor :nombre, :imagen, :descuento, :precio, :href, :fechaLanzamiento, :plataformas, :resenia, :bloqueoDeEdad, :descripcion, :etiquetas, :desarrollador, :editor, :genero,:metacritic,:origen,:usuarioCompraron


  def initialize(nombre,descuento,precio,plataformas,genero,href,imagen,descripcion,
                 fechaLanzamiento="",resenia="",bloqueoDeEdad="",etiquetas="",
                 desarrollador="",editor="",metacritic="",origen="Steam",usuarioCompraron="")
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
    @editor= editor
    @metacritic = metacritic
    @origen = origen
    @usuarioCompraron = usuarioCompraron
  end


  def registrarSteam()
    CSV.open('Graficos/juegosSteam.csv','a') do |csv|
      csv << [@nombre,@descuento,@precio,@fechaLanzamiento,@usuarioCompraron,@plataformas,@resenia,@bloqueoDeEdad,@etiquetas,@desarrollador,@editor,@genero,@metacritic,@href,@imagen,@descripcion]
    end
  end


  def registrarFanatical()
    CSV.open('Graficos/juegosFanatical.csv','a') do |csv|
      csv << [@nombre,@descuento,@precio,@plataformas,@origen,@genero,@href,@imagen,@descripcion]
    end
  end


  def registrarEneba()
    CSV.open('Graficos/juegosEneba.csv','a') do |csv|
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
           "\nOrigen= "+@origen+
           "\n@UsuarioCompraron= "+@usuarioCompraron
  end


end
