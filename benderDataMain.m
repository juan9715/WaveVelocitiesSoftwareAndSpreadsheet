function varargout = benderDataMain(varargin)
% BENDERDATAMAIN MATLAB code for benderDataMain.fig
%      BENDERDATAMAIN, by itself, creates a new BENDERDATAMAIN or raises the existing
%      singleton*.
%
%      H = BENDERDATAMAIN returns the handle to a new BENDERDATAMAIN or the handle to
%      the existing singleton*.
%
%      BENDERDATAMAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BENDERDATAMAIN.M with the given input arguments.
%
%      BENDERDATAMAIN('Property','Value',...) creates a new BENDERDATAMAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before benderDataMain_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to benderDataMain_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help benderDataMain

% Last Modified by GUIDE v2.5 16-Apr-2022 23:20:10

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @benderDataMain_OpeningFcn, ...
    'gui_OutputFcn',  @benderDataMain_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before benderDataMain is made visible.
function benderDataMain_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to benderDataMain (see VARARGIN)

% Choose default command line output for benderDataMain
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes benderDataMain wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = benderDataMain_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%*****************************************************************
%*****************************************************************

% Estas líneas se ejecutan al iniciar el programa

%*****************************************************************
%*****************************************************************

pushbutton13_Callback(handles.pushbutton13, eventdata, handles)



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%       BOTONES           %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%*****************************************************************
%*****************************************************************

% Botón 1 - Selección del programa de ensayos

%*****************************************************************
%*****************************************************************


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dactual = pwd;
dantiguo = [dactual '\CurrentSession'];
try
    rmdir(dantiguo,'s');
catch
end

% Obtener el directorio en el que se encuentran almacenados los ensayos
directorio = uigetdir('./');

% Inicializar los valores de selector Vp/Vs y de métodos
posibilidades = {'Vp','Vs'};
set(handles.popupmenu3,'String',posibilidades);

metodos = {'Método Peak-to-Peak','Método inicio-inicio','Vs'};
set(handles.popupmenu4,'String',metodos);

% Crear un directorio de trabajo, con subdirectorios P y S
dactual = pwd;
mkdir ./CurrentSession
cd('./CurrentSession');
dsession = pwd;
mkdir('./ONDAS P');
mkdir('./ONDAS S');
mkdir('./Resultados');

% Rutas de acceso a cada directorio
directorio1 = [directorio '\ONDAS P'];
directorio2 = [directorio '\ONDAS S'];
destino1 = [dsession '\ONDAS P'];
destino2 = [dsession '\ONDAS S'];
dResults = [dsession '\Resultados'];

% Archivos Ondas P
% Recuperar nombres de la lista
lista = dir(fullfile(directorio1, '*.csv'));
datos = struct2cell(lista);
noms = {datos{1,:}};

