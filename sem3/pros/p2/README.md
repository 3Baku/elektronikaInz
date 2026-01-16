# file_import(file_path)
Opis: Importuje plik CSV do obiektu DataFrame.

Argumenty:
    file_path (str): Ścieżka do pliku CSV.

Zwraca:
    pd.DataFrame: Ramka danych (DataFrame) zawierająca dane z pliku CSV.


# explore_data(sales_data)

Opis: Wyświetla podstawowe informacje o danych sprzedażowych.

Argumenty:
    sales_data (pd.DataFrame): Ramka danych z kolumnami 'price', 'day' oraz 'units_sold'.

Zwraca:
    None

# explore_data_temperature(temperature_data)

Opis: Wyświetla podstawowe informacje o danych temperaturowych, w tym korelację z wilgotnością.

Argumenty:
    temperature_data (pd.DataFrame): Ramka danych z kolumnami 'humidity' oraz 'temperature'.

Zwraca:
    None


# temperature_visualisation(temperature_data)

Opis: Wizualizuje średnie temperatury dla poszczególnych miast za pomocą wykresu słupkowego.

Argumenty:
    temperature_data (pd.DataFrame): Ramka danych z kolumnami 'city' oraz 'avg_temp_C'.

Zwraca:
    None

# sales_visualisation(sales_data)

Opis: Wizualizuje liczbę sprzedanych jednostek w czasie.

Parametry:
    sales_data (pd.DataFrame): Ramka danych z kolumnami 'day' oraz 'units_sold'.

Zwraca:
    None