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

C1=double(R+G+B)/3; %% << Corrija esto

%primero ploteo los pixeles
C=double(C1)/255;

%aplico la mascara con el canal de color para sacar las naranjas
imR2=(R-G-B);
masc=(imR2>10);
imR2=imR2.*masc; 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 3.2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Extraiga los bordes de la imagen de grises utilizando Canny, pero
%% ajuste los umbrales para que la detección de los bordes queden
%% claros

%E=C; %% << Corrija esto
%aplico filtro gausiano para sacar las naranjas

fil=fspecial('gaussian',[3,3]); 
imR2=imfilter(imR2,fil); 
%ajusto el contraste para que diferenciar las naranjas
imR2 = double(imR2)/255;
imR3 = imR2;
for n=1:512,
  for m=1:341,
    imR3(m,n)=imR2(m,n)*255/32;
    if (imR3(m,n)>1)  
      imR3(m,n)=1;
    endif
  end
end

%hago canny
E = edge (imR3, "Canny");
figure(2);
imshow(E);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Problema 3.3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Programe aquí su propuesta de detección de los círculos.
%% Modularice con funciones tareas complejas.
H = houghtf(E, "circle", [1, 2]);
[r, c, Hnew] = houghpeaks(H, 10);

masc2=1-(Hnew(:,:,2));
imR=double(R).*masc2/255;
imG=double(G).*masc2/255;
imB=double(B)/255; 
imFinal=cat(3,imR,imG,imB); 
figure(3);
imshow(imFinal);
