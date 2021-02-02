
class ScraperFanatical

  def extraerAuxiliar(url)
    pagina = open(url)
    contenido = pagina.read
    parsed = Nokogiri::HTML(contenido)
    nombre = parsed.css(".w-100").css("h1.product-name").inner_text
    descripcion = parsed.css(".section-margin-bottom.product-description").css("p")[0]

    if (descripcion != nil)
      descripcion = descripcion.inner_text
    else
      descripcion = ""
    end

    precio = parsed.css(".p-3.pl-md-1.pl-lg-3.card-body").css(".price-container").css(".price").css("span").inner_text
    descuento = parsed.css(".saving-percentage").inner_text
    descuento = descuento.slice(1..-1)
    imagen = parsed.css(".responsive-image.responsive-image--16by9").css("img.img-fluid.img-full.card-img-top")

    if (imagen == nil)
      imagen = imagen.attribute("src")
    else
      imagen = ""
    end

    gamedetails = parsed.css(".mb-4.p-3.product-details.card").css(".card-body").css(".game-details").css(".row.product-details")

    origen = ""
    publisher = ""
    desarrollador = ""
    fechaLanzamiento = ""

    for i in 0..gamedetails.length
      etiqueta = gamedetails.css("dt.col-sm-3.col-md-4")[i]
      if (etiqueta != nil)
        if(etiqueta.inner_text == "Platform:")
          origen = gamedetails.css("dd.col-sm-9.col-md-8")[i].inner_text
        end
        if(etiqueta.inner_text == "Publisher:")
          publisher = gamedetails.css("dd.col-sm-9.col-md-8")[i].inner_text
        end
        if(etiqueta.inner_text == "Developer:")
          desarrollador = gamedetails.css("dd.col-sm-9.col-md-8")[i].inner_text
        end
        if(etiqueta.inner_text == "Release Date:")
          fechaLanzamiento = gamedetails.css("dd.col-sm-9.col-md-8")[i].inner_text
        end
      end
    end

    juego = Juego.new(nombre,descuento,precio,"","","",imagen,descripcion,
                      fechaLanzamiento,"","","",desarrollador,"",
                      "",origen,"",publisher)
    #juego.toString
    juego.registrarFanatical
    puts nombre, precio, descuento, imagen

  end


  def extraer(url, link)
    card = open(url)
    info = card.read
    parsed = Nokogiri::HTML(info)
    data = parsed.css("a.faux-block-link__overlay-link").each do |href|
      arr = (href.attribute("href").value).split("/")
      if(arr[2] == "game")
        extraerAuxiliar(link + href.attribute("href").value)
      end
    end
  end


  def crearArchivoJuegos()
    CSV.open('Graficos/juegosFanatical.csv', 'wb') do |csv|
      csv << %w[nombre precio descuento origen desarrollador fechaLanzamiento imagen descripcion publisher]
    end
  end

end
'''
for i in 1..5
  url = $link + "/en/search?page=" + i.to_s + "&types=game"
  extraer(url, $link)
end
'''