% Parametry symulacji
h = 0.1;              % Krok czasowy (zmień na 1, 0.01 itd. wg potrzeby)
T_max = 10;           % Czas końcowy
t = 0:h:T_max;        % Wektor czasu
N = length(t);        % Liczba kroków

% Inicjalizacja wektorów wyników
y_eo = zeros(1, N);   % Euler Otwarty
y_ez = zeros(1, N);   % Euler Zamknięty
y_dok = exp(-t.^2);   % Rozwiązanie dokładne (dla porównania)

% Warunki początkowe (z zadania y0=1)
y_eo(1) = 1;
y_ez(1) = 1;

% Główna pętla obliczeniowa
for n = 1 : N-1
    % --- a) Metoda Eulera Otwarta ---
    % y(n+1) = y(n) + h * f(t(n), y(n))
    % f(t, y) = -2*y*t
    y_eo(n+1) = y_eo(n) + h * (-2 * y_eo(n) * t(n));
    
    % --- b) Metoda Eulera Zamknięta ---
    % Wzór po przekształceniu algebraicznym:
    % y(n+1) = y(n) / (1 + 2*h*t(n+1))
    y_ez(n+1) = y_ez(n) / (1 + 2 * h * t(n+1));
end

% Wykres wyników
figure;
plot(t, y_dok, 'k-', 'LineWidth', 2); hold on;
plot(t, y_eo, 'r--o');
plot(t, y_ez, 'b--x');
legend('Rozwiązanie dokładne', 'Euler Otwarty', 'Euler Zamknięty');
xlabel('Czas t');
ylabel('Wartość y');
title(['Porównanie metod dla h = ' num2str(h)]);
grid on;