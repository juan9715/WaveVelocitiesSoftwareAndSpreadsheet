function [ salida ] = graficarResultados2( resultados,eje1,selecc,param, longitud )
%GRAFICARRESULTADOS2 Grafica el poisson con los seleccionados
%   Todos en el primer eje

% Borrar datos previos
h=findobj('type','line','MarkerFaceColor','r');
if (length(h) > 2)
    try
        delete(h(param)); 
    catch
    end
end

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

for aa = selecc:selecc
   
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
    'MarkerEdgeColor','r','Marker','s',...
    'MarkerFaceColor','r','parent',eje1);
    
    
end


salida = velocidades;

end