% Copiar los archivos a un directorio de trabajo
for ii = 1:length(noms)
    nomActual = noms(ii);
    nomActual = nomActual{1};
    nomActual = [directorio '\ONDAS P\' nomActual];
    copyfile(nomActual,destino1);
end

% Copiar el archivo txt
lista = dir(fullfile(directorio1, '*.txt'));
datos = struct2cell(lista);
nom = {datos{1,:}};
nom = nom{1};
nomActual = [directorio '\ONDAS P\' nom];
copyfile(nomActual,destino1);

% Archivos Ondas S
% Recuperar nombres de la lista
lista = dir(fullfile(directorio2, '*.csv'));
datos = struct2cell(lista);
noms = {datos{1,:}};

% Copiar los archivos a un directorio de trabajo
for ii = 1:length(noms)
    nomActual = noms(ii);
    nomActual = nomActual{1};
    nomActual = [directorio '\ONDAS S\' nomActual];
    copyfile(nomActual,destino2);
end

% Copiar el archivo txt
lista = dir(fullfile(directorio2, '*.txt'));
datos = struct2cell(lista);
nom = {datos{1,:}};
nom = nom{1};
nomActual = [directorio '\ONDAS S\' nom];
copyfile(nomActual,destino2);

% Almacenar el directorio de los datos a trabajar
setappdata(hObject,'directorioOrigen',directorio);
setappdata(hObject,'directorioDatos',dsession);
setappdata(hObject,'directorioDatosEnUsoVp',destino1);
setappdata(hObject,'directorioDatosEnUsoVs',destino2);
setappdata(hObject,'directorioResultados',dResults);
set(handles.text3,'String',directorio);

% Regresar al directorio de trabajo original
cd(dactual);



%*****************************************************************
%*****************************************************************

% Botón 2 - Seleccionar caso Vp/Vs

%*****************************************************************
%*****************************************************************


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Leer el valor asignado por el usuario (Vp/Vs)
caso = get(handles.popupmenu3,'String');
posiCaso = get(handles.popupmenu3,'Value');
caso = caso(posiCaso);

% Recuperar y almacenar resultados actuales si existen
resultadosVpActuales = getappdata(handles.pushbutton3,'resultadosVp');
resultadosVsActuales = getappdata(handles.pushbutton3,'resultadosVs');
% disp(length(resultadosActuales));

casoprevio = getappdata(hObject,'caso');
if(length(resultadosVpActuales) > 0)
%     if(strcmp(casoprevio,'Vp'))
        setappdata(hObject,'resultadosVp',resultadosVpActuales);
%     else
%         setappdata(hObject,'resultadosVs',resultadosVsActuales);
%     end
end

if(length(resultadosVsActuales) > 0)
%     if(strcmp(casoprevio,'Vp'))
%         setappdata(hObject,'resultadosVp',resultadosVpActuales);
%     else
        setappdata(hObject,'resultadosVs',resultadosVsActuales);
%     end
end


% Retirar archivos del directorio de trabajo P y S

dactual = pwd;
directorio = getappdata(handles.pushbutton1,'directorioDatos');
dorigen = getappdata(handles.pushbutton1,'directorioOrigen');



directorioVp = [directorio '\ONDAS P'];
dorigenVp = [dorigen '\ONDAS P'];

directorioVs = [directorio '\ONDAS S'];
dorigenVs = [dorigen '\ONDAS S'];


listaVp = dir(fullfile(directorioVp, '*.csv'));
listaVs = dir(fullfile(directorioVs, '*.csv'));

cd(directorio)

% Recuperar nombres de cada lista
datos = struct2cell(listaVp);
nomsVp = {datos{1,:}};

datos = struct2cell(listaVs);
nomsVs = {datos{1,:}};

% Almacenar la ruta del directorio de trabajo
setappdata(hObject,'laruta',directorio);

% Regresar al directorio del aplicativo y actualizar la lista de archivos
cd(dactual);

set(handles.popupmenu1,'String',nomsVp);
set(handles.popupmenu2,'String',nomsVs);
setappdata(handles.pushbutton1,'directorioDatosEnUsoVp',directorioVp);
setappdata(handles.pushbutton1,'directorioDatosEnUsoVs',directorioVs);
setappdata(hObject,'caso',caso);
set(handles.text3,'String',dorigen);

%*****************************************************************
%*****************************************************************

% Botón 3 - Inicializar el grupo Vp/Vs seleccionado

%*****************************************************************
%*****************************************************************


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

pushbutton2_Callback(handles.pushbutton2, eventdata, handles)

figure(1)
close

% Recuperar directorio de los archivos en uso
directorioVp = getappdata(handles.pushbutton1,'directorioDatosEnUsoVp');
directorioVs = getappdata(handles.pushbutton1,'directorioDatosEnUsoVs');


% Graficar los archivos en este directorio

% Graficar Vp
axes(handles.axes1);
eje = gca;
cla(eje);

hold on

B = grafAlineamiento(directorioVp,eje);
set(eje,'ydir','reverse');
xlabel('ID/Amplitude','parent',eje);
ylabel('Time (ms)','parent',eje)


% Graficar Vs
C = grafAlineamientoVs(directorioVs,eje);


metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

numensayosVp = length(B);
numensayosVs = length(C);


% Destacar el archivo seleccionado por defecto

axes(handles.axes2);
eje2 = gca;
cla(eje2);
hold on

xlabel('\sigma (kPa)');
ylabel('V (m/s)');

axes(handles.axes3);
eje3 = gca;
cla(eje3);

% Si ya existen los resultados, recuperarlos
% De lo contrario, crearlos

caso = getappdata(handles.pushbutton2,'caso');

if(strcmp(caso,'Vp'))
    resultadosVp = getappdata(handles.pushbutton2,'resultadosVp');
    resultadosVs = getappdata(handles.pushbutton2,'resultadosVs');

end

% Inicializar si es el caso

% Vp
if(length(resultadosVp) == 0)
    
    % Crear vectores de salida
    
    resultadosVp = zeros(numensayosVp,2+2*nmetodos);
    
    % Número del nombre archivo
    resultadosVp(:,1) = B(:,2);
    % Valor del esfuerzo asociado
    resultadosVp(:,2) = B(:,1);
    % Id (coordenada x) asociada
    resultadosVp(:,3) = B(:,3);
    
    for aa = 1:length(metodos)
        
        % Tiempo de salida de cada método
        columna1 = 3 + (aa-1) * 2 + 1;
        % Tiempo de llegada de cada método
        columna2 = 3 + (aa-1) * 2 + 2;
        
        for ii = 1:numensayosVp
            
            % Tiempo de salida de cada método
            %         resultados(ii,columna1) = aa;
            resultadosVp(ii,columna1) = aa/10;
            % Tiempo de llegada de cada método
            %         resultados(ii,columna2) = ii;
            resultadosVp(ii,columna2) = 3*(aa/10);
            
        end
    end
    
    resultadosVp = inicializacion(resultadosVp,directorioVp);
    
end


% Vs
if(length(resultadosVs) == 0)
    
    % Crear vectores de salida
    
    resultadosVs = zeros(numensayosVs,2+2*nmetodos);
    
    % Número del nombre archivo
    resultadosVs(:,1) = B(:,2);
    % Valor del esfuerzo asociado
    resultadosVs(:,2) = B(:,1);
    % Id (coordenada x) asociada
    resultadosVs(:,3) = B(:,3);
    
    for aa = 1:length(metodos)
        
        % Tiempo de salida de cada método
        columna1 = 3 + (aa-1) * 2 + 1;
        % Tiempo de llegada de cada método
        columna2 = 3 + (aa-1) * 2 + 2;
        
        for ii = 1:numensayosVs
            
            % Tiempo de salida de cada método
            %         resultados(ii,columna1) = aa;
            resultadosVs(ii,columna1) = aa/10;
            % Tiempo de llegada de cada método
            %         resultados(ii,columna2) = ii;
            resultadosVs(ii,columna2) = 3*(aa/10);
            
        end
    end
    
    resultadosVs = inicializacion(resultadosVs,directorioVs);
    
end

longitud = getappdata(handles.pushbutton7,'longitudMuestra');
graficarLineasOrigenDestino(resultadosVp,eje,eje2,longitud);
graficarLineasOrigenDestinoVs(resultadosVs,eje,eje2,longitud);
setappdata(handles.pushbutton3,'resultadosVp',resultadosVp);
setappdata(handles.pushbutton3,'resultadosVs',resultadosVs);

% Recuperar el archivo del fichero seleccionado y destacarlo en los
% gráficos
idActivo = get(handles.popupmenu1,'Value');
activo = get(handles.popupmenu1,'String');
activo = activo{idActivo};
% disp(activo);
activo = [directorioVp '\' activo];
idArchivo = find(resultadosVp(:,1)==idActivo);
idActivo = idArchivo(1);
idArchivo = resultadosVp(idActivo,3);


destacarEnsayo(activo,eje,eje3,idArchivo,resultadosVp,nmetodos,idActivo);

figure(1)
set(gca,'FontSize',18)
xlabel('ID/Amplitude','FontWeight','bold','FontSize',18);
ylabel('Time (ms)','FontWeight','bold','FontSize',18);

h = findobj('Tag','popupmenu1');
popupmenu1_Callback(h, eventdata, handles)

h = findobj('Tag','popupmenu2');
popupmenu2_Callback(h, eventdata, handles)

%*****************************************************************
%*****************************************************************

% Botón 4 - Inicialización manual de valores t_arrival

%*****************************************************************
%*****************************************************************


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

figure(1)

% Recuperar vectores existentes de resultados y metodos
resultadosVp = getappdata(handles.pushbutton3,'resultadosVp');
metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

% Finalización manual de la inicialización
prompt = 'Número de puntos a introducir:';
dlgtitle = 'Inicialización';
dims = [1 35];
definput = {'5'};
npuntos = inputdlg(prompt,dlgtitle,dims,definput);
npuntos = str2double(npuntos);

puntos = ginput(npuntos);

% Stick de los puntos a los ensayos vecinos
for ii=1:npuntos
    id = round(puntos(ii,1));
    ides = resultadosVp(:,3);
    ensayosCercanos = find(ides == id);
%     disp(ensayosCercanos);
    
    % Recorrer los métodos diferentes, actualizando
    % los valores obtenidos de inicialización

    for aa = 1:nmetodos              
        resultadosVp(ensayosCercanos, 3 + (aa-1) * 2 + 2) = puntos(ii,2);
            
    end
    
end

% Actualizar los gráficos

axes(handles.axes1);
eje = gca;

axes(handles.axes2);
eje2 = gca;
hold on

longitud = getappdata(handles.pushbutton7,'longitudMuestra');
graficarLineasOrigenDestino(resultadosVp,eje,eje2,longitud);

% Persistir los cambios
setappdata(handles.pushbutton3,'resultadosVp',resultadosVp);


%*****************************************************************
%*****************************************************************

% Botón 5 - Especificar manualmente tarrival de ensayo actual

%*****************************************************************
%*****************************************************************



% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%*****************************************************************
%*****************************************************************

% Recuperar vectores existentes de resultados y metodos
resultadosVp = getappdata(handles.pushbutton3,'resultadosVp');
metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

% Leer ensayo activo
idActivo = get(handles.popupmenu1,'Value');
idArchivo = find(resultadosVp(:,1)==idActivo);

axes(handles.axes3);
eje3 = gca;

puntos = ginput(nmetodos);
npuntos = length(puntos);

% Stick de los puntos a los ensayos vecinos
for ii=1:npuntos
    
    % Recorrer los métodos diferentes, actualizando
    % los valores obtenidos de inicialización
    
    %     for aa = 1:nmetodos
    resultadosVp(idArchivo, 3 + (ii-1) * 2 + 2) = puntos(ii,1);
    
    %     end
    
end


axes(handles.axes2);
eje2 = gca;

axes(handles.axes1);
eje1 = gca;

setappdata(handles.pushbutton3,'resultadosVp',resultadosVp);

h = findobj('Tag','popupmenu1');
popupmenu1_Callback(h, eventdata, handles)


%*****************************************************************
%*****************************************************************

% Botón 6 - Persistencia de la sesión actual

%*****************************************************************
%*****************************************************************

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dactual = pwd;

% Recuperar el directorio de salida y otros de interés
dorigen = getappdata(handles.pushbutton1,'directorioOrigen');
dsession = getappdata(handles.pushbutton1,'directorioDatos');
directorio = getappdata(handles.pushbutton1,'directorioResultados');
cd(directorio);

% Recuperar los resultados de la sesión
resultsVp = getappdata(handles.pushbutton2,'resultadosVp');
resultsVs = getappdata(handles.pushbutton2,'resultadosVs');

% Escribir archivos de salida

nombre = 'Directorio origen.txt';
fid = fopen(nombre,'wt');
dorigen2 = strrep(dorigen,'\','-');
fprintf(fid,dorigen2);
fclose(fid);

nombre = 'Resultados Vp.txt';
dlmwrite(nombre,resultsVp,'delimiter','\t');

nombre = 'Resultados Vs.txt';
dlmwrite(nombre,resultsVs,'delimiter','\t');

nombre1 = 'Resultados';
print(nombre1,'-dpng');


% Copiar archivos
% Destino
cd(dsession);
cd('../');
mkdir('./Last Session');
cd('./Last Session')
dsalida = pwd;
mkdir('./ONDAS P');
mkdir('./ONDAS S');
mkdir('./Resultados');

% Rutas de acceso a cada directorio
dorigen1 = [dsession '\ONDAS P'];
dorigen2 = [dsession '\ONDAS S'];
dorigen3 = [dsession '\Resultados'];
destino1 = [dsalida '\ONDAS P'];
destino2 = [dsalida '\ONDAS S'];
destino3 = [dsalida '\Resultados'];

% Archivos Ondas P

% Recuperar nombres de la lista
lista = dir(fullfile(dorigen1,'*.csv'));
datos = struct2cell(lista);
noms1 = {datos{1,:}};

lista = dir(fullfile(dorigen1,'*.txt'));
datos = struct2cell(lista);
noms2 = {datos{1,:}};

noms = [noms1 noms2];

% Copiar los archivos al directorio de persistencia
for ii = 1:length(noms)
    nomActual = noms(ii);
    nomActual = nomActual{1};
%     nomActual = [directorio '\ONDAS P\' nomActual];
    nomActual = [dorigen1 '\' nomActual];
    copyfile(nomActual,destino1);
end

% Archivos Ondas S

% Recuperar nombres de la lista
lista = dir(fullfile(dorigen2,'*.csv'));
datos = struct2cell(lista);
noms1 = {datos{1,:}};

lista = dir(fullfile(dorigen2,'*.txt'));
datos = struct2cell(lista);
noms2 = {datos{1,:}};

noms = [noms1 noms2];

% Copiar los archivos al directorio de persistencia
for ii = 1:length(noms)
    nomActual = noms(ii);
    nomActual = nomActual{1};
    nomActual = [dorigen2 '\' nomActual];
    copyfile(nomActual,destino2);
end

% Archivos Resultados

% Recuperar nombres de la lista
lista = dir(fullfile(dorigen3,'*.csv'));
datos = struct2cell(lista);
noms1 = {datos{1,:}};

lista = dir(fullfile(dorigen3,'*.txt'));
datos = struct2cell(lista);
noms2 = {datos{1,:}};

lista = dir(fullfile(dorigen3,'*.png'));
datos = struct2cell(lista);
noms3 = {datos{1,:}};

noms = [noms1 noms2 noms3];

% Copiar los archivos al directorio de persistencia
for ii = 1:length(noms)
    nomActual = noms(ii);
    nomActual = nomActual{1};
    nomActual = [dorigen3 '\' nomActual];
    copyfile(nomActual,destino3);
end


cd(dactual);

%*****************************************************************
%*****************************************************************

% Botón 7 - Procesamiento resultados Vp y Vs

%*****************************************************************
%*****************************************************************


% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

poissonResults;


%*****************************************************************
%*****************************************************************

% Botón 8 - Abrir sesión antigua

%*****************************************************************
%*****************************************************************

% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dactual = pwd;

% Recuperar el directorio de la sesión antigua que se desea abrir
directorio = uigetdir('./');

dantiguo = [dactual '\CurrentSession'];
disp(dantiguo);

try
    rmdir(dantiguo,'s');
catch
end

% Inicializar los valores de selector Vp/Vs y de métodos
posibilidades = {'Vp','Vs'};
set(handles.popupmenu3,'String',posibilidades);

metodos = {'Método Peak-to-Peak','Método inicio-inicio','Vs'};
set(handles.popupmenu4,'String',metodos);

% Crear un directorio de trabajo, con subdirectorios P y S
dactual = pwd;
mkdir ./CurrentSession
cd('./CurrentSession');
dsession = pwd;
mkdir('./ONDAS P');
mkdir('./ONDAS S');
mkdir('./Resultados');

% Rutas de acceso a cada directorio
dorigen1 = [directorio '\ONDAS P'];
dorigen2 = [directorio '\ONDAS S'];
dorigen3 = [directorio '\Resultados'];
destino1 = [dsession '\ONDAS P'];
destino2 = [dsession '\ONDAS S'];
destino3 = [dsession '\Resultados'];

% Copiar los archivos

% Archivos Ondas P

% Recuperar nombres de la lista
lista = dir(fullfile(dorigen1,'*.csv'));
datos = struct2cell(lista);
noms1 = {datos{1,:}};

lista = dir(fullfile(dorigen1,'*.txt'));
datos = struct2cell(lista);
noms2 = {datos{1,:}};

noms = [noms1 noms2];

% Copiar los archivos al directorio de trabajo
for ii = 1:length(noms)
    nomActual = noms(ii);
    nomActual = nomActual{1};
    nomActual = [dorigen1 '\' nomActual];
    copyfile(nomActual,destino1);
end

% Archivos Ondas S

% Recuperar nombres de la lista
lista = dir(fullfile(dorigen2,'*.csv'));
datos = struct2cell(lista);
noms1 = {datos{1,:}};

lista = dir(fullfile(dorigen2,'*.txt'));
datos = struct2cell(lista);
noms2 = {datos{1,:}};

noms = [noms1 noms2];

% Copiar los archivos al directorio de trabajo
for ii = 1:length(noms)
    nomActual = noms(ii);
    nomActual = nomActual{1};
    nomActual = [dorigen2 '\' nomActual];
    copyfile(nomActual,destino2);
end

% Archivos Resultados

% Recuperar nombres de la lista
lista = dir(fullfile(dorigen3,'*.csv'));
datos = struct2cell(lista);
noms1 = {datos{1,:}};

lista = dir(fullfile(dorigen3,'*.txt'));
datos = struct2cell(lista);
noms2 = {datos{1,:}};

noms = [noms1 noms2];

% Copiar los archivos al directorio de trabajo
for ii = 1:length(noms)
    nomActual = noms(ii);
    nomActual = nomActual{1};
    nomActual = [dorigen3 '\' nomActual];
    copyfile(nomActual,destino3);
end

cd(destino3);

% Recuperar el directorio original de los archivos
fid = fopen('Directorio origen.txt');
data = textscan(fid,'%s');
fclose(fid);
dorigen = strjoin(data{:});
dorigen = strrep(dorigen,'-','\');
disp(dorigen);

% Recuperar los resultados
resultsVp = load('Resultados Vp.txt');
resultsVs = load('Resultados Vs.txt');

setappdata(handles.pushbutton2,'resultadosVp',resultsVp);
setappdata(handles.pushbutton2,'resultadosVs',resultsVs);

% Almacenar el directorio de los datos a trabajar
setappdata(handles.pushbutton1,'directorioOrigen',dorigen);
setappdata(handles.pushbutton1,'directorioDatos',dsession);
setappdata(handles.pushbutton1,'directorioDatosEnUso',dsession);
setappdata(handles.pushbutton1,'directorioResultados',destino3);
set(handles.text3,'String',dorigen);


cd(dactual);

%*****************************************************************
%*****************************************************************

% Botón 9 - Redimensionar límites ejes

%*****************************************************************
%*****************************************************************

% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Ejes de trabajo
axes(handles.axes1);
eje1 = gca;

axes(handles.axes3);
eje3 = gca;

axes(handles.axes4);
eje4 = gca;

% Límites del eje 1
limite5 = get(handles.edit5,'String');
limite5 = str2double(limite5);

limite6 = get(handles.edit6,'String');
limite6 = str2double(limite6);

lims1 = [limite5 limite6];

% Límites del eje 2
limite1 = get(handles.edit1,'String');
limite1 = str2double(limite1);

limite2 = get(handles.edit2,'String');
limite2 = str2double(limite2);

limite3 = get(handles.edit3,'String');
limite3 = str2double(limite3);

limite4 = get(handles.edit4,'String');
limite4 = str2double(limite4);

lims2 = [limite1 limite2 limite3 limite4];

% Límites del eje 4
limite8 = get(handles.edit8,'String');
limite8 = str2double(limite8);

limite9 = get(handles.edit9,'String');
limite9 = str2double(limite9);

lims3 =[limite8 limite9];

redibujar( lims1, lims2, lims3, eje1, eje3, eje4);


%*****************************************************************
%*****************************************************************

% Botón 10 - Corregir inicialización del punto de partida

%*****************************************************************
%*****************************************************************

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Recuperar el vector de resultados y el de metodos
resultadosVp = getappdata(handles.pushbutton3,'resultadosVp');
metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

% Handle del eje 1
axes(handles.axes1);
eje1 = gca;

% Handle del eje 2
axes(handles.axes2);
eje2 = gca;

% Recuperar las coordenadas de los 3 puntos
figure(1)
puntos = ginput(nmetodos);
npuntos = length(puntos);

valores = zeros(nmetodos,1);

% Recuperar valores iniciales
for aa = 1:nmetodos
    valores(aa) = resultadosVp(1, 3 + (aa-1) * 2 + 1);
end


% Stick de los puntos a los ensayos vecinos
for ii=1:npuntos
    % Coordenada y introducida
    yref = puntos(ii,2);
%     Valor más cercano
    differences = abs(valores - yref);
    closesty = find(differences == min(differences));
    
    disp(closesty);
    
    closesty = valores(closesty);  
        
    % Recorrer los métodos diferentes, actualizando
    % los valores obtenidos de inicialización

    for aa = 1:nmetodos              
        resultadosVp(:, 3 + (ii-1) * 2 + 1) = closesty;
            
    end
    
end

longitud = getappdata(handles.pushbutton7,'longitudMuestra');
graficarLineasOrigenDestino(resultadosVp,eje1,eje2,longitud);

% Actualizar el vector de resultados con los cambios obtenidos
setappdata(handles.pushbutton3,'resultadosVp',resultadosVp);

%*****************************************************************
%*****************************************************************

% Botón 11 - Inicializar puntos de depart

%*****************************************************************
%*****************************************************************

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Recuperar el vector de resultados y el de metodos
resultadosVp = getappdata(handles.pushbutton3,'resultadosVp');
metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

% Handle del eje 1
axes(handles.axes1);
eje1 = gca;

% Handle del eje 2
axes(handles.axes2);
eje2 = gca;

% Recuperar las coordenadas de los 3 puntos
figure(1)
puntos = ginput(nmetodos);
npuntos = length(puntos);

valores = zeros(nmetodos,1);

% Recuperar valores iniciales
for aa = 1:nmetodos
    valores(aa) = resultadosVp(1, 3 + (aa-1) * 2 + 1);
end

% Actualizar resultados con valor punto inicial
for ii=1:npuntos
    % Coordenada y introducida
    yref = puntos(ii,2);  
        
    % Recorrer los métodos diferentes, actualizando
    % los valores obtenidos de inicialización

    for aa = 1:nmetodos              
        resultadosVp(:, 3 + (ii-1) * 2 + 1) = yref;
            
    end
    
end

longitud = getappdata(handles.pushbutton7,'longitudMuestra');
graficarLineasOrigenDestino(resultados,eje1,eje2,longitud);

% Actualizar el vector de resultados con los cambios obtenidos
setappdata(handles.pushbutton3,'resultadosVp',resultadosVp);


%*****************************************************************
%*****************************************************************

% Botón 12 - Especificar manualmente tdepart de ensayo actual

%*****************************************************************
%*****************************************************************

% --- Executes on button press in pushbutton12.
function pushbutton12_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Recuperar vectores existentes de resultados y metodos
resultadosVp = getappdata(handles.pushbutton3,'resultadosVp');
metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

% Leer ensayo activo
idActivo = get(handles.popupmenu1,'Value');
idArchivo = find(resultados(:,1)==idActivo);

axes(handles.axes3);
eje3 = gca;

puntos = ginput(nmetodos);
npuntos = length(puntos);

% Stick de los puntos a los ensayos vecinos
for ii=1:npuntos
    
    % Recorrer los métodos diferentes, actualizando
    % los valores obtenidos de inicialización
    
    %     for aa = 1:nmetodos
    resultadosVp(idArchivo, 3 + (ii-1) * 2 + 1) = puntos(ii,1);
    
    %     end
    
end

axes(handles.axes2);
eje2 = gca;

axes(handles.axes1);
eje1 = gca;

setappdata(handles.pushbutton3,'resultadosVp',resultadosVp);

h = findobj('Tag','popupmenu1');
popupmenu1_Callback(h, eventdata, handles)

%*****************************************************************
%*****************************************************************

% Botón 13 - Especificar longitud de la muestra

%*****************************************************************
%*****************************************************************

% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Leer el valor de longitud especificado en la interfaz
longitud = get(handles.edit7,'String');
longitud = str2double(longitud)/100;

setappdata(handles.pushbutton7,'longitudMuestra',longitud);

%*****************************************************************
%*****************************************************************

% Botón 14 - Inicialización manual de valores t_arrival (Vs)

%*****************************************************************
%*****************************************************************

% --- Executes on button press in pushbutton14.
function pushbutton14_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


figure(1)

% Recuperar vectores existentes de resultados y metodos
resultadosVs = getappdata(handles.pushbutton3,'resultadosVs');
metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

% Finalización manual de la inicialización
prompt = 'Número de puntos a introducir:';
dlgtitle = 'Inicialización';
dims = [1 35];
definput = {'5'};
npuntos = inputdlg(prompt,dlgtitle,dims,definput);
npuntos = str2double(npuntos);

puntos = ginput(npuntos);

% Stick de los puntos a los ensayos vecinos
for ii=1:npuntos
    id = round(puntos(ii,1));
    ides = resultadosVs(:,3);
    ensayosCercanos = find(ides == id);
%     disp(ensayosCercanos);
    
    % Recorrer los métodos diferentes, actualizando
    % los valores obtenidos de inicialización

    for aa = 1:nmetodos              
        resultadosVs(ensayosCercanos, 3 + (aa-1) * 2 + 2) = puntos(ii,2);
            
    end
    
end

% Actualizar los gráficos

axes(handles.axes1);
eje = gca;

axes(handles.axes2);
eje2 = gca;
hold on

longitud = getappdata(handles.pushbutton7,'longitudMuestra');
graficarLineasOrigenDestinoVs(resultadosVs,eje,eje2,longitud);

% Persistir los cambios
setappdata(handles.pushbutton3,'resultadosVs',resultadosVs);


%*****************************************************************
%*****************************************************************

% Botón 15 - Especificar manualmente tarrival de ensayo actual (Vs)

%*****************************************************************
%*****************************************************************


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Recuperar vectores existentes de resultados y metodos
resultadosVs = getappdata(handles.pushbutton3,'resultadosVs');
metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

% Leer ensayo activo
idActivo = get(handles.popupmenu2,'Value');
idArchivo = find(resultadosVs(:,1)==idActivo);

axes(handles.axes4);
eje4 = gca;

puntos = ginput(nmetodos);
npuntos = length(puntos);

% Stick de los puntos a los ensayos vecinos
for ii=1:npuntos
    
    % Recorrer los métodos diferentes, actualizando
    % los valores obtenidos de inicialización
    
    %     for aa = 1:nmetodos
    resultadosVs(idArchivo, 3 + (ii-1) * 2 + 2) = puntos(ii,1);
    
    %     end
    
end


axes(handles.axes2);
eje2 = gca;

axes(handles.axes1);
eje1 = gca;

setappdata(handles.pushbutton3,'resultadosVs',resultadosVs);

h = findobj('Tag','popupmenu2');
popupmenu2_Callback(h, eventdata, handles)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%    POP UP MENUS         %%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%*****************************************************************
%*****************************************************************

% PopUpMenu 1 - Selección del archivo del ensayo activo (Vp)

%*****************************************************************
%*****************************************************************


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% Recuperar directorio de los archivos en uso
directorio = getappdata(handles.pushbutton1,'directorioDatosEnUsoVp');

% Recuperar vectores existentes de resultados y metodos
resultadosVp = getappdata(handles.pushbutton3,'resultadosVp');
resultadosVs = getappdata(handles.pushbutton3,'resultadosVs');
metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

% Destacar el archivo seleccionado por defecto
axes(handles.axes1);
eje = gca;

axes(handles.axes2);
eje2 = gca;

axes(handles.axes3);
eje3 = gca;
cla(eje3);

idActivo = get(hObject,'Value');
activo = get(hObject,'String');
activo = activo{idActivo};
activo = [directorio '\' activo];
idArchivo = find(resultadosVp(:,1)==idActivo);
idActivo = idArchivo(1);
idArchivo = resultadosVp(idActivo,3);

% Actualizar lo gráficos
destacarEnsayo(activo,eje,eje3,idArchivo,resultadosVp,nmetodos,idActivo);
longitud = getappdata(handles.pushbutton7,'longitudMuestra');
graficarLineasOrigenDestino(resultadosVp,eje,eje2,longitud);
graficarLineasOrigenDestinoVs(resultadosVs,eje,eje2,longitud);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%*****************************************************************
%*****************************************************************

% PopUpMenu 2 - Selección del archivo del ensayo activo (Vs)

%*****************************************************************
%*****************************************************************



% --- Executes on selection change in popupmenu3.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% Recuperar directorio de los archivos en uso
directorio = getappdata(handles.pushbutton1,'directorioDatosEnUsoVs');

% Recuperar vectores existentes de resultados y metodos
resultadosVp = getappdata(handles.pushbutton3,'resultadosVp');
resultadosVs = getappdata(handles.pushbutton3,'resultadosVs');
metodos = get(handles.popupmenu4,'String');
nmetodos = length(metodos);

% Destacar el archivo seleccionado por defecto
axes(handles.axes1);
eje = gca;

axes(handles.axes2);
eje2 = gca;

axes(handles.axes4);
eje4 = gca;
cla(eje4);

idActivo = get(hObject,'Value');
activo = get(hObject,'String');
activo = activo{idActivo};
activo = [directorio '\' activo];
idArchivo = find(resultadosVs(:,1)==idActivo);
idActivo = idArchivo(1);
idArchivo = resultadosVs(idActivo,3);

% Actualizar lo gráficos
destacarEnsayoVs(activo,eje,eje4,idArchivo,resultadosVs,nmetodos,idActivo);
longitud = getappdata(handles.pushbutton7,'longitudMuestra');
graficarLineasOrigenDestino(resultadosVp,eje,eje2,longitud);
graficarLineasOrigenDestinoVs(resultadosVs,eje,eje2,longitud);


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%*****************************************************************
%*****************************************************************

% PopUpMenu 3 - Selección del archivo del método activo

%*****************************************************************
%*****************************************************************



% --- Executes on selection change in popupmenu2.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%*****************************************************************
%*****************************************************************

% PopUpMenu 3 - Selección del Vp/Vs. Mantenido por compatibilidad

%*****************************************************************
%*****************************************************************


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4


% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%    EDIT BOXES        %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%*****************************************************************
%*****************************************************************

%*****************************************************************
%*****************************************************************

% Edit box 1 - Límite Y inferior, eje 3

%*****************************************************************
%*****************************************************************


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%*****************************************************************
%*****************************************************************

% Edit box 2 - Límite Y superior, eje 3

%*****************************************************************
%*****************************************************************

function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%*****************************************************************
%*****************************************************************

% Edit box 3 - Límite X inferior, eje 3

%*****************************************************************
%*****************************************************************

function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%*****************************************************************
%*****************************************************************

% Edit box 4 - Límite X superior, eje 3

%*****************************************************************
%*****************************************************************

function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%*****************************************************************
%*****************************************************************

% Edit box 5 - Límite Y superior, eje 1

%*****************************************************************
%*****************************************************************


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%*****************************************************************
%*****************************************************************

% Edit box 6 - Límite Y inferior, eje 1

%*****************************************************************
%*****************************************************************

function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double

% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%*****************************************************************
%*****************************************************************

% Edit box 7 - Logitud de la muestra

%*****************************************************************
%*****************************************************************


function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%*****************************************************************
%*****************************************************************

% Edit box 9 - Límite Y superior, eje 4

%*****************************************************************
%*****************************************************************



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%*****************************************************************
%*****************************************************************

% Edit box 8 - Límite Y inferior, eje 4

%*****************************************************************
%*****************************************************************


function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
