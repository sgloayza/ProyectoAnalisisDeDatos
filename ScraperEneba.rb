
class ScraperEneba


  def extraerDatosJuegos(url)
    pagina = open(url)
    contenido = pagina.read
    parsed = Nokogiri::HTML(contenido)

  end


  def crearArchivoJuegos()
    CSV.open('Graficos/juegosEneba.csv', 'wb') do |csv|
      csv << %w[nombre descuento precio plataformas origen genero href imagen descripcion]
    end
  end


end

