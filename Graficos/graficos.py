import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import warnings; warnings.filterwarnings(action='once')


# STEAM
# Correlación entre variables calificacion Metacritic y precio
def scatterplot1():

    # lectura
    df = pd.read_csv("juegosSteam.csv")

    # condiciones
    df = df[df.metacritic.notnull()]
    df = df[df["precio"]>0]
    df = df[df["metacritic"] > 0]

    # estilo
    sns.set_style("ticks")

    # variables y limites
    gridobj = sns.lmplot(x="metacritic", y="precio", data=df, height=5, aspect=10/5)
    gridobj.set(xlim=(55,95), ylim=(0,65))

    # presenta
    plt.title("Regresión lineal simple", fontsize=16, color='red')
    plt.xlabel('Metacritic', fontsize=16, color='red')
    plt.ylabel('Precio', fontsize=16, color='red')
    plt.tight_layout()
    plt.show()
scatterplot1()
# Ranking de géneros
def barplot1():

    # lectura
    df = pd.read_csv("etiquetas.csv")

    # ordeno
    df = df.sort_values(by=['nroDeJuegos'], ascending=False)

    # escojo los 10 primeros
    generos = df["nombreE"].values[0:10]
    njuegos = df["nroDeJuegos"].values[0:10]

    fig, ax = plt.subplots()

    # tamano ventana
    fig.set_size_inches(14,5)

    # grosor de barras
    width = 0.5

    # ubicacion x
    ind = np.arange(len(njuegos))

    # estilos y limites
    color = ["#0032FF", "#1D48FF", "#2D55FF", "#4A6CFF", "#607EFF", "#7690FF", "#889FFF", "#9EB0FF", "#AFBEFF", "#C4CFFF"]
    for i in ind:
        ax.barh(i,njuegos[i], width, color=color[i])
    ax.set_yticks(ind + width / 2)
    ax.set_yticklabels(generos, minor=False)
    ax.spines["top"].set_visible(False)
    ax.spines["left"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.set_xlim([0,55000])


    # etiquetas sobre barras
    for i, v in enumerate(njuegos):
        ax.text(v + 3, i + .25, str(v), color='#032F83', fontweight='bold')
    plt.yticks(fontsize=10, rotation=25, color='black') #juegos nombres
    plt.title('Popularidad de los géneros en los juegos', fontsize=16, color='red')
    plt.xlabel('Número de Juegos', fontsize=16, color='red')
    plt.ylabel('Géneros', fontsize=16, color='red')

    #presenta
    plt.show()
barplot1()





# FANATICAL






# ENEBA








# Composición, disponibilidad en plataformas.
def piechart():
    df = pd.read_csv("juegosSteam.csv")

    plataformas = df["plataformas"].values

    wind = 0
    mac = 0
    linux = 0

    for i, l in enumerate(plataformas):
        arr = l.split("/")
        if(len(arr)==3):
            wind = wind + 1
            mac = mac + 1
            linux = linux + 1
        if (len(arr) == 2):
            wind = wind + 1
            mac = mac + 1
        if (len(arr) == 1):
            wind = wind + 1

    labels = "Windows", "Mac", "Linux"
    sizes = [wind,mac,linux]
    explode = (0.1,0,0)

    fig, ax = plt.subplots()
    ax.pie(sizes, explode=explode, labels=labels, autopct='%1.1f%%', shadow=True, startangle=90)
    ax.axis("equal")
    plt.title("Disponibilidad por plataforma")
    plt.show()
# Correlación entre variables género y reseña, precio y reseña
def scatterplot2():
    df = pd.read_csv("juegosSteam.csv")
    df = df[df.metacritic.notnull()]
    df = df[df["precio"]>0]
    df = df[df["metacritic"] > 0]
    sns.set_style("ticks")
    gridobj = sns.lmplot(x="metacritic", y="precio", data=df, height=5, aspect=11/5)
    gridobj.set(xlim=(55, 95), ylim=(0, 65))
    plt.title("Regresión lineal simple")
    plt.tight_layout()
    plt.show()
