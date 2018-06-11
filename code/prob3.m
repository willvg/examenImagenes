%% Examen Final
%% CE-Análisis numérico para ingeniería
%% I Semestre 2017
%% Nombre: Wilberth Varela Guillen
%% Carné: 2013053795

%% Código para problema 3

1;

pkg load image;

close all;

%% Muestre la imagen pero ajustando el contraste de forma logaritmica
function logimshow(A)

  valmax=1000;
  mn=min(A(:));
  mx=max(A(:));

  m=(valmax-1)/(mx-mn);
  b=1-m*mn;
  
  normaA=1./log(valmax);
  AA=log(m*A+b)*normaA;

  imshow(AA);
endfunction;

%% Muestre la imagen pero ajustando el contraste de forma lineal
function linimshow(A)

  mn=min(A(:));
  mx=max(A(:));

  m=1/(mx-mn);
  b=-m*mn;
  
  AA=m*double(A)+b;

  imshow(AA);
endfunction;


%% Lea la imagen a evaluar
Aorig=imread("naranjas.jpg");
figure(1);
hold off;
imshow(Aorig);

%% Extraiga los canales R,G,B
R=Aorig(:,:,1);
G=Aorig(:,:,2);
B=Aorig(:,:,3);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 3.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PONGA SU SOLUCIÓN AQUÍ:

C=double(R+G+B)/3; %% << Corrija esto

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 3.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Extraiga los bordes de la imagen de grises utilizando Canny, pero
%% ajuste los umbrales para que la detección de los bordes queden
%% claros

E=C; %% << Corrija esto
figure(2);
imshow(E);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 3.3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Programe aquí su propuesta de detección de los círculos.
%% Modularice con funciones tareas complejas.


