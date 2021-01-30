import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import warnings; warnings.filterwarnings(action='once')


# STEAM
# Correlación entre variables calificacion Metacritic y precio
def scatterplot1():
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
scatterplot1()
# Ranking de géneros
def barplot1():

    # Crear método para la lectura
    df = pd.read_csv("etiquetas.csv")
    df = df.sort_values(by=['nroDeJuegos'], ascending=False)

    generos = df["nombreE"].values[0:10]
    njuegos = df["nroDeJuegos"].values[0:10]

    fig, ax = plt.subplots()
    fig.set_size_inches(14,5) # tamano ventana
    width = 0.4 # grosor de barras
    ind = np.arange(len(njuegos))  # ubicacion x
    ax.barh(ind, njuegos, width, color="blue")
    ax.set_yticks(ind + width / 2)
    ax.set_yticklabels(generos, minor=False)
    ax.spines["top"].set_visible(False)
    ax.spines["left"].set_visible(False)
    ax.spines["right"].set_visible(False)
    ax.set_xlim([0,55000])
    # etiquetas sobre barras
    for i, v in enumerate(njuegos):
        ax.text(v + 3, i + .25, str(v), color='blue', fontweight='bold')
    plt.yticks(fontsize=8, rotation=45)
    plt.title('Popularidad de los géneros en los juegos de video')
    plt.xlabel('Número de Juegos')
    plt.ylabel('Géneros')
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
