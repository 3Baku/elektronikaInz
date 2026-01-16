clear; clc; close all;

%% KONFIGURACJA ZADANIA
% Definicja równań różniczkowych (Zad 1: Równanie 1 i Równanie z podpunktu b)
% Struktura: {f_handle, y_exact_handle, nazwa}
equations = {
    {@(t,y) -2*y*t, ...              % f(t,y) dla Eq 1
     @(t) exp(-t.^2), ...            % y_sol dla Eq 1
     'Równanie 1: dy/dt + 2yt = 0'};
     
    {@(t,y) (4 - 2*y)/3, ...                        % f(t,y) dla Eq 2 (podpunkt b)
     @(t) 2*(1 - exp(-2*t/3)) + 1*exp(-2*t/3), ...  % y_sol dla Eq 2 (y0=1)
     'Równanie 2: dy/dt = (4-2y)/3'}
};

% Parametry globalne
T_range = [0, 10];
y0 = 1; % Punkt startowy dla obu równań (zgodnie z treścią zadania)
h_values = [1, 0.1, 0.01, 1e-3]; % Długości kroku całkowania

% Słownik metod do łatwego iterowania i legendy
methods_list = {
    'a) Euler Otwarty (EO)', 'EO';
    'c) Trapezów (AM2)', 'Trapez';
    'd) Heuna (RK2)', 'Heun';
    'e) Zmodyfikowany Euler', 'ModEuler';
    'f) Adams-Bashforth 2', 'AB2';
    'g) Adams-Moulton 3', 'AM3';
    'h) Gear Otwarty 2', 'GearO2';
    'i) Gear Otwarty 4', 'GearO4';
    'j) Gear Zamknięty 2', 'GearZ2';
    'k) Gear Zamknięty 4', 'GearZ4';
};

