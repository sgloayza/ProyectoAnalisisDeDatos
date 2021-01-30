require "open-uri"
require "nokogiri"
require "csv"
require "set"

require "./Juego"
require "./Etiqueta"
require "./Scraper"

#urls
urlSteam = "https://store.steampowered.com/search/?sort_by=&sort_order=0&page="
urlFanatical = "https://www.fanatical.com/en/search?page="

#crea archivos
Scraper.new.crearArchivoJuegosSteam
Scraper.new.crearArchivoJuegosFanatical

#Para obtener etiquetas.csv
Scraper.new.extraerDatosEtiquetasSteam(urlSteam)

for i in 1..5                                           #Podemos un max o sacamos el maximo?
  #Para obtener juegosSteam.csv
  Scraper.new.extraerDatosJuegosSteam(urlSteam+i.to_s)

  #Para obtener juegosFanatical.csv
  Scraper.new.extraerDatosJuegosFanatical(urlFanatical+i.to_s)
end
