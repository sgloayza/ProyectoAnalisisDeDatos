require "open-uri"
require "nokogiri"
require "csv"
require "set"

require "./Juego"
require "./Etiqueta"
require "./ScraperSteam"
require "./ScraperFanatical"
require "./ScraperEneba"

#------------Steam-Loayza

#url
urlSteam = "https://store.steampowered.com/search/?sort_by=&sort_order=0&page="
#crea archivo
#ScraperSteam.new.crearArchivoJuegos
#
#Para obtener etiquetas.csv
#ScraperSteam.new.extraerDatosEtiquetas(urlSteam)
for i in 1..25
  #Para obtener juegosSteam.csv
  #ScraperSteam.new.extraerDatosJuegos(urlSteam+i.to_s)
end

#------------Fanatical-Briones
ScraperFanatical.new.crearArchivoJuegos
#url
link = "https://www.fanatical.com"
#crea archivo
#ScraperFanatical.new.crearArchivoJuegos
for i in 1..2
  url = link + "/en/search?page=" + i.to_s + "&types=game"
  ScraperFanatical.new.extraer(url, link)
end


#------------Eneba-Mora
#url
urlEneba = "https://www.eneba.com"

# Crea un objeto tipo ScraperEneba
s = ScraperEneba.new

# Extrae datos y genera un archivo csv

# !!!! Descomentar para crear csv de Eneba !!!!

#s.extraer(urlEneba)