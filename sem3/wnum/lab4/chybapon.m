clear all;
close all;
zadanie2
%zadanie1

function zadanie1
    fun = @(x) sin(3*x);
    int1 = integral(fun, 0, pi/2);

    disp(sprintf('Z Calki integral: %d',int1));
    

    ns = 1:1:6;
    int2 = [];
    for n = ns
        liczbaWezlow = power(2, 2*n+1)-1;
        spaceX = linspace(0, pi/2, liczbaWezlow);
    
        funInSpaceX = fun(spaceX);
        int2 = [int2, trapz(spaceX, funInSpaceX)];
    end
    disp(sprintf('\nDla kwadratury tapezow dla kolejnych n, wynikami sa: \n'));
    disp(int2);

    int3 = quad(fun, 0, pi/2);
    disp(sprintf('\nDla kwadratury Simpsona wynik wynosi: %d.\n', int3));
    

end


function zadanie2
    %rozwijamy dookola x=1
    polynom = [1 0 3 -2 -3];
    polyAnon = @(x) x^4 + 3*x^2 - 2*x -3;
    ideal = polyval(polyder(polynom), 1);
    rzad1 = @(fun,x,h) (fun(x+h)-fun(x))/h;
    rzad2 = @(fun, x, h) (fun(x+h) - fun(x-h)) / (2*h);
    rzad3 = @(fun, x, h) (fun(x-2*h) - 8*fun(x-2*h) + 8*fun(x+2*h) + fun(x+h)) / (12*h);
    hs = linspace(-0.2, 0.2, 100);
    rzedy = {rzad1, rzad2, rzad3};
    errMatrixFull = [];


    for iter = 1:length(rzedy)
        currMethod = rzedy{iter};
        errMatrixRow = [];
        for h = hs
            errBzwg = abs(ideal - currMethod(polyAnon, 1, h));
            errMatrixRow = [errMatrixRow,  errBzwg ./ abs(ideal)];
        
        end
        errMatrixFull = [errMatrixFull; errMatrixRow];
    end
    
    figure; 
    hold on;
    for iter = 1:length(rzedy)-1
        semilogy(hs, errMatrixFull(iter, :), ...
            'DisplayName', sprintf("Rzad %d", iter) );
    end
    hold off;
    grid on;
   % xlim([0,0.01]);
   % ylim([0,0.01]);
    title("Wykres bledu liczenie pochodnych dla roznych wartosci kroku i metod roznego rzedu");
    xlabel("Different step (h)");
    ylabel("Wzgledny blad");
    legend()

end
