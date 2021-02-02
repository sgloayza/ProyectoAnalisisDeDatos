import numpy as np
import pandas as pd
import matplotlib as mpl
import matplotlib.pyplot as plt
import seaborn as sns
import warnings; warnings.filterwarnings(action='once')
from matplotlib.ticker import FuncFormatter
import squarify




# STEAM

# Correlación entre variables calificacion Metacritic y precio
def scatterplot1():

    # lectura
    df = pd.read_csv("juegosSteam.csv")

    # condiciones
    df = df[df.metacritic.notnull()]
    df = df[df["precio"]>0]
    df = df[df["metacritic"] > 0]
    df = df[0:3]

    # estilo
    sns.set_style("ticks")

    # variables y limites
    gridobj = sns.lmplot(x="metacritic", y="precio", data=df, height=5, aspect=1)
    gridobj.set(xlim=(55,95), ylim=(0,65))

    # presenta
    plt.title("Regresión lineal simple", fontsize=16, color='red')
    plt.xlabel('Metacritic', fontsize=16, color='red')
    plt.ylabel('Precio', fontsize=16, color='red')
    plt.tight_layout()
    plt.show()
#scatterplot1()

# Ranking de géneros
def barplot1():

    # lectura
    df = pd.read_csv("etiquetas.csv")

    # ordeno
    df = df.sort_values(by=['nroDeJuegos'], ascending=False)

    # escojo los 10 primeros
    generos = df["nombreE"].values[0:3]
    njuegos = df["nroDeJuegos"].values[0:3]

    fig, ax = plt.subplots()

    # tamano ventana
    fig.set_size_inches(8,4)

    # grosor de barras
    width = 0.5

    # ubicacion x
    ind = np.arange(len(njuegos))

    # estilos y limites
    # color = ["#0032FF", "#1D48FF", "#2D55FF", "#4A6CFF", "#607EFF", "#7690FF", "#889FFF", "#9EB0FF", "#AFBEFF", "#C4CFFF"]
    color = ["#0032FF", "#607EFF", "#AFBEFF"]
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
        ax.text(v, i+0.25, str(v), color='#032F83', fontweight='bold')
    plt.yticks(fontsize=10, rotation=25, color='black') #juegos nombres
    plt.title('Popularidad de los géneros en los juegos', fontsize=16, color='red')
    plt.xlabel('Número de Juegos', fontsize=16, color='red')
    plt.ylabel('Géneros', fontsize=16, color='red')

    #presenta
    plt.show()
#barplot1()








# ENEBA

# Composición: Treemap del top 10 de publicadores de videojuegos
def treemap():
    # Leemos el csv.
    df_raw = pd.read_csv("juegosEneba.csv")

    # Agrupamos por publisher y contamos cuántos hay por clase.
    df = df_raw.groupby('Publisher').size().reset_index(name='counts')
    # Sort de los datos
    df = df.sort_values(by=["counts"], ascending=False)[0:10]
    # Agregamos las etiquetas
    labels = df.apply(lambda x: str(x[0]) + "\n (" + str(x[1]) + ")", axis=1)
    sizes = df['counts'].values.tolist()
    # Decoración
    colors = [plt.cm.Spectral(i/float(len(labels))) for i in range(len(labels))]

    # Graficamos el treemap
    plt.figure(figsize=(12, 8), dpi=80)
    squarify.plot(sizes=sizes, label=labels, text_kwargs={'fontsize': 10}, color=colors, alpha=.8)

    plt.title('Top 10 Publishers')
    plt.axis('off')
    plt.show()
#treemap()

# Desviación: La variación de valores según género
def dotplot():
    df_raw = pd.read_csv("juegosEneba.csv")

    # Filtro para evitar filas sin datos
    df = df_raw[df_raw["Valoración del usuario"] != "0"]
    df = df[df["Generos"].notnull()]

    # Separamos en dos array las columnas que vamos a graficar
    generos_raw = df["Generos"].values.tolist()
    valoracionUsuario_raw = df["Valoración del usuario"].values.tolist()
    valoracionUsuario = []

    generos = []
    valores = []

    # Genera array con generos y valores
    for valor in valoracionUsuario_raw:
        arr = valor.split("/")
        a = float(arr[0])
        b = int(arr[1])
        c = round(a/b * 100)
        valoracionUsuario.append(c)

    for i in range(len(generos_raw)):
        arr = generos_raw[i].split("|")
        for j in range(len(arr)):
            generos.append(arr[j])
            valores.append(valoracionUsuario[i])

    # Crea un dataframe a partir de los array
    data = {"Generos": generos, "ValoracionUsuario": valores}

    df = pd.DataFrame(data, columns=["Generos", "ValoracionUsuario"])

    # Saca el promedio
    df["mean"] = df.groupby("Generos")["ValoracionUsuario"].transform("mean")

    # Borra repetidos
    df.drop_duplicates(subset="Generos", keep="first", inplace=True)

    # Borra columna
    del df["ValoracionUsuario"]

    df = df.sort_values(by=["mean"], ascending=False)

    x = df.loc[:, ['mean']]

    # Prepara los valores
    df['mean_z'] = (x-x.mean())/x.std()
    df['colors'] = ['red' if x < 0 else 'darkgreen' for x in df['mean_z']]
    df.sort_values('mean_z', inplace=True)
    df.reset_index(inplace=True)

    # Dibuja el gráfico
    plt.figure(figsize=(12,8), dpi= 80)
    plt.scatter(df.mean_z, df.index, s=450, alpha=.6, color=df.colors)
    for x, y, tex in zip(df.mean_z, df.index, df.mean_z):
        t = plt.text(x, y, round(tex, 1), horizontalalignment='center',
                     verticalalignment='center', fontdict={'color':'white'})

    # Decoración
    # Bordes finos
    plt.gca().spines["top"].set_alpha(.3)
    plt.gca().spines["bottom"].set_alpha(.3)
    plt.gca().spines["right"].set_alpha(.3)
    plt.gca().spines["left"].set_alpha(.3)

    plt.yticks(df.index, df.Generos)
    plt.title('Dotplot: Divergencia en las valoraciones de usuario', fontdict={'size':20})
    plt.xlabel('$Valoración de Usuario$')
    plt.grid(linestyle='--', alpha=0.5)
    plt.xlim(-2.5, 2.5)
    plt.show()
#dotplot()









# FANATICAL

# Composición, disponibilidad en plataformas.
def piechart():
    data = pd.read_csv("juegosFanatical.csv")
    desar = data.groupby('desarrollador').size().reset_index(name='counts')
    desar = desar.sort_values(by=["counts"], ascending=False)[0:15]
    nombres = desar["desarrollador"].values.tolist()
    numeros = desar["counts"].values.tolist()
    fig1, ax1 = plt.subplots()
    ax1.pie(numeros, labels=nombres, autopct='%1.2f%%',
            shadow=True, startangle=90)
    ax1.axis('equal')  # Equal aspect ratio ensures that pie is drawn as a circle.

    plt.show()
    print(desar)
#piechart()

def histogram():
    data = pd.read_csv("juegosFanatical.csv")
    data.drop_duplicates(subset="nombre", keep="first", inplace=True)
    data = data.sort_values(by=['precio'], ascending=False)
    x = np.arange(3)
    nombres = data["nombre"].values.tolist()[0:3]
    precio = data['precio'].values.tolist()[0:3]
    fig, ax = plt.subplots()
    plt.bar(x, precio)
    plt.xticks(x, nombres)
    plt.show()
#histogram()
