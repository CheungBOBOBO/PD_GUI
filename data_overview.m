function varargout = data_overview(varargin)
% DATA_OVERVIEW MATLAB code for data_overview.fig
%      DATA_OVERVIEW, by itself, creates a new DATA_OVERVIEW or raises the existing
%      singleton*.
%
%      H = DATA_OVERVIEW returns the handle to a new DATA_OVERVIEW or the handle to
%      the existing singleton*.
%
%      DATA_OVERVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DATA_OVERVIEW.M with the given input arguments.
%
%      DATA_OVERVIEW('Property','Value',...) creates a new DATA_OVERVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before data_overview_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to data_overview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help data_overview

% Last Modified by GUIDE v2.5 08-May-2018 15:29:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @data_overview_OpeningFcn, ...
                   'gui_OutputFcn',  @data_overview_OutputFcn, ...
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


% --- Executes just before data_overview is made visible.
function data_overview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to data_overview (see VARARGIN)

% Choose default command line output for data_overview
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes data_overview wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = data_overview_OutputFcn(hObject, eventdata, handles) 
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
[table_cell] = database_status();
set(handles.tt, 'data', table_cell(:,1:7));  % ǰ4���ǵص㣬��5���ļ�����6��7��ϵͳ���˹���ע�ķŵ������8 is location
handles.table_cell = table_cell;
guidata(hObject, handles);


% --- Executes when selected cell(s) is changed in tt.
function tt_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to tt (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)

%display(eventdata.Indices);
t_row = eventdata.Indices(1);
t_col = eventdata.Indices(1);
handles.t_row = t_row;
handles.t_col = t_col;

table_cell = handles.table_cell;
file_path = table_cell(t_row,8)
handles.file_path = file_path;
setappdata(0, 'file_path', file_path);
guidata(hObject, handles);


% --- Executes on button press in single.
function single_Callback(hObject, eventdata, handles)
% hObject    handle to single (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
single_pd_mtx;


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
full_name = handles.file_path;

save_name = full_name{1};
save_name(1)='F';
save_name(length(save_name)-2:length(save_name))='fig';

%savefig(save_name);
openfig(save_name)
