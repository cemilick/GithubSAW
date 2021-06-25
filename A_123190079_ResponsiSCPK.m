function varargout = A_123190079_ResponsiSCPK(varargin)
% A_123190079_RESPONSISCPK MATLAB code for A_123190079_ResponsiSCPK.fig
%      A_123190079_RESPONSISCPK, by itself, creates a new A_123190079_RESPONSISCPK or raises the existing
%      singleton*.
%
%      H = A_123190079_RESPONSISCPK returns the handle to a new A_123190079_RESPONSISCPK or the handle to
%      the existing singleton*.
%
%      A_123190079_RESPONSISCPK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in A_123190079_RESPONSISCPK.M with the given input arguments.
%
%      A_123190079_RESPONSISCPK('Property','Value',...) creates a new A_123190079_RESPONSISCPK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before A_123190079_ResponsiSCPK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to A_123190079_ResponsiSCPK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help A_123190079_ResponsiSCPK

% Last Modified by GUIDE v2.5 25-Jun-2021 14:44:09

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @A_123190079_ResponsiSCPK_OpeningFcn, ...
                   'gui_OutputFcn',  @A_123190079_ResponsiSCPK_OutputFcn, ...
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


% --- Executes just before A_123190079_ResponsiSCPK is made visible.
function A_123190079_ResponsiSCPK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to A_123190079_ResponsiSCPK (see VARARGIN)

% Choose default command line output for A_123190079_ResponsiSCPK
handles.output = hObject;
opts = detectImportOptions('DATA RUMAH.xlsx');
opts.SelectedVariableNames = [1,3,4,5,6,7,8];

data = readmatrix('DATA RUMAH.xlsx',opts);

set(handles.uitable1,'Data',data);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes A_123190079_ResponsiSCPK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = A_123190079_ResponsiSCPK_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function uitable1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opts = detectImportOptions('DATA RUMAH.xlsx'); %mendeteksi file DATA RUMAH.xlsx
opts.SelectedVariableNames = [3,4,5,6,7,8]; %mengambil kolom 3 sampai 8

data = readmatrix('DATA RUMAH.xlsx',opts); %menempatkan data dari excel ke var data

%nilai atribut, dimana 0= atribut biaya &1= atribut keuntungan
k=[0,1,1,1,1,1];
w=[0.30, 0.20, 0.23, 0.10, 0.07, 0.10];% bobot untuk masing-masing kriteria

%tahapan 1. normalisasi matriks
%matriks m x n dengan ukuran sebanyak variabel data (input)
[m,n]=size (data); 
R=zeros (m,n); %membuat matriks R, yang merupakan matriks kosong

for j=1:n
    if k(j)==1 %statement untuk kriteria dengan atribut keuntungan
        R(:,j)=data(:,j)./max(data(:,j));
    else
        R(:,j)=min(data(:,j))./data(:,j); %statement untuk kriteria biaya
    end
end

%tahapan kedua, proses penjumlahan dan perkalian dengan bobot sesuai
%kriteria
for i=1:m
    V(i)= sum(w.*R(i,:));
end
%proses perangkingan untuk mengurutkan
nilai = sort(V,'descend');

%memilih hanya 20 nilai terbaik (20 rumah terbaik)
for i=1:20
hasil(i) = nilai(i);
end

opts2 = detectImportOptions('DATA RUMAH.xlsx'); %mendeteksi file DATA RUMAH.xlsx
opts2.SelectedVariableNames = [2]; %memilih hanya kolom Nama Rumah

nama = readmatrix('DATA RUMAH.xlsx',opts2); %mengambil nama rumah dari file dan menyimpan di var nama

%perulangan untuk mencari nama rumah dari 20 nilai terbaik tadi
for i=1:20
 for j=1:m
   if(hasil(i) == V(j))
    rekomendasi(i) = nama(j);
    break
   end
 end
end
%melakukan transpose pada rekomendasi agar tampilan menjadi per baris
rekomendasi = rekomendasi';

set(handles.uitable2,'Data',rekomendasi);
