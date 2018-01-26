function varargout = nameplate(varargin)
% NAMEPLATE MATLAB code for nameplate.fig
%      NAMEPLATE, by itself, creates a new NAMEPLATE or raises the existing
%      singleton*.
%
%      H = NAMEPLATE returns the handle to a new NAMEPLATE or the handle to
%      the existing singleton*.
%
%      NAMEPLATE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NAMEPLATE.M with the given input arguments.
%
%      NAMEPLATE('Property','Value',...) creates a new NAMEPLATE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nameplate_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nameplate_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nameplate

% Last Modified by GUIDE v2.5 19-Jan-2018 20:58:08

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nameplate_OpeningFcn, ...
                   'gui_OutputFcn',  @nameplate_OutputFcn, ...
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


% --- Executes just before nameplate is made visible.
function nameplate_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nameplate (see VARARGIN)

% Choose default command line output for nameplate
handles.output = hObject;

global loopBoolean;
loopBoolean = true;

handles.nFrames = 80;


handles.video = VideoReader('TrainingVideo.avi');

guidata(hObject, handles);  
% uiwait(handles.figure1);


% UIWAIT makes nameplate wait
% --- Outputs from this function are returned to the command line.
function varargout = nameplate_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in startvideo.
function startvideo_Callback(hObject, eventdata, handles)
% hObject    handle to startvideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

axes(handles.axes1);

%I am taking the first frame just for testing purposes, as bounding boxes
%need to be implemented first
img = read(handles.video,1);
handles.mainTable.Data = {};
t=handles.mainTable;
% Set width and height
t.ColumnWidth{1,2} = 120;


global loopBoolean;
loopBoolean = true;


colormap(gray(2));
for i = 1:handles.nFrames
    if(loopBoolean & (i < 577 | i > 612))
        
        axes(handles.axes1);
        imageplate = getPlate(img);
        
        
        %This needs to be changed to our own OCR
        ocrRes = ocr(imageplate);
       
        result = ocrRes.Text;
        
        imageplate = getPlate(img);
        image(img);
        drawnow; 
        
        set(handles.axes1, 'Visible','off');
       
        axes(handles.axes2);
        set(handles.axes2, 'Visible','off');
        image(imageplate);
        drawnow; 
        
       
%         result = getPlate2(imageplate);
        result = '';
        
        handles.currentText.String = result;
        
        table = handles.mainTable.Data;
        table{i,1} = i;
        table{i,2} = strcat(result);
        handles.mainTable.Data = table;
        
        
        
        drawnow;
        
        
        %pause(0.05);
    end
end
guidata(hObject, handles); 



% --- Executes on button press in stopvideo.
function stopvideo_Callback(hObject, eventdata, handles)
% hObject    handle to stopvideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global loopBoolean; 
loopBoolean = false;

guidata(hObject, handles);

