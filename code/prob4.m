%% Examen Final
%% CE-Análisis numérico para ingeniería
%% I Semestre 2017
%% Nombre: Wilberth Varela Guillen
%% Carné: 2013053795

%% Código para problema 4

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
Aorig=imread("low_contrast.jpg");
figure(1);
hold off;
imshow(Aorig);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 4.1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PONGA SU SOLUCIÓN AQUÍ:
C=Aorig; %% << Corrija el contraste
C1 = double(C)/255;
C2 = C1;

for n=1:512,
  for m=1:341,
    C2(m,n)=C1(m,n)*255/32;
    if (C2(m,n)>1)  
      C2(m,n)=1;
    endif
  end
end

figure(2);
imshow(C2);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 4.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%S=Aorig>5; %% << Mejorar esto con un método de selección de umbral
S1=Aorig;
v = zeros(1,256);

for n=1:341,
  for m=1:512,
    pos=S1(n,m);
    val=v(1,pos+1);
    %disp(val);
    res=(val+1);
    v(1,pos+1)=res;
  endfor
endfor

for n=1:256,
  if(v(1,n)==0)
    f=(n-1)/2;
    break;
  endif
endfor

S=Aorig>f;

figure(3);
imshow(S);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 4.3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

N=S; %% << Corregir esto
U= ones(5,5);
N1= imdilate(S,U);
N= N1;


figure(4);
imshow(imresize(N,[341,512]));
