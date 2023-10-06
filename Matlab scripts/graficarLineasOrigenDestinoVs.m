function [ salida ] = graficarLineasOrigenDestino( resultados, eje1, eje2, longitud )
%GRAFICARLINEASORIGEN Función empleada para graficar las líneas
%   del tiempo de salida (depart) de la onda

% cla(eje2);

% Determinar el número de métodos existentes
dims = size(resultados);
nmetodos = (dims(2) - 3)/2;

% Recuperar los valores de esfuerzos
sigmas = resultados(:,2);

% Recuperar los idArchivos
idArchivos = resultados(:,3);

% Paleta de colores
colores = {[224,224,224]./255,...
    [ 173, 172, 172 ]./255,...
    [ 132, 132, 132]./255};
colores2 = {[224,224,224]./255,...
    [ 173, 172, 172 ]./255,...
    [ 132, 132, 132]./255};

% colores = {'c--','r--','k--'};
% colores2 = {'c','r','k'};


for aa = 1:nmetodos
    
    % Borrar datos previos
    figure(1)
    ejeActual = gca;
    h=findobj('type','line','color',[224,224,224]./255,'parent',ejeActual);
    delete(h);
    h=findobj('type','line','color',[ 173, 172, 172 ]./255,'parent',ejeActual);
    delete(h);
    h=findobj('type','line','color',[ 132, 132, 132]./255,'parent',ejeActual);
    delete(h);
    
    h=findobj('type','line','color',[224,224,224]./255,'parent',eje1);
    delete(h);
    h=findobj('type','line','color',[ 173, 172, 172 ]./255,'parent',eje1);
    delete(h);
    h=findobj('type','line','color',[ 132, 132, 132]./255,'parent',eje1);
    delete(h);
    
end

% Recorrer los métodos diferentes

for aa = 1:nmetodos
   
    % Color actual
    color = colores{aa};
    color2 = colores2{aa};
           
    % Recuperar los tiempos de depart
    tDeparts = resultados(:, 3 + (aa-1) * 2 + 1);
    
    % Recuperar los tiempos de arrival
    tArrivals = resultados(:, 3 + (aa-1) * 2 + 2);
    
    % Graficar en la figura
    figure(1)
    tipoLinea = [color2 '--'];
    plot(idArchivos,tDeparts,tipoLinea);
    plot(idArchivos,tArrivals,'color',color);
        
    % Graficar en la ventana principal los resultados
    % de depart
    plot(idArchivos,tDeparts,tipoLinea,'parent',eje1);
    
    % Graficar en la ventana principal los resultados
    % de arrival
    plot(idArchivos,tArrivals,'color',color,'parent',eje1);
    
    % Graficar los resultados de velocidad de onda
    velocidades = longitud./((tArrivals-tDeparts)./1000);    
    plot(sigmas,velocidades,'w--','MarkerSize',5,...
    'MarkerEdgeColor','k','Marker','s',...
    'MarkerFaceColor',color2,'parent',eje2);

    
    
    
%     disp(idArchivos);
%     disp(tArrivals);
    
    
end


salida = 1;

end

