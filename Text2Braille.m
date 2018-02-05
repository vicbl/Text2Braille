function varargout = Text2Braille(varargin)
% DEMOGUI MATLAB code for Text2Braille.fig
%      DEMOGUI, by itself, creates a new DEMOGUI or raises the existing
%      singleton*.
%
%      H = DEMOGUI returns the handle to a new DEMOGUI or the handle to
%      the existing singleton*.
%
%      DEMOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEMOGUI.M with the given input arguments.
%
%      DEMOGUI('Property','Value',...) creates a new DEMOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Text2Braille_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Text2Braille_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Text2Braille

% Last Modified by GUIDE v2.5 01-Feb-2018 09:53:16

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @Text2Braille_OpeningFcn, ...
    'gui_OutputFcn',  @Text2Braille_OutputFcn, ...
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


addpath(genpath('./text2braille-utils/text2braille-src/'));
% End initialization code - DO NOT EDIT


% --- Executes just before Text2Braille is made visible.
function Text2Braille_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Text2Braille (see VARARGIN)

% Choose default command line output for Text2Braille
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Text2Braille wait for user response (see UIRESUME)
% uiwait(handles.figure1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Initialize variables and GUI items
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
global myImage;
myImage = [];
set(handles.axes1,'YTick',[]);
set(handles.axes1,'XTick',[]);
set(handles.axes2,'YTick',[]);
set(handles.axes2,'XTick',[]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Outputs from this function are returned to the command line.
function varargout = Text2Braille_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{4} = handles.output;


% --- Executes on button press in LoadImage.
function LoadImage_Callback(hObject, eventdata, handles)
% hObject    handle to LoadImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Load image after clicking button
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[FileName,PathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
    '*.*','All Files' },'Select image files only!');
global myImage;
myImage = imread(fullfile(PathName,FileName));
axes(handles.axes1);
set(handles.imName, 'String', FileName);
imshow(myImage);
set(handles.Convert,'Enable','on');




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on key press with focus on LoadImage and none of its controls.
function LoadImage_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to LoadImage (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in SaveImage.
function Convert_Callback(hObject, eventdata, handles)
% hObject    handle to SaveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global myImage;
global myImageBraille;
global fichierTexte;
%%%
wait = waitbar(0,'Conversion en cours');
% We turn the interface off for processing.
InterfaceObj=findobj(handles.figure1,'Enable','on');
set(InterfaceObj,'Enable','off');
tStart = tic;
[myImageBraille,fichierTexte]=text2braille(myImage,wait);
tElapsed = toc(tStart);
set(handles.time, 'String',  sprintf('%i s',round(tElapsed,3)));
axes(handles.axes2);
imshow(myImageBraille);

set(InterfaceObj,'Enable','on');
set(handles.Convert,'Enable','off');
set(handles.SaveImage,'Enable','on');
set(handles.saveText,'Enable','on');






% --- Executes on button press in SaveImage.
function SaveImage_Callback(hObject, eventdata, handles)
% hObject    handle to SaveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global myImageBraille;
fn = get(handles.imName,'string');
[FileName,PathName]=uiputfile('braille.jpg','Enregistrer image en braille');
imwrite(myImageBraille,fullfile(PathName,FileName),'jpg');







% --- Executes on button press in saveText.
function saveText_Callback(hObject, eventdata, handles)
% hObject    handle to saveText (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fichierTexte;
[FileName,PathName]=uiputfile('braille.txt','Enregistrer fichier texte');
fichierTxt = fopen(fullfile(PathName,FileName), 'wt');
fprintf(fichierTxt,'%s\n',fichierTexte{:});
fclose(fichierTxt);
