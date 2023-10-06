function [ salida ] = graficarResultados1( resultados,eje1, longitud )
%GRAFICARRESULTADOS1 Grafica el conjunto de los resultados
%   Todos en el primer eje


% Determinar el número de métodos existentes
dims = size(resultados);
nmetodos = (dims(2) - 3)/2;

% Recuperar los valores de esfuerzos
sigmas = resultados(:,2);
ndatos = length(sigmas);

% Paleta de colores
colores = {'m--','r--','k--'};
colores2 = {'m','r','k'};

% Recorrer los métodos diferentes

for aa = 1:nmetodos
   
    % Color actual
    color = colores{aa};
    color2 = colores2{aa};
           
    % Recuperar los tiempos de depart
    tDeparts = resultados(:, 3 + (aa-1) * 2 + 1);
    
    % Recuperar los tiempos de arrival
    tArrivals = resultados(:, 3 + (aa-1) * 2 + 2);
    
    
    % Graficar los resultados de velocidad de onda
    velocidades = longitud./((tArrivals-tDeparts)./1000);    
    plot(sigmas,velocidades,'w--','MarkerSize',5,...
    'MarkerEdgeColor','k','Marker','s',...
    'MarkerFaceColor','k','parent',eje1);
    
    
end


salida = 1;

end

