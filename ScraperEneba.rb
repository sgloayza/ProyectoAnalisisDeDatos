require "nokogiri"
require "open-uri"
require "./JuegoEneba"

class ScraperEneba
    def extraer(link)
        # Usamos un for loop para visitar todas las sub-páginas de juegos
        for i in 1..5
            # Al url se le añade el texto que carga una página específica y el número de esta
            url = link + "/us/store/games?page=" + i.to_s

            # Se abre el url
            juegos = open(url)

            # Se leen los datos
            datos =  juegos.read

            # Se hace un análisis gramático con la librería nokogiri
            parsed = Nokogiri::HTML(datos)

            # Se selecciona el contener principal
            container = parsed.css("._3M7T08")

            # Se selecciona una caja de información
            container.css("._2rxjGA._3nGiQg").each do |box|

                main = box.css("._12ISZC")

                # Se obtiene el url de la página específica de un juego
                href = main.css("a._2idjXd").attribute("href")

                extraerAuxiliar(link + href)

            end
            puts "Página " + i.to_s + " completada."
            i.to_i
        end
    end

    # Extrae información de una (1) página
    def extraerAuxiliar(link)
        juego =  open(link)

        datos =  juego.read

        parsed = Nokogiri::HTML(datos)

        container = parsed.css(".VuhfIS")

        titulo = container.css("._2A5FS7 h1").inner_text

        precio = container.css("._2chGZq").css("._3DEKN9").css("._3MyVtx").css("._3ae9OX").css("span._1fTsyE").css("span._3RZkEb").inner_text

        box_generos = parsed.css("._31k2z_").css("._3x2kJq").css("ul")[0]
        
        generos = ""

        if(box_generos != nil)
            box_generos.css("li").each  do |genero|
                generos += genero.inner_text + "|"
            end
        end
        
        generos = generos.delete_suffix("|")

        box_plataformas = parsed.css("._31k2z_").css("._3x2kJq").css("ul")[1]
        
        plataformas = ""

        if(box_plataformas != nil)
            language = false
            box_plataformas.css("li").each  do |plataforma|
                if(plataforma.inner_text == "English")
                    language = true
                end
                plataformas += plataforma.inner_text + "|"
            end

            plataformas = plataformas.delete_suffix("|")

            if (language == true)
                plataformas = ""
            end
        end
        

        gameinfo = parsed.css("._2U76Y6").css("._3MoLlD").css("._3wYO1h").css("p.FpVQmt")

        fechaSalida = gameinfo[0].inner_text

        desarrollador = gameinfo[1].inner_text

        publisher = gameinfo[2]

        if(publisher != nil)
            publisher = publisher.inner_text
        else
            publisher = ""
        end

        rating = (parsed.css("._2U76Y6").css("._3MoLlD").css("ul._1FKLw1").css("li")[0])

        if(rating != nil)
            rating = rating.css("img").attribute("alt")
            rating = rating.to_s
            if(rating.slice(0) != "R")
                rating = ""
            end
        else
            rating = ""
        end

        valoracionUsuario = parsed.css("._1M1Xz8._28ZPFK").css("strong").inner_text

        imgCover = parsed.css("img.JA5eym").attribute("src")

        j = JuegoEneba.new

        j.registrar(limpiarTitulo(titulo), cambiarMoneda(precio), generos, plataformas, fechaSalida, desarrollador, publisher, rating, completarValoracion(valoracionUsuario), imgCover, link)

    end

    # Por la naturaleza de la página, los títulos vienen con la plataforma donde se canjea la llave
    # Para hacer una unificación de csv, se les quita estas palabras del título
    def limpiarTitulo(titulo)
        palabras = titulo.split(" ")
        tituloLimpio = ""

        for i in 0..(palabras.length() - 4)
            tituloLimpio += palabras[i] + " "
        end

        tituloLimpio.strip()
        return tituloLimpio

    end

    # De GBP a USD
    def cambiarMoneda(precio)
        gbp = (precio.slice!(1..-1)).to_f
        usd = gbp * 1.37
        return usd.round(2)
    end

    # Completa la valoración si está vacío para simplificar los cálculos
    def completarValoracion(valoracion)
        if (valoracion == "")
            return "0"
        else
            return valoracion + "/5"
        end
    end

end