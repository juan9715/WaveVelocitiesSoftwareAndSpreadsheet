function [ listaPuntos ] = identificarDepart( t,ch1 )
%IDENTIFICAR Devuelve los puntos candidatos
%   Recibe como parámetro t y una serie de datos denominada
%   ch1 (input wave)

ndatos = length(t);

% Obtener datos de diferencia vertical
difch1 = ch1 * 0;
dif2ch1 = ch1 * 0;

for jj = 2:ndatos-1
        
    difch1(jj) = ch1(jj) - ch1(jj-1);
    difch1(jj) = sign(difch1(jj));
    dif2ch1(jj) = ch1(jj+1) - ch1(jj);
    dif2ch1(jj) = sign(dif2ch1(jj));
    
end

% Criterio de candidatos

respuesta = difch1 * 0;

npuntos = 7;

for jj = 2:ndatos-1
    
    signo = sign(ch1(jj));
    pred = difch1(jj);
    suce = dif2ch1(jj);
    evaluar = 0;
    
    switch signo
        case 1
            evaluar = pred>suce;
        case -1
            evaluar = pred<suce;
    end
    
    respuesta(jj) = evaluar;
end

seleccionar = find(abs(respuesta) == 1);

tcandidatos = t(seleccionar);
ycandidatos = ch1(seleccionar);

% Procedimiento con threshold adaptativo

thr2 = 0.9;
encontrados = 0;



% Señal de origen

indices = 1:ndatos;
canal2 = sortrows([tcandidatos abs(ycandidatos) seleccionar],2);

ch1orgtime = canal2(:,1);
ch1indices = canal2(:,3);
ch1orgv = ch1(ch1indices);

maximo = max(ch1orgv);

primero = find(abs(ch1orgv) > thr2 * maximo);
primero = primero(1);

actual = ch1orgtime(primero:end);

encontrados = length(actual);
    
    


% Obtener y ordenar los resultados
salidax = ch1orgtime(primero:end);
saliday = ch1orgv(primero:end);

temporal = [salidax'; saliday']';
temporal = sortrows(temporal,1);

% Truncar si necesario
tope = 100;
if (length(salidax) > tope)
    salidax = temporal(1:tope,1);
    saliday = temporal(1:tope,2);
end
% Localizar puntos anteriores a los candidatos

puntosPartida = ch1indices(primero:end);
%     puntosPartida = puntosPartida(1:tope);
resultado2 = salidax * 0;
resp = puntosPartida(1);
for kk =1 : length(puntosPartida)
    
    inicial = puntosPartida(kk);
    valini = ch1(inicial);
    difini = difch1(inicial);
    signini = sign(valini);
    posich = inicial - 1;
    
    while posich > 1
        actual = sign(ch1(posich));
        difactual = sign(difch1(posich));
        
        if(actual ~= signini)
            resp = posich;
            posich = 0;
        elseif (difactual ~= sign(difini))
            resp = posich;
            posich = 0;
        end
        posich = posich - 1;
    end
    resultado2(kk) = resp;
end

% Concatenar vectores de respuesta

temporal = [t(resultado2) ch1(resultado2)];

temporal = sortrows(temporal,1);

salidax = [salidax;t(resultado2)];
saliday = [saliday;ch1(resultado2)];

% Salida de la función

puntosX = salidax;
puntosY = -saliday;

% disp(puntosX);
% disp(puntosY);

% figure(2)
% plot(t,-ch1);
% hold on
% plot(t,-ch1);
% scatter(puntosX,puntosY);

listaPuntos = [puntosX puntosY];

end

