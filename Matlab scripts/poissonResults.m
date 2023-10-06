function varargout = poissonResults(varargin)
% POISSONRESULTS MATLAB code for poissonResults.fig
%      POISSONRESULTS, by itself, creates a new POISSONRESULTS or raises the existing
%      singleton*.
%
%      H = POISSONRESULTS returns the handle to a new POISSONRESULTS or the handle to
%      the existing singleton*.
%
%      POISSONRESULTS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in POISSONRESULTS.M with the given input arguments.
%
%      POISSONRESULTS('Property','Value',...) creates a new POISSONRESULTS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before poissonResults_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to poissonResults_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help poissonResults

% Last Modified by GUIDE v2.5 15-Nov-2021 00:12:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @poissonResults_OpeningFcn, ...
                   'gui_OutputFcn',  @poissonResults_OutputFcn, ...
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


% --- Executes just before poissonResults is made visible.
function poissonResults_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to poissonResults (see VARARGIN)

% Choose default command line output for poissonResults
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes poissonResults wait for user response (see UIRESUME)
% uiwait(handles.figure2);


% --- Outputs from this function are returned to the command line.
function varargout = poissonResults_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1

% Handles de los ejes
axes(handles.axes1);
eje1 = gca;
hold on

axes(handles.axes2);
eje2 = gca;
hold on

% Recuperar datos
VsSel = getappdata(handles.pushbutton1,'VsSelected');
sigmas = getappdata(handles.pushbutton1,'Sigmas');
resultadosVp = getappdata(handles.pushbutton1,'VpResults');
longitud = getappdata(handles.pushbutton1,'longitudMuestra');


% Destacar método seleccionado
selecc1 = get(handles.popupmenu1,'Value');
param = 1;
VpSel = graficarResultados2( resultadosVp,eje1,selecc1,param,longitud );

poisson = graphPoisson( VpSel, VsSel, sigmas, eje2);

% Almacenar modificación
setappdata(handles.pushbutton1,'VpSelected',VpSel);
setappdata(handles.pushbutton1,'Poissons',poisson);
setappdata(handles.pushbutton1,'Poissons',poisson);


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


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2

% Handles de los ejes
axes(handles.axes1);
eje1 = gca;
hold on

axes(handles.axes2);
eje2 = gca;
hold on

% Recuperar datos
VpSel = getappdata(handles.pushbutton1,'VpSelected');
sigmas = getappdata(handles.pushbutton1,'Sigmas');
resultadosVs = getappdata(handles.pushbutton1,'VsResults');
longitud = getappdata(handles.pushbutton1,'longitudMuestra');

% Destacar método seleccionado
selecc1 = get(handles.popupmenu2,'Value');
param = 2;
VsSel = graficarResultados2( resultadosVs,eje1,selecc1,param,longitud );

poisson = graphPoisson( VpSel, VsSel, sigmas, eje2);

% Almacenar modificación
setappdata(handles.pushbutton1,'VpSelected',VpSel);
setappdata(handles.pushbutton1,'Poissons',poisson);


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

h = findobj('Tag','figure1');
handlesMain = guidata(h(end));

metodos = {'Método Peak-to-Peak','Método inicio-inicio','Vs'};
set(handles.popupmenu1,'String',metodos);
set(handles.popupmenu2,'String',metodos);

resultadosVp = getappdata(handlesMain.pushbutton2,'resultadosVp');
resultadosVs = getappdata(handlesMain.pushbutton2,'resultadosVs');
longitud = getappdata(handlesMain.pushbutton7,'longitudMuestra');


sigmas = resultadosVp(:,2);

% Handles de los ejes
axes(handles.axes1);
eje1 = gca;
hold on

xlabel('\sigma (kPa)');
ylabel('V (m/s)');

axes(handles.axes2);
eje2 = gca;
hold on

% Graficar todos losresultados
graficarResultados1( resultadosVp,eje1,longitud );
graficarResultados1( resultadosVs,eje1,longitud );

% Leer seleccionados
selecc1 = get(handles.popupmenu1,'Value');
selecc2 = get(handles.popupmenu2,'Value');

% Velocidades seleccionadas
param = 0;
VpSel = graficarResultados2( resultadosVp,eje1,selecc1,param,longitud );
VsSel = graficarResultados2( resultadosVs,eje1,selecc2,param,longitud );

poisson = graphPoisson( VpSel, VsSel, sigmas, eje2);

xlabel('\sigma (kPa)');
ylabel('Poisson ratio \nu');


setappdata(hObject,'VpResults',resultadosVp);
setappdata(hObject,'VsResults',resultadosVs);
setappdata(hObject,'MainHandles',handlesMain);
setappdata(hObject,'VpSelected',VpSel);
setappdata(hObject,'VsSelected',VsSel);
setappdata(hObject,'Sigmas',sigmas);
setappdata(hObject,'Poissons',poisson);
setappdata(handles.pushbutton1,'longitudMuestra',longitud);


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

dactual = pwd;

% Recuperar los valores del resultado
poisson = getappdata(handles.pushbutton1,'Poissons');
sigmas = getappdata(handles.pushbutton1,'Sigmas');
handlesMain = getappdata(handles.pushbutton1,'MainHandles');

% Directorio de salida
directorio= getappdata(handlesMain.pushbutton1,'directorioResultados');

resultados = [sigmas poisson];

% Escribir archivos de salida

cd(directorio);

dlmwrite('Poisson.txt',resultados);

nombre1 = 'ResultadosPoisson';
print(nombre1,'-dpng');

cd(dactual);
