
class Scraper


  def extraerDatosEtiquetasSteam(url)
    CSV.open('Graficos/etiquetas.csv', 'wb') do |csv|
      csv << %w[nombreE html nroDeJuegos]
    end
    pagina = open(url)
    contenido = pagina.read
    parsed = Nokogiri::HTML(contenido)




    #por cada fila
    parsed.css("div#TagFilter_Container").css(".tab_filter_control_row").each do |datos|
      #nombreE html nroDeJuegos
      nombreE = datos.attribute("data-loc").value.to_s
      codigo = datos.attribute("data-value").value.to_s


      paginaFiltrada = open("https://store.steampowered.com/search/?tags="+codigo+"?sort_by=&sort_order=0&page=1")
      contenidoFiltrado = paginaFiltrada.read
      parsedFiltrado = Nokogiri::HTML(contenidoFiltrado)
      nro1 = parsedFiltrado.css(".search_results_filtered_warning").inner_text.to_s

      if nro1!="" then
        nro1 = nro1.gsub(/\s+/," ").split("results")[0].gsub(",","").to_i
      else
        nro1 = parsedFiltrado.css(".search_results").css(".search_results_count").inner_text.to_i
      end

      nro2 = parsedFiltrado.css(".search_results_filtered_warning").inner_text.to_s

      if nro2=!"" then
        nro2 = nro2.gsub(/\s+/," ").split("results")[0].gsub(",","").to_i
      else
        nro2 = 0
      end

      nroDeJuegos = (nro1+nro2).to_s

      et = Etiqueta.new(nombreE,codigo,nroDeJuegos)
      et.toString()
      et.registrar()
    end
  end



  def extraerDatosJuegosSteam(url)
    pagina = open(url)
    contenido = pagina.read
    parsed = Nokogiri::HTML(contenido)

    #por cada fila
    parsed.css("a.search_result_row").each do |datos|

      #nombre imagen descuento precio href fechaLanzamiento plataformas resenia confirmacionDeEdad
      #/descripcion /etiquetas /desarrollador /editor /genero
      nombre = datos.css("span.title").inner_text
      imagen = datos.css("img").attribute("src").inner_text
      descuento = datos.css("div.search_discount").css("span").inner_text
      if descuento=="" then
        descuento = "0"
      else
        descuento=descuento.gsub("-","")
      end

      precios = datos.css("div.search_price").inner_text.gsub(/\s+/, "")
      nroPrecios = precios.split("$").length()
      if nroPrecios==2 then
        precio = precios.split("$")[1]
      elsif nroPrecios==3 then
        precio = precios.split("$")[1]
      else
        precio = "0"
      end

      href = datos.attribute("href").value
      fechaLanzamiento = datos.css(".search_released").inner_text.gsub(",","")

      win = datos.css("p").to_s.include? "platform_img win"
      mac = datos.css("p").to_s.include? "platform_img mac"
      linux = datos.css("p").to_s.include? "platform_img linux"
      plataformas = ""
      if win then
        plataformas+="windows "
      end
      if mac then
        if plataformas=="" then
          plataformas+="mac "
        else
          plataformas+="/ mac"
        end
      end
      if linux then
        if plataformas=="" then
          plataformas+="linux "
        else
          plataformas+="/ linux"
        end
      end

      resenia = datos.css(".search_review_summary").attribute("data-tooltip-html").value.gsub("<br>"," / ").gsub(" the","").split(" user ")[0].to_s


      #por cada juego
      paginaJuego = open(href)
      contenidoJuego = paginaJuego.read
      parsedJuego = Nokogiri::HTML(contenidoJuego)
      bloqueoDeEdad = (parsedJuego.css(".apphub_AppName").inner_text != nombre)   #true si hay bloqueo

      juego=Juego.new(nombre,descuento,precio,plataformas,"",href,imagen,"",
        fechaLanzamiento,resenia,bloqueoDeEdad,"","","","","Steam")

      if !bloqueoDeEdad then
        descripcion = parsedJuego.css(".game_description_snippet").inner_text.gsub(/\s+/," ")

        juego.descripcion = descripcion

        etiquetas = ""
        parsedJuego.css(".glance_tags").css("a").each do |a|
          if a.attribute("href").value.to_s.include? "https://store.steampowered.com/tags/" then
            if etiquetas!=""
              etiquetas+="/"+a.inner_text.gsub(/\s+/," ").to_s
            else
              etiquetas+=a.inner_text.gsub(/\s+/," ").to_s
            end
          end
        end
        juego.etiquetas = etiquetas

        desarrollador = ""
        parsedJuego.css(".dev_row").css("#developers_list").css("a").each do |d|
          if desarrollador!=""
            desarrollador+=" / "+d.inner_text.to_s
          else
            desarrollador+=d.inner_text.to_s
          end
        end
        juego.desarrollador = desarrollador

        editor = ""
        parsedJuego.css(".details_block").css("a").each do |e|
          if e.attribute("href").value.to_s.include? "publisher" then
            if editor!=""
              editor+=" / "+e.inner_text.to_s
            else
              editor+=e.inner_text.to_s
            end
          end
        end
        juego.editor = editor

        genero = ""
        parsedJuego.css(".details_block").css("a").each do |g|
          if g.attribute("href").value.to_s.include? "https://store.steampowered.com/genre/" then
            if genero!=""
              genero+=" / "+g.inner_text.to_s
            else
              genero+=g.inner_text.to_s
            end
          end
        end
        juego.genero = genero

        metacritic = parsedJuego.css(".score").inner_text.gsub(/\s+/,"")
        juego.metacritic = metacritic

      end
      juego.toString
      juego.registrarSteam
    end
  end




  def extraerDatosJuegosFanatical(url)
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



  def crearArchivoJuegosSteam()
    CSV.open('Graficos/juegosSteam.csv', 'wb') do |csv|
      csv << %w[nombre descuento precio fechaLanzamiento plataformas resenia bloqueoDeEdad etiquetas desarrollador editor genero metacritic herf imagen descipcion]
    end
  end
  def crearArchivoJuegosFanatical()
    CSV.open('Graficos/juegosFanatical.csv', 'wb') do |csv|
      csv << %w[nombre descuento precio plataformas origen genero href imagen descripcion]
    end
  end



end

