function varargout = MyGUI(varargin)
% MYGUI MATLAB code for MyGUI.fig
%      MYGUI, by itself, creates a new MYGUI or raises the existing
%      singleton*.
%
%      H = MYGUI returns the handle to a new MYGUI or the handle to
%      the existing singleton*.
%
%      MYGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYGUI.M with the given input arguments.
%
%      MYGUI('Property','Value',...) creates a new MYGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before MyGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to MyGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help MyGUI

% Last Modified by GUIDE v2.5 30-Aug-2020 12:25:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @MyGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @MyGUI_OutputFcn, ...
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


% --- Executes just before MyGUI is made visible.
function MyGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to MyGUI (see VARARGIN)

% Choose default command line output for MyGUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes MyGUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = MyGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
detect = get(handles.pnlMethod,'SelectedObject');
selectedOp = get(detect,'String');

faceDetector = vision.CascadeObjectDetector;
detector = mtcnn.Detector();

if strcmp(selectedOp,'Viola–Jones')==1
    [file,path] = uigetfile('*');
    if isequal(file,0)
       msgbox('Choose nothing!!', 'Error','error');
    else
       O =  imread(fullfile(path,file));
       I = imread(fullfile(path,file));
       [r c b]= size(I);
         if b==3
           I = rgb2gray(I);
         end 
       
       bboxes = faceDetector(I);
       [face posValue] = size(bboxes);
       
       if face~=0
           IFaces = insertObjectAnnotation(O,'rectangle',bboxes,'Face');   
           figure(1),imshow(IFaces,'Border','loose');
           title('Detected faces');
       else
           figure(1),imshow(O,'Border','loose');
           title('There is no face at this image');
       end    
    end

    
elseif strcmp(selectedOp,'MTCNN')==1
    [file,path] = uigetfile('*');
    if isequal(file,0)
       msgbox('Choose nothing!!', 'Error','error');
    else
        
        im = imread(fullfile(path,file));
         [r c b]= size(im);
         if b~=3
           im = cat(3, im, im, im);
         end 
         [bboxes, scores, landmarks] = detector.detect(im);
         if numel(scores)~=0
              displayIm = insertObjectAnnotation(im, "rectangle", bboxes, scores, "LineWidth", 2);
              figure(1),imshow(displayIm,'Border','loose');
              title('Detected faces');
              hold on
              for iFace = 1:numel(scores)
                  scatter(landmarks(iFace, :, 1), landmarks(iFace, :, 2), 'filled');
              end
              hold off
              
         else
             figure(1),imshow(im,'Border','loose');
             title('There is no face at this image');   
        end
    end

    
    
end    
   

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
global i;
detect = get(handles.pnlMethod,'SelectedObject');
selectedOp = get(detect,'String');

faceDetector = vision.CascadeObjectDetector;
detector = mtcnn.Detector();

if strcmp(selectedOp,'Viola–Jones')==1
    [file,path] = uigetfile('*.mp4');
    if isequal(file,0)
       msgbox('Choose nothing!!', 'Error','error');
    else
        xyloObj = VideoReader(fullfile(path,file));
        fig_obj = figure(1);
        set(fig_obj,'CloseRequestFcn',@my_closereq);
        
        i=1;
       
            while hasFrame(xyloObj) && i==1
                I = readFrame(xyloObj);
                bboxes = faceDetector(I);
                IFaces = insertObjectAnnotation(I,'rectangle',bboxes,'Face');
               
                fig_obj;imshow(IFaces,'Border','loose');
                
            end
    end
    
elseif strcmp(selectedOp,'MTCNN')==1
    [file,path] = uigetfile('*');
    if isequal(file,0)
       msgbox('Choose nothing!!', 'Error','error');
    else
       xyloObj = VideoReader(fullfile(path,file));
       fig_obj = figure(1);
       set(fig_obj,'CloseRequestFcn',@my_closereq);
        
       i=1;
            while hasFrame(xyloObj) && i==1  
                    im = readFrame(xyloObj);
                    [bboxes, scores, landmarks] = detector.detect(im);
                    if numel(scores)~=0   
                        displayIm = insertObjectAnnotation(im, "rectangle", bboxes, scores, "LineWidth", 2);
                        fig_obj;imshow(displayIm,'Border','loose');
                    
                        hold on
                        for iFace = 1:numel(scores)
                            scatter(landmarks(iFace, :, 1), landmarks(iFace, :, 2), 'filled');
                        end
                        pause(0.00001);
                        hold off
                    else
                         figure(1);imshow(readFrame(xyloObj));
                        
                   end
            end
            
    end      
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
global i;
detect = get(handles.pnlMethod,'SelectedObject');
selectedOp = get(detect,'String');
faceDetector = vision.CascadeObjectDetector;
detector = mtcnn.Detector();

if strcmp(selectedOp,'Viola–Jones')==1
    clear cam;

    cam = webcam;

    fig_obj = figure(1);
    fig_obj.Resize='off';

    disp(fig_obj);
    global i
    i=1;

    k = 1;
    set(fig_obj,'CloseRequestFcn',@my_closereq);

        while 1==i
            cam.Resolution = '320x240';
            videoFrame = snapshot(cam);
            I = videoFrame;
            bboxes = faceDetector(I);
            IFaces = insertObjectAnnotation(I,'rectangle',bboxes,'Face');   
            fig_obj;imshow(IFaces,'Border','loose');
        end    

elseif strcmp(selectedOp,'MTCNN')==1
    clear cam;
    
    cam = webcam;

    fig_obj = figure(1);
    fig_obj.Resize='off';

  
    global i
    i=1;

    set(fig_obj,'CloseRequestFcn',@my_closereq);

        while 1==i
             cam.Resolution = '320x240';
            videoFrame = snapshot(cam);
            im = videoFrame;
            [bboxes, scores, landmarks] = detector.detect(im);
            if numel(scores)~=0  
                displayIm = insertObjectAnnotation(im, "rectangle", bboxes, scores, "LineWidth", 2);
                fig_obj;imshow(displayIm,'Border','loose');
                 hold on
                 for iFace = 1:numel(scores)
                     scatter(landmarks(iFace, :, 1), landmarks(iFace, :, 2), 'filled');
                 end
                 pause(0.00001);
                 hold off
                 
            else
                figure(1),imshow(videoFrame,'Border','loose');
            end
        end
        
        hold off
        delete(get(gca,'Children'))
        
     
end 
    
   





function my_closereq(src,callbackdata)
    global i;
   selection = questdlg('Close This Figure?',...
      'Close Request Function',...
      'Yes','No','Yes'); 
   switch selection 
      case 'Yes'         
         delete(gcf)
         i=2;
      case 'No'
      return 
   end

