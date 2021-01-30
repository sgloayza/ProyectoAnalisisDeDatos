
class Etiqueta
  attr_accessor :nombreE, :codigo, :nroDeJuegos

  def initialize(nombreE,codigo,nroDeJuegos)
    @nombreE = nombreE
    @codigo = codigo
    @nroDeJuegos = nroDeJuegos
  end

  def registrar()
    CSV.open('Graficos/etiquetas.csv','a') do |csv|
      csv << [@nombreE,@codigo,@nroDeJuegos]
    end
  end


  def toString()
    puts "NombreE= "+@nombreE+
           "\nCódigo= "+@codigo+
           "\nNroDeJuegos= "+@nroDeJuegos
  end



end
