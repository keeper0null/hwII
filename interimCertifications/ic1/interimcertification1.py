# -*- coding: utf-8 -*-
"""InterimCertification1.ipynb

Automatically generated by Colaboratory.

Original file is located at
    https://colab.research.google.com/drive/1gHo53MQJtLIjnKXbR8Gl1O5jZtlcL27C

# Промежуточная аттестация 1
## 1) Форма контроля: проверка выполненных заданий на образовательной платформе в текстовых файлах, ссылках на внешние ресурсы.
## 2) Диагностические инструменты:
Необходимо провести анализ датасета.  
https://www.kaggle.com/datasets/twinkle0705/state-wise-power-consumption-in-india/download?datasetVersionNumber=3
dataset_tk

Необходимо скачать датасет и загрузить в свой профиль GitHub
репозитория.  
● В Colab создать новый ноутбук.  
● Используя модули pandas, необходимо загрузить данные из своего репозитория  
● Проанализировать их (выбросы, описательная статистика), используя определенные статистические методы и NumPy  
● Затем, необходимо построить диаграмму, используя matplotlib, для
визуализации результатов анализа.  
● Оформить минимум 2 интересных наблюдения из анализа данных
(закономерности, аномалии)  

**Форма работы:** индивидуальная

**Набор технологий:**
1. Python
2. Numpy
3. Pandas
4. Colab

## 3) Показатели и критерии оценивания:
1. Датасет загружен в Colab ноутбук
2. Составлена описательная статистика
3. Визуализировано потребление каждого города в течение всего периода.
4. Описаны наблюдения

## 4) Шкала оценивания
**Оценки:** зачтено/не зачтено  
● зачтено заслуживает работа, отвечающая требованиям. Работа может
содержать незначительные ошибки. Отвечает всем всем критериям
оценивания.  
● не зачтено заслуживает работа, в которой присутствуют низкие показатели
по критериям оценивания.
"""

# подключение библиотек
import pandas as pd
import seaborn as sns

# загрузка данных
df = pd.read_csv('https://github.com/keeper0null/hwII/raw/main/interimCertifications/ic1/dataset_tk.csv', index_col = 0)
df.head()
# 1. Датасет загружен в Colab ноутбук

# сменим тип у индекса
df.index = pd.to_datetime(df.index)

# посмотрим информацию по таблице
print(df.info())

df.describe(include = 'all')
# 2. Составлена описательная статистика

# Определим количество пустых ячеек
print(df.isna().sum())
print(f'Total: {df.isna().sum().sum()}')

# визуализация данных для общего понимания и поиска выбросов
df.boxplot(vert=False, figsize=( 20 , 8 ))

smallCity = df[df < 100]
smallCity.dropna(axis=1, inplace = True)
smallCity.boxplot(vert=False, figsize=( 20 , 8 ))

verySmallCity = df[df < 20]
verySmallCity.dropna(axis=1, inplace = True)
verySmallCity.boxplot(vert=False, figsize=( 20 , 8 ))

# суммарное потребление по месяцам
sumByMonth = df.groupby([df.index.year, df.index.month]).sum()
sumByMonth

# суммарное потребление по месяцам
avgByMonth = df.groupby([df.index.year, df.index.month]).mean()
avgByMonth

df.plot(figsize=(25, 12), title='График 1. Потребление каждого города в течение всего периода')
# 3. Визуализировано потребление каждого города в течение всего периода.

sumByMonth.plot(figsize=(25, 12), title='График 2. Суммарное потребление каждого города по месяцам')

avgByMonth.plot(figsize=(25, 12), title='График 3. Среднее потребление каждого города по месяцам')

# потреблениеи ЭЭ в Индии циклично (видно на 1 графике) и чем крупнее город тем больше перепады в потреблении
# к середине лета суммарное потребление падает (график 2), но не критично т.к. не сильно отклоняет график среднего потребления (график 3)

# 4. Описаны наблюдения

# эксперимент по прикручиванию нестандарного элемента
!pip install bar-chart-race
import bar_chart_race as bcr

# выполняется больше 12 минут!!!
bcr.bar_chart_race(df, figsize=(4, 3.5), period_length =500, filename = None)

# в задание не входило но был агрегированный датасет по регионам с привязкой к географическим каоординатам
import plotly.express as px
df_long = pd.read_csv('https://raw.githubusercontent.com/keeper0null/hwII/main/interimCertifications/ic1/long_data_.csv')
df_long.dropna(inplace = True)
fig = px.scatter_geo(df_long,'latitude','longitude', color="Regions",
                     hover_name="States", size="Usage",
                     animation_frame="Dates", scope='asia')
fig.update_geos(lataxis_range=[5,35], lonaxis_range=[65, 100])
fig.show()