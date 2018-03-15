%Level Set implementation from Chumming Li et al
%Input:I- CT abdominal image of type bmp, ROI - bmp image with red contour
%output: binary segmentation


function output = LevelSet(I,ROI)

 X = ['I is  ',I];
disp(X);
Img = double(imread(I));

iter_outer        = 50;
sigma             = 2.5;
timestep = 1;
mu                = 0.02;
iter_inner = 100;
lambda            = 5;                          % coefficient of the weighted length term L(phi)

alfa               = 1.5;
epsilon           = 1.5;                        % papramater that specifies the width of the DiracDelta function
potentialFunction = 'double-well';              % default choice of potential function

G=fspecial('gaussian',15,sigma);
Img_smooth=conv2(Img,G,'same');                 % smooth image by Gaussiin convolution
[Ix,Iy]=gradient(Img_smooth);
f=Ix.^2+Iy.^2;

g = 1./(1+f);           
         


c           = -2;
initphi     = c*ones(size(ROI(:,:,1)));
f           = find((ROI(:,:,1) == 255) & (ROI(:,:,2) == 0) & (ROI(:,:,3)== 0));         % red  channel with value 255 for an initial contour 
initphi(f)  = -c;  
phi         = initphi;




for n=1:iter_outer                              % start level set evolution
    phi = drlse_edge(phi, g, lambda, mu, alfa, epsilon, timestep, iter_inner, potentialFunction);
   
end

phibw2 = im2bw(phi);


output = phibw2;

end
