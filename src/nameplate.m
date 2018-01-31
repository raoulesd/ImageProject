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
handles.alpabet = alphabet();
handles.previous = 0;
global loopBoolean;



loopBoolean = true;

handles.nFrames = 2500;

handles.percentageField.String = '0%';

handles.video = VideoReader('vid.avi');

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
tic;
axes(handles.axes1);

handles.mainTable.Data = {};
t=handles.mainTable;
% Set width and height
t.ColumnWidth{1,2} = 120;


global loopBoolean;
loopBoolean = true;
previousFrame = [[]];

resultMatrix = string([]);

colormap(gray(2));
count = 1;
for i = 1:2:handles.video.NumberOfFrames
    if(loopBoolean)

        img = read(handles.video,i);
        
        axes(handles.axes1);
        if(i/handles.video.NumberOfFrames < 0.8)
            imageplate = getPlate(img);
        end
        if(size(imageplate,1) ~= 0)
            image(img);
            drawnow; 

            set(handles.axes1, 'Visible','off');

            axes(handles.axes2);
            
            image(imageplate);
            set(handles.axes2, 'Visible','off');
            drawnow;
            
            
            
            if(i/handles.video.NumberOfFrames < 0.8)
                firstResult = getPlate2(imageplate,handles.alpabet);
            end
            
            if(size(firstResult,2) == 8)
                resultMatrix(size(resultMatrix,1) + 1,1) = firstResult;
            end
            
            
            
            
            
            if(size(resultMatrix,1) > 1)
                string1 = char(resultMatrix(size(resultMatrix,1) - 1 , 1));
                string2 = char(resultMatrix(size(resultMatrix,1), 1));
                string1(regexp(string1,'[-]'))=[];
                string2(regexp(string2,'[-]'))=[];
                if(sum(string1 == string2) < 4)
                    count = count + 1;
                    newResultMatrix = string([]);
                    newResultMatrix(1,1) = resultMatrix(size(resultMatrix,1), 1);
                    resultMatrix = newResultMatrix;
                end
            end
            
            [secondResult, resultMatrix] = analyzeResult(firstResult, resultMatrix);
            
            result = char(secondResult);

            handles.currentText.String = result;

            previousFrame = uint8(previousFrame);
            
            if( ~strcmp(handles.previous, result))
                table = handles.mainTable.Data;
                table{count,1} = result;

                table{count,2} = i;
                table{count,3} = handles.video.CurrentTime; 
                if(size(table,1) > 0)
                    emptyCells = cellfun('isempty', table); 

                    table(all(emptyCells,2),:) = [];
                end
                handles.mainTable.Data = table;
            end

            previousFrame = img;
            drawnow;


            handles.previous = result;
            handles.percentageField.String = num2str(round(i/handles.video.NumberOfFrames,3)*100) + "%";
            
        end
    end

end



guidata(hObject, handles); 



% --- Executes on button press in stopvideo.
function stopvideo_Callback(hObject, eventdata, handles)
% hObject    handle to stopvideo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
checkSolution(handles.mainTable.Data, 'sols.mat');
global loopBoolean; 
loopBoolean = false;
toc;
guidata(hObject, handles);

