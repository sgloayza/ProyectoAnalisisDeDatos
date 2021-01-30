
class ScraperFanatical


  def extraerDatosJuegos(url)
    pagina = open(url)
    contenido = pagina.read
    parsed = Nokogiri::HTML(contenido)
    parsed.css(".card-container").each do |datos|

      href = "https://www.fanatical.com"+datos.css(".faux-block-link__overlay-link").attribute("href").value.to_s

      nombre = datos.css(".faux-block-link__overlay-link").inner_text

      #puts href+" "+nombre

      descuento = (datos.css(".card-saving").css("div").inner_text.gsub(/\s+/,"").gsub("Hasta", "").gsub("-", "").split("%")[0].to_i).to_s+"%"



      paginaJuego = open(href)
      contenidoJuego = paginaJuego.read
      parsedJuego = Nokogiri::HTML(contenidoJuego)

      precio = (parsedJuego.css(".price-container").css(".was-price").inner_text.gsub("£","").to_i* 1.37121).round(2)


      plataformas = ""
      parsedJuego.css(".platforms-container").css(".svg-inline--fa").each do |p|
        platf = p.attribute("data-icon").to_s
        if platf=="windows" then
          plataformas+="windows "
        end
        if platf=="apple" then
          if plataformas=="" then
            plataformas+="mac "
          else
            plataformas+="/ mac"
          end
        end
        if platf=="linux" then
          if plataformas=="" then
            plataformas+="linux "
          else
            plataformas+="/ linux"
          end
        end


      end



      descripcion = parsedJuego.css(".section-margin-bottom").css("p").inner_text



      imagen = parsedJuego.css(".responsive-image").css("img").attribute("srcset").to_s.split(" ")[0]

      if precio!=0 then           #si no tiene precio, no es juego

        origen = parsedJuego.css(".drm-container").css("img").attribute("alt").value.to_s.split(" ")[0]



        genero= Set[]
        parsedJuego.css(".card-body").css(".col-sm-9").css(".text-capitalize").css("a").each do |g|
          genero.add(g.inner_text.to_s)
        end
        generos = ""
        genero.each do |gen|
          if generos=="" then
            generos+=gen
          else
            generos+=" / "+gen
          end
        end

        juego=Juego.new(nombre,descuento,precio.to_s,plataformas,generos,href,imagen,descripcion,
                      "","","","","","",
                      "",origen)
        juego.toString
        juego.registrarFanatical

      end

    end

  end


  def crearArchivoJuegos()
    CSV.open('Graficos/juegosFanatical.csv', 'wb') do |csv|
      csv << %w[nombre descuento precio plataformas origen genero href imagen descripcion]
    end
  end


end

