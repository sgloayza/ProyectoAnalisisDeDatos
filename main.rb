require "open-uri"
require "nokogiri"
require "csv"
require "set"

require "./Juego"
require "./Etiqueta"
require "./ScraperSteam"
require "./ScraperFanatical"





#------------Steam

#url
urlSteam = "https://store.steampowered.com/search/?sort_by=&sort_order=0&page="

#crea archivo
ScraperSteam.new.crearArchivoJuegos

#Para obtener etiquetas.csv
#ScraperSteam.new.extraerDatosEtiquetas(urlSteam)

for i in 1..25
  #Para obtener juegosSteam.csv
  ScraperSteam.new.extraerDatosJuegos(urlSteam+i.to_s)
end






#------------Fanatical

#url
urlFanatical = "https://www.fanatical.com/en/search?page="

#crea archivo
#ScraperFanatical.new.crearArchivoJuegos

for i in 1..5
  #Para obtener juegosFanatical.csv
  #ScraperFanatical.new.extraerDatosJuegos(urlFanatical+i.to_s)
end






#------------Eneba

#url
urlEneba = "https://www.eneba.com/latam/store?page="

#crea archivo
#ScraperEneba.new.crearArchivoJuegos

for i in 1..5
  #Para obtener juegosFanatical.csv
  #ScraperEneba.new.extraerDatosJuegos(urlEneba+i.to_s)
end