%% GŁÓWNA PĘTLA OBLICZENIOWA
% Iteracja po równaniach (Eq 1 oraz Eq 2)
for eq_idx = 1:length(equations)
    f = equations{eq_idx}{1};
    y_sol_func = equations{eq_idx}{2};
    eq_name = equations{eq_idx}{3};
    
    fprintf('Obliczenia dla: %s\n', eq_name);
    
    % Przechowywanie błędów max dla wykresu loglog (wiersze: metody, kolumny: kroki h)
    max_errors = zeros(size(methods_list, 1), length(h_values));
    
    % Iteracja po długościach kroku h
    for h_idx = 1:length(h_values)
        h = h_values(h_idx);
        t = T_range(1):h:T_range(2);
        N = length(t);
        
        % Rozwiązanie dokładne dla obecnego wektora czasu
        y_exact = y_sol_func(t);
        
        % --- ROZWIĄZANIA WYSOKOPOZIOMOWE (ZAKOMENTOWANE) ---
        % Poniżej przykład, jak rozwiązać to jedną linijką w MATLABie:
        % options = odeset('RelTol', 1e-6, 'AbsTol', 1e-6);
        % [t_ode, y_ode] = ode45(f, T_range, y0, options);
        % ---------------------------------------------------
        
        % Przygotowanie wykresu rozwiązań dla danego h
        if h_idx == 2 % Rysujemy np. dla h=0.1 żeby było czytelnie
            figure('Name', sprintf('%s, h=%g', eq_name, h));
            plot(t, y_exact, 'k-', 'LineWidth', 2, 'DisplayName', 'Dokładne');
            hold on;
            title(sprintf('Rozwiązania: %s (h=%g)', eq_name, h));
            xlabel('Czas t'); ylabel('y(t)');
        end
        
        % Iteracja po metodach (a-k)
        for m_idx = 1:size(methods_list, 1)
            method_key = methods_list{m_idx, 2};
            
            % Alokacja pamięci na wynik
            y = zeros(1, N);
            y(1) = y0;
            
            % Pętla czasowa (niskopoziomowa)
            for n = 1:N-1
                tn = t(n);
                yn = y(n);
                fn = f(tn, yn);
                
                % Zmienna pomocnicza na y_{n+1}
                y_next = 0;
                
                % --- Wybór metody i obliczenie kroku ---
                switch method_key
                    case 'EO' % a) Euler Otwarty
                        y_next = yn + h * fn;
                        
                    case 'Trapez' % c) Trapezów (niejawna - iteracja)
                        % Predykcja (Euler)
                        y_pred = yn + h * fn;
                        % Korekcja (Metoda iteracji prostej - zazwyczaj 1-2 pętle wystarczą dla małych h)
                        for iter = 1:5
                            f_next = f(t(n+1), y_pred);
                            y_pred = yn + h * (f_next + fn) / 2;
                        end
                        y_next = y_pred;
                        
                    case 'Heun' % d) Heuna (RK2)
                        y_pred = yn + h * fn;
                        y_next = yn + (h/2) * (fn + f(t(n+1), y_pred));
                        
                    case 'ModEuler' % e) Zmodyfikowany Euler
                        y_mid = yn + (h/2) * fn;
                        t_mid = tn + h/2;
                        y_next = yn + h * f(t_mid, y_mid);
                        
                    case 'AB2' % f) Adams-Bashforth 2
                        if n < 2
                            % Start metodą Eulera (brak wystarczającej historii)
                            y_next = yn + h * fn;
                        else
                            fn_minus_1 = f(t(n-1), y(n-1));
                            y_next = yn + h * (3*fn - fn_minus_1) / 2;
                        end
                        
                    case 'AM3' % g) Adams-Moulton 3 (niejawna)
                        if n < 2
                            y_next = yn + h * fn; % Start Eulerem
                        else
                            fn_minus_1 = f(t(n-1), y(n-1));
                            % Predykcja (AB2 jako start)
                            y_pred = yn + h * (3*fn - fn_minus_1) / 2;
                            % Korekcja (Iteracja)
                            for iter = 1:5
                                f_next = f(t(n+1), y_pred);
                                y_pred = yn + h * (5*f_next + 8*fn - fn_minus_1) / 12;
                            end
                            y_next = y_pred;
                        end
                        
                    case 'GearO2' % h) Gear Otwarty 2
                        if n < 2
                            y_next = yn + h * fn;
                        else
                            % Wzór: yn+1 = 2h*fn + yn-1
                            y_next = 2*h*fn + y(n-1);
                        end
                        
                    case 'GearO4' % i) Gear Otwarty 4
                        if n < 4
                             y_next = yn + h * fn; % Start Eulerem dla pierwszych kroków
                        else
                            % Wzór: yn+1 = 4h*fn - 10/3*yn + 6*yn-1 - 2*yn-2 + 1/3*yn-3
                            y_next = 4*h*fn - (10/3)*yn + 6*y(n-1) - 2*y(n-2) + (1/3)*y(n-3);
                        end
                        
                    case 'GearZ2' % j) Gear Zamknięty 2 (niejawna)
                        if n < 2
                            y_next = yn + h * fn;
                        else
                            % Predykcja (np. Gear Otwarty)
                            y_pred = 2*h*fn + y(n-1);
                            % Korekcja iteracyjna
                            % Wzór: y_next = (2h*f_next + 4*yn - yn-1) / 3
                            for iter = 1:5
                                f_next = f(t(n+1), y_pred);
                                y_pred = (2*h*f_next + 4*yn - y(n-1)) / 3;
                            end
                            y_next = y_pred;
                        end
                        
                    case 'GearZ4' % k) Gear Zamknięty 4 (niejawna)
                        if n < 4
                            y_next = yn + h * fn;
                        else
                            % Predykcja
                            y_pred = yn + h*fn; 
                            % Korekcja iteracyjna
                            % Wzór: (12*h*f_next + 48*yn - 36*yn-1 + 16*yn-2 - 3*yn-3) / 25
                            for iter = 1:5
                                f_next = f(t(n+1), y_pred);
                                numerator = 12*h*f_next + 48*yn - 36*y(n-1) + 16*y(n-2) - 3*y(n-3);
                                y_pred = numerator / 25;
                            end
                            y_next = y_pred;
                        end
                end
                
                % Zapisanie wyniku
                y(n+1) = y_next;
            end
            
            % Obliczenie błędu maksymalnego
            % Uwaga: Porównujemy tylko w punktach wspólnych, tutaj wektory są zgodne
            current_max_error = max(abs(y - y_exact));
            max_errors(m_idx, h_idx) = current_max_error;
            
            % Dodanie do wykresu rozwiązań (tylko dla wybranego h)
            if h_idx == 2
                plot(t, y, '--', 'DisplayName', methods_list{m_idx, 1});
            end
        end
        
        if h_idx == 2
            legend('Location', 'BestOutside');
            grid on;
        end
    end
    
    % --- Wykres błędów (loglog) dla danego równania ---
    figure('Name', sprintf('Błędy max vs h: %s', eq_name));
    for m_idx = 1:size(methods_list, 1)
        loglog(h_values, max_errors(m_idx, :), '-o', 'DisplayName', methods_list{m_idx, 1}, 'LineWidth', 1.5);
        hold on;
    end
    title(sprintf('Zależność błędu max od kroku h (%s)', eq_name));
    xlabel('Krok h (log)');
    ylabel('Błąd maksymalny (log)');
    legend('Location', 'BestOutside');
    grid on;
    
end