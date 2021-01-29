require "open-uri"
require "nokogiri"
require "csv"

require "./Juego"
require "./Etiqueta"
require "./Scraper"




urlSteam = "https://store.steampowered.com/search/?sort_by=&sort_order=0&page="
urlFanatical = "https://www.fanatical.com/es/search?page="
urlEneba = "https://www.eneba.com/latam/store/games"



#Scraper.new.extraerDatosEtiquetasSteam(urlSteam)       #Para obtener etiquetas.csv



for i in 1..5                                           #Podemos un max o sacamos el maximo?
  #Scraper.new.extraerDatosJuegosSteam(urlSteam+i.to_s)  #Para obtener juegosSteam.csv
  Scraper.new.extraerDatosJuegosFanatical(urlFanatical+i.to_s)  #Para obtener juegosFanatical.csv

end
