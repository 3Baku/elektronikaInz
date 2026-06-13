% 0. Czyszczenie środowiska (bardzo ważne przy testach)
clearvars; 
clc;
close all;

% 1. Definiujesz tablicę ścieżek do plików (na start podaj jeden plik do testu)
sciezki_do_plikow = ["D:\studia\elektronikaInz\sem4\srmp\project\dataset\gbo.ast.radar.arecibo.doppler_spectra_of_asteroids_v1.1\data\1993KH\2019\nov13\cw\1993KH.2019Nov13.p0103Hz_001.csv"];
%show_data(sciezki_do_plikow)
% 2. Wywołujesz funkcję (ZMIENIONE: 'keys' na 'klucze_meta')
[freq, spec, klucze_meta, tags, extras] = read_csv_spec(sciezki_do_plikow);
 show_data(freq, spec, klucze_meta, tags, extras);

 % - - - - - XML zone - - - 
xml_file = "D:\studia\elektronikaInz\sem4\srmp\project\dataset\gbo.ast.radar.arecibo.doppler_spectra_of_asteroids_v1.1\data\1993KH\2019\nov13\cw\1993KH.2019Nov13.p0103Hz_001.xml";

[name, R, Pt] = read_xml(xml_file);

fprintf('--- XML DATA ---\n');
fprintf('Planetoid (key): %s\n', name);
fprintf('Transmiter power (Pt):  %.0f W\n', Pt);
fprintf('Distance (R):       %.2f km\n', R / 1000);
% - - - - END of XML zone - - - - - 

% % 3. Sprawdzenie nr 1: Wyświetlenie danych z mapy (Słownika)
disp('--- TEST METADANYCH ---');
slownik_pliku = klucze_meta{1}; 

% % Teraz MATLAB bez problemu użyje swojej oryginalnej, wbudowanej funkcji keys()
klucze = keys(slownik_pliku); 
disp(['Dostępne klucze (keywords): ', strjoin(klucze, ', ')]);

% % 4. Sprawdzenie nr 2: Wykreślenie obu polaryzacji widma dopplerowskiego
% % Używamy pierwszej (i jedynej) strony z trójwymiarowej macierzy spec (:,:,1)
polarisation_OC = spec(1, :, 1);
polarisation_SC = spec(2, :, 1);
os_czestotliwosci = freq(1, :);

% sum_OC = sum(polaryzacja_OC) * ( os_czestotliwosci(2)-os_czestotliwosci(1));
% sum_SC = sum(polaryzacja_SC)* (os_czestotliwosci(2)-os_czestotliwosci(1));
% mu = sum_SC/sum_OC
%  integral_OC = trapz(freq,polarisation_OC)
% integral_SC = trapz(freq,polarisation_SC)
figure;
hold on; grid on;
plot(os_czestotliwosci, polarisation_OC, 'b', 'LineWidth', 1.5, 'DisplayName', 'Polaryzacja OC');
plot(os_czestotliwosci, polarisation_SC, 'r', 'LineWidth', 1.5, 'DisplayName', 'Polaryzacja SC');
title('Doppler dla CW dla 1998OH');
xlabel('Przesunięcie częstotliwości [Hz]');
ylabel('Gęstość Widmowa Mocy');
legend('show');
hold off;