function [ salida ] = grafAlineamiento( directorio,eje )
%ALINEAMIENTO Grafica las ondas medidas y el alineamiento de velocidad
%   En base al método seleccionado


lista = dir(fullfile(directorio, '*.csv'));

% Orden de los archivos
archivodatosX = [directorio '\DATOSX.txt'];
datosX = load(archivodatosX);

% cd(directorio)

% Recuperar nombres de la lista
datos = struct2cell(lista);
noms = {datos{1,:}};

numarchivos = size(datos);
numarchivos = numarchivos(2);

ids = 1:numarchivos;
posics = ids*0;

inicial = 1;
paso = 1;

% Rotular IDs de cada valor de esfuerzo

actual = 1;
posics(1) = 1;

for ii = 2:numarchivos;
    
    if (datosX(ii) ~= datosX(ii-1))

        actual = actual + 1;
        
    end
    
    posics(ii) = actual;
    

    
end


B = [datosX ids'];
B = sortrows(B,1);

B = [B posics'];

% cd(dactual)

% Graficar todas las señales en el folder

figure(1)

for ii = 1:numarchivos
    
    selectedIndex = B(ii,2);
    texto = noms(selectedIndex);
    nombre = [directorio '\' texto{1,1}];
    
    A = dlmread(nombre,',', 3, 0);
    
    % Separar columnas
    
    % Tiempo (ms)
    
    t = A(:,1) * 1000;
%     t = t - t(1);
    posinicial = find(t>-0.5);
    posinicial = posinicial(1);
    A = A(posinicial:end,:);
    
    t = A(:,1) * 1000;
%     t = t+9.9;
%     t = -((-A(:,1)) * 1000 -9.984);
    ndatos = length(t);
    
    % Canal 1 (V)
    ch1 = A(:,2);
    
    % Canal 2 (V)
    ch2 = A(:,3);
    
    % Cerar datos
    
    ch1 = ch1- ch1(1);
    ch2 = ch2- ch2(1);
        
    norma1 = max(abs(ch1));
    norma = max(abs(ch2));
    
    ch1 = ch1/norma1;
    ch2 = ch2/norma;
    
    % Graficar en la figura aparte
    
    coloratras1 = [151 149 152]/255;
    coloratras2 = [153 118 171]/255;
    
    figure(1)
    plot(B(ii,3)+ch1*.5,t,'color',coloratras1)
    hold on
    plot(B(ii,3)+ch2*.5,t,'color',coloratras2)
    
    etiqueta = [num2str(B(ii,1)) '\newline kPa'];
    text(B(ii,3),1.5,etiqueta,...
        'VerticalAlignment','bottom','HorizontalAlignment','center',...
        'FontWeight','Bold','FontSize',12)
    
    % Graficar en la aplicación
    plot(B(ii,3)+ch1*.5,t,'color',coloratras1,'parent',eje)
    hold on
    plot(B(ii,3)+ch2*.5,t,'color',coloratras2,'parent',eje)
    
    etiqueta = [num2str(B(ii,1)) '\newline kPa'];
    text(B(ii,3),0,etiqueta,...
        'VerticalAlignment','bottom','HorizontalAlignment','center',...
        'FontWeight','Bold','FontSize',8,'parent',eje)
    
    
    
end

% set(gca,'ydir','reverse','xdir','reverse')
% figure(1)
set(gca,'ydir','reverse')

xlabel('ID/Amplitude');
ylabel('Time (ms)')
% xlim([0 20])

xlim([0 11])
ylim([1.5 9])


salida = B;

end

