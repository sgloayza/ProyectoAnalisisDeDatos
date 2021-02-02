require "csv"

class JuegoEneba

  #Constructor
  def initialize
    @titulo = ""
    @precio = ""
    @generos =  ""
    @plataformas = ""
    @fechaSalida = ""
    @desarrollador =  ""
    @publisher = ""
    @rating =  ""
    @valoracionUsuario = ""
    @imgCover = ""
    @link = ""
  end

  #Getters & Setters

  def titulo
    @titulo
  end

  def titulo=(titulo)
    @titulo = titulo
  end

  def precio
    @precio
  end

  def precio=(precio)
    @precio = precio
  end

  def generos
    @generos
  end

  def generos=(generos)
    @generos = generos
  end

  def plataformas
    @plataformas
  end

  def plataformas=(plataformas)
    @plataformas = plataformas
  end

  def fechaSalida
    @fechaSalida
  end

  def fechaSalida=(fechaSalida)
    @fechaSalida = fechaSalida
  end

  def desarrollador
    @desarrollador
  end

  def desarrollador=(desarrollador)
    @desarrollador = desarrollador
  end

  def publisher
    @publisher
  end

  def publisher=(publisher)
    @publisher = publisher
  end

  def rating
    @rating
  end

  def rating=(rating)
    @rating = rating
  end

  def valoracionUsuario
    @valoracionUsuario
  end

  def valoracionUsuario=(valoracionUsuario)
    @valoracionUsuario = valoracionUsuario
  end

  def imgCover
    @imgCover
  end

  def imgCover=(imgCover)
    @imgCover = imgCover
  end

  def link
    @link
  end

  def link=(link)
    @link = link
  end


  #Método de registro
  def registrar(titulo, precio, generos, plataformas, fechaSalida, desarrollador, publisher, rating, valoracionUsuario, imgCover, link)
    @titulo = titulo
    @precio = precio
    @generos =  generos
    @plataformas = plataformas
    @fechaSalida = fechaSalida
    @desarrollador =  desarrollador
    @publisher = publisher
    @rating =  rating
    @valoracionUsuario = valoracionUsuario
    @imgCover = imgCover
    @link = link
    verificarCSV
    CSV.open("Graficos/juegosEneba.csv", "ab") do |csv|
      csv << [titulo, precio, generos, plataformas, fechaSalida, desarrollador, publisher, rating, valoracionUsuario, imgCover, link]
    end
  end

  #Método verificar archivo, crear si no existe
  def verificarCSV
    if !(File.file?("juegosEneba.csv"))
      CSV.open("Graficos/juegosEneba.csv", "ab") do |csv|
        titulo = "Titulo"
        precio = "Precio"
        generos = "Generos"
        plataformas = "Plataformas"
        fechaSalida = "Fecha de Salida"
        desarrollador =  "Desarrollador"
        publisher = "Publisher"
        rating = "Rating"
        valoracionUsuario = "Valoración del usuario"
        imgCover = "Imagen"
        link = "Link"
        csv << [titulo, precio, generos, plataformas, fechaSalida, desarrollador, publisher, rating, valoracionUsuario, imgCover, link]
      end
    end
  end

end
