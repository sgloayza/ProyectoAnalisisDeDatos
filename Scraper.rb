
class Scraper


  def extraerDatosJuegoSteam(url)
    CSV.open('juegos.csv', 'wb') do |csv|
      csv << %w[nombre imagen etiquetas descuento precio href fechaLanzamiento plataformas resenia confirmacionDeEdad descripcion etiquetas desarrollador editor enero]
    end
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
      plataformas = win.to_s+" "+mac.to_s+" "+linux.to_s

      resenia = datos.css(".search_review_summary").attribute("data-tooltip-html").value
      puts nombre+" "+imagen+" "+ descuento+" "+ precio+" "+
             href+" "+fechaLanzamiento+" "+plataformas+" "+resenia.gsub("<br>","-")



      #por cada juego
      paginaJuego = open(href)
      contenidoJuego = paginaJuego.read
      parsedJuego = Nokogiri::HTML(contenidoJuego)
      confirmacionDeEdad = (parsedJuego.css(".apphub_AppName").inner_text != nombre)   #false es qye no pide confirmacion de edad
      puts confirmacionDeEdad

      juego=Juego.new(nombre,imagen,descuento,precio,href,fechaLanzamiento,plataformas,resenia,confirmacionDeEdad,"","","","","")

      if !confirmacionDeEdad then
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
            desarrollador+="-"+d.inner_text.to_s
          else
            desarrollador+=d.inner_text.to_s
          end
        end
        juego.desarrollador = desarrollador

        editor = ""
        parsedJuego.css(".details_block").css("a").each do |e|
          if e.attribute("href").value.to_s.include? "https://store.steampowered.com/publisher/" then
            if editor!=""
              editor+="-"+e.inner_text.to_s
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
              genero+="-"+g.inner_text.to_s
            else
              genero+=g.inner_text.to_s
            end
          end
        end
        juego.genero = genero

      end

      gets()
    end
  end



end

