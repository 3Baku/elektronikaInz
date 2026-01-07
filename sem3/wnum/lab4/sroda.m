zadanie2()

function zadanie1()
    polyFun = [1,0,2,-3,8];
    ideal = polyval(polyFun, 1);

    func = @(x) x^4 +x^2 -3*x-8;
       
    rzad1 = @(fun, x, h) (fun(x+h)-fun(x))/h;
    rzad2 = @(fun, x, h) (fun(x+h) - fun(x-h)) / (2*h);
    rzad3 = @(fun, x, h) (fun(x-2*h) -8* fun(x-h) + 8*fun(x+h) + fun(x+2*h)) / (12*h);
    hs = linspace(-0.2, 0.2, 50);
    rzedy = {rzad1, rzad2, rzad3};
    bladWzglMatrix = [];
    for idx = 1:length(rzedy)
        rzad = rzedy{idx};
        bladWzglednyRow = [];

        for h = hs
            wynik = rzad(func, 1, h);
            bladBezwzgledny = abs(ideal-wynik);
            bladWzgledny = bladBezwzgledny/abs(ideal);
            bladWzglednyRow =[bladWzglednyRow, bladWzgledny] 
        end
        bladWzglMatrix = [bladWzglMatrix; bladWzglednyRow];
        
    end
    figure;
    
    hold on;
    for idx = 1:length(rzedy)-1
        semilogy(hs, bladWzglMatrix(idx, :),...
            'DisplayName', sprintf("Dla rzedu %d", idx));
    end

   % optimumY = [0.8, 0.8];
   % optimumX = [-0.2, 0.2];
   % semilogy(optimumX,optimumY, ...
   %     'DisplayName', 'optymalne');
    hold off;
    legend();
    grid on;
    xlabel("Kolejne kroki iteracji");
    ylabel("Blad wzgledny");
    title("blad wzgl dla kolejnych krokow iteracji dla wybranych rzedow");


end
function zadanie2()
    clc; close all;
    
    % 1. Definicja funkcji i wartości idealnej
    func = @(x) (1/sqrt(2*pi)) * exp(-x.^2/2);
    ideal = integral(func, -1, 1); % Wartość referencyjna
    
    % Zakres liczby węzłów (kroków)
    liczbyWezlow = 3:2:500; % Nieparzyste, żeby Simpson łatwo działał
    
    % Inicjalizacja wektorów na błędy
    bledyTrapz = [];
    bledySimps = [];
    bledyMC = [];
    
    % Główna pętla po liczbie węzłów
    for N = liczbyWezlow
        % Generowanie siatki punktów (wysokopoziomowe linspace)
        x = linspace(-1, 1, N);
        y = func(x);
        h = (x(end) - x(1)) / (N - 1); % długość kroku
        
        % --- A) Metoda Trapezów (używamy gotowej funkcji trapz) ---
        wynikTrapz = trapz(x, y);
        bledyTrapz = [bledyTrapz, abs(ideal - wynikTrapz)];
        
        % --- B) Metoda Simpsona (Wektoryzacja zamiast pętli) ---
        % Tworzymy wektor wag: [1, 4, 2, 4, ..., 1]
        wagi = ones(1, N);
        wagi(2:2:end-1) = 4; % Parzyste indeksy mają wagę 4
        wagi(3:2:end-2) = 2; % Nieparzyste (wewnątrz) mają wagę 2
        
        % Mnożenie wektorowe (dot product) - bardzo szybkie i 'matlabowe'
        wynikSimps = (h/3) * sum(wagi .* y); 
        bledySimps = [bledySimps, abs(ideal - wynikSimps)];
        
        % --- C) Monte Carlo (Orzeł/Reszka) ---
        % Wektoryzacja: losujemy N punktów naraz funkcją rand()
        x_rand = -1 + 2 * rand(1, N);     % x w zakresie [-1, 1]
        y_max = 1/sqrt(2*pi);             % maksymalna wysokość funkcji
        y_rand = y_max * rand(1, N);      % y w zakresie [0, y_max]
        
        % Sprawdzenie warunku logicznego dla całego wektora naraz
        trafienia = y_rand <= func(x_rand); 
        
        pole_prostokata = 2 * y_max; % szerokość (2) * wysokość
        wynikMC = pole_prostokata * (sum(trafienia) / N);
        bledyMC = [bledyMC, abs(ideal - wynikMC)];
    end
    
    % Wykresy (skala logarytmiczna dla błędów)
    figure;
    loglog(liczbyWezlow, bledyTrapz, 'DisplayName', 'Metoda Trapezów (trapz)');
    hold on;
    loglog(liczbyWezlow, bledySimps, 'DisplayName', 'Metoda Simpsona');
    loglog(liczbyWezlow, bledyMC, 'DisplayName', 'Monte Carlo (Hit/Miss)');
    hold off;
    
    grid on;
    legend('Location', 'best');
    xlabel('Liczba węzłów / prób');
    ylabel('Błąd bezwzględny');
    title('Zadanie 2: Porównanie dokładności metod');
end