function [ output_args ] = destacarEnsayo( nombre,eje1,eje3,idArchivo,resultados,nmetodos,idActivo )
%DESTACARENSAYO Destaca el ensayo seleccionado en el gráfico
%   Y lo grafica aparte

% cla(eje3);

% Borrar datos previos
h=findobj('type','line','LineStyle','-','color',[224,224,224]./255);
delete(h);
h=findobj('type','line','LineStyle','-','color',[ 173, 172, 172 ]./255);
delete(h);
h=findobj('type','line','LineStyle','-','color',[ 132, 132, 132]./255);
delete(h);

ruta = nombre;

% Cargar datos del ensayo actual

A = dlmread(ruta,',', 3, 0);

% Separar columnas

% Tiempo (ms)
t = A(:,1) * 1000;
% t= t - t(1);
posinicial = find(t>-0.5);
posinicial = posinicial(1);
A = A(posinicial:end,:);

t = A(:,1) * 1000;
% t = t+9.9;
ndatos = length(t);

% Canal 1 (V)
ch1 = A(:,2);

% Canal 2 (V)
ch2 = A(:,3);


% Cerar datos

% t = t - t(1);
ch1 = ch1- ch1(1);
ch2 = ch2- ch2(1);

norma1 = max(abs(ch1));
norma = max(abs(ch2));

ch1 = ch1/norma1;
ch2 = ch2/norma;


% Destacar en el gráfico principal (PENDIENTE)
% plot(idArchivo+ch2*.5,t,'k','parent',eje1,'linewidth',1.5);

% Graficar en la aplicación (eje 3)
plot(t,ch1,'b','parent',eje3);
hold on

xlabel('time(ms)')
ylabel('V (mV)')

grid on

plot(t,ch2,'r','parent',eje3);

% Valor de esfuerzo seleccionado

selectedStressValue = [num2str(resultados(idActivo,2)) 'kPa'];
text(0,0,selectedStressValue,...
        'VerticalAlignment','bottom','HorizontalAlignment','center',...
        'FontWeight','Bold','FontSize',12,'parent',eje3);

legend('Channel 1, departure','Channel 4, arrival','Points')

% Graficar los diferentes métodos
p1 = (min(ch1));
p2 = (max(ch1));
puntosAux = [p1 p2];


colores = {[224,224,224]./255,...
    [ 173, 172, 172 ]./255,...
    [ 132, 132, 132]./255};

% colores = {'c--','r--','k--'};

for aa = 1:nmetodos
    
    coloractual = colores{aa};
    
    % Tiempo de salida de cada método
    tdep = resultados(idActivo,3 + (aa-1) * 2 + 1);
    % Tiempo de llegada de cada método
    tarr = resultados(idActivo,3 + (aa-1) * 2 + 2);
    
    plot([tdep tdep],puntosAux,'color',coloractual,'parent',eje3,'LineStyle','--');
    plot([tarr tarr],puntosAux,'color',coloractual,'parent',eje3,'LineStyle','--');
    
end

% figure(1)
% plot(idArchivo+ch2*.5,t,'k');


end

