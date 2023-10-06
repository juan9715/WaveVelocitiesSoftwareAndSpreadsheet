function [ salida ] = inicializacion( resultados,directorio )
%INICIALIZACION Función para inicializar los resultados de cada método
%   Inicializa el vector de resultados

% Determinar el número de métodos existentes
dims = size(resultados);
nmetodos = (dims(2) - 3)/2;

% Número de archivos
narchivos = length(resultados);
narchivos = dims(1);

% Recuperar los archivos
lista = dir(fullfile(directorio, '*.csv'));
datos = struct2cell(lista);
noms = {datos{1,:}};

% Recuperar el ID original de los archivos
nomArchivos = resultados(:,1);

% Recuperar los idArchivos
% idArchivos = resultados(:,3);

% Inicializar método peak-peak en cada archivo

for ii = 1:narchivos
% for ii = 1:1
    
    % Recuperar datos del archivo actual
    selectedIndex = nomArchivos(ii);    
    texto = noms(selectedIndex);
    nombre = [directorio '\' texto{1,1}];
    
    A = dlmread(nombre,',', 3, 0);
    
    % Tiempo (ms)
    t = A(:,1) * 1000;
%     t = t - t(1);
    posinicial = find(t>-0.5);
    posinicial = posinicial(1);
    A = A(posinicial:end,:);
    t = A(:,1) * 1000;
%     t = t+9.9;
    
    % Canal 1 (V)
    ch1 = -A(:,2);
    
    % Canal 2 (V)
    ch2 = A(:,3);
    
    % Cerar datos
    
    ch1 = ch1- ch1(1);
    ch2 = ch2- ch2(1);
    
    norma1 = max(abs(ch1));
    norma = max(abs(ch2));
    
    ch1 = ch1/norma1;
    ch2 = ch2/norma;
   
    % Obtener los puntos candidatos de depart
    
    candtsDepart = identificarDepart(t,ch1);
    
    % Obtener los puntos candidatos de arrival
    
    candtsArrival = identificar(t,ch2);
    
%     figure(2)
    
    % Seleccionar los puntos resultantes de depart
    
    try
        depart1 = candtsDepart(3,1);
        depart2 = candtsDepart(1,1);
        depart3 = candtsDepart(2,1);
        departs = [depart1 depart2 depart3];
    catch
        depart1 = candtsDepart(1,1);
        depart2 = candtsDepart(1,1);
        depart3 = candtsDepart(1,1);
        departs = [depart1 depart2 depart3];
    end
    
    
%     depart1 = candtsDepart(3,1);
%     depart2 = candtsDepart(1,1);
%     depart3 = candtsDepart(2,1);
% %     depart1 = candtsDepart(1,1);
% %     depart2 = candtsDepart(1,1);
% %     depart3 = candtsDepart(1,1);
%     departs = [depart1 depart2 depart3];
    
%     disp(departs);
    
    % Seleccionar los puntos resultantes de arrival
    arrive1 = candtsArrival(1,1);
    arrive2 = candtsArrival(2,1);
    arrive3 = candtsArrival(3,1);
    arrivals = [arrive1 arrive2 arrive3];
    
%     disp(arrivals);
    
    % Recorrer los métodos diferentes, actualizando
    % los valores obtenidos de inicialización

    for aa = 1:nmetodos      
        resultados(ii, 3 + (aa-1) * 2 + 1) = departs(aa);
        resultados(ii, 3 + (aa-1) * 2 + 2) = arrivals(aa);
            
    end
        
        
end

salida = resultados;

end

