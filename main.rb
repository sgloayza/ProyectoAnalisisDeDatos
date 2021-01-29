require "open-uri"
require "nokogiri"
require "csv"

require "./Juego"
require "./Scraper"




urlSteam = "https://store.steampowered.com/search/?sort_by=&sort_order=0&page="
for i in 1..5   #ponemos un max o sacamos el maximo con scrapping?
  Scraper.new.extraerDatosJuegoSteam(urlSteam+i.to_s)
end
