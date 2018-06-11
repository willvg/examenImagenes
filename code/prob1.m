%% Examen Final
%% CE-Análisis numérico para ingeniería
%% I Semestre 2017
%% Nombre: Wilberth Varela Guillen
%% Carné: 2013053795

%% Código para problema 1

1;

pkg load image;

%% Lea una imagen en grises normalizados
Aorig=imread("lenna.png");
A=double(Aorig)/255;

%% Implementación ingenua de la transformación
%% ADVERTENCIA: Este código es altamente ineficiente
function O=naive(I,T)
  c=columns(I);
  r=rows(I);
  O=zeros(r,c);
  % Para cada pixel de la imagen de entrada
  for y=1:r
    for x=1:c
      p=[x;y;1];
      q=T*p; % Calcule a cuál pixel se debe mapear (x,y)
      if ( (q(1)>=1) && (q(1)<=c) && (q(2)>=1) && (q(2)<=r) )
        % Cópielo en la imagen de salida, solo si es válido
        O(round(q(2)),round(q(1)))=I(y,x);
      endif        
    endfor;
  endfor;
endfunction;

%% Su solución al problema debe ir aquí
function O=smart(I,T)
  c=columns(I);
  r=rows(I);
  O=zeros(r,c);
  
   % Para cada pixel de la imagen de entrada
  for y=1:r
    for x=1:c
      p=[x;y;1];
      q=T*p; % Calcule a cuál pixel se debe mapear (x,y)
      if ( (q(1)>=1) && (q(1)<=c)  && (q(2)>=1) && (q(2)<=r) )
        % Cópielo en la imagen de salida, solo si es válido
        O(round(q(2)),round(q(1)))=I(y,x);
      endif        
    endfor;
  endfor;

  for y=1:r
    for x=1:c
      if ((x==1) && (y==1))
        O(y,x)=O(y+3,x+3);
      elseif ( (x==c) || (y==r) )
        O(y,x)=O(y,x);
      elseif( (x>1) && (y>1) && (x<c-1) && (y<r-1) )
        p=O(y,x-1);
        %q=T*p; % Calcule a cuál pixel se debe mapear (x,y)
        if ( (O(y,x)==0) && (p>0) && (O(y,x+1)>0))
          % Cópielo en la imagen de salida, solo si es válido
          O(y,x)=O(y,x-1);
        endif
      endif        
    endfor;
  endfor;
  %% INCLUYA SU SOLUCIÓN AL PROBLEMA 1 AQUÍ

endfunction;


%% Construyendo una transformación sobre el centro de la imagen

%% Primer desplazamiento hacia cero
T0 = [1 0 -columns(A)/2;
      0 1 -rows(A)/2;
      0 0 1];

%% Invertir desplazamiento 
T1 = inv(T0);

%% Transformación prototipo
TP = [ 0.9 -0.5 0;
       1    0.7 0;
       0    0   1];

%% Transformación completa
T=T1*TP*T0;

%% Ejemplo aproximado de cómo debe verse la transformación
tic;
N=naive(A,T);
toc;

%% Calculando la solución propuesta
S=smart(A,T);

figure(1);
imshow(A);

figure(2);
imshow(N);

figure(3);
imshow(S);
