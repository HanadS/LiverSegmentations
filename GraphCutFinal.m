%Graph Cut Implementation
%Input:I- CT abdominal image of type dcm
%output: binary segmentation


function output = GraphCutFinal(I)

image = dicomread(I);

[nr,nc] = size(image);
segmentation = (zeros(nr,nc));



%denoise the image
G=fspecial('gaussian',15,2.5);


image = filter2(G,image);

%create the adaptive threshold
image_mean = mean_function(image);
image_sd = SD_function(image);

thresholded_object = (image > 1070) & (image < 1150 );
binary_object = bwareafilt(thresholded_object,1);
binary_background = imcomplement(binary_object);

doubleimage = double(image);
background = binary_background.*doubleimage;
object = binary_object.*doubleimage;

object_mean = (mean2(nonzeros(object)));
object_sd = (std2(nonzeros(object)));

background_mean = (mean2(nonzeros(background)));
background_sd = (std2(nonzeros(background)));


thresholded_object = (image > object_mean-object_sd) & (image < object_mean+object_sd );
binary_object = bwareafilt(thresholded_object,1);




RegionTerm = regionTerm(doubleimage,binary_object,background,object_mean,object_sd,background_mean,background_sd);
BoundaryTerm = boundaryTerm(doubleimage,binary_object);

 %Sum the Boundary Term and the Region Term
for kk = 1:nc-1
    for jj = 1:nr-1
         r =jj;
         c=kk;
                segmentation(r,c) = BoundaryTerm(r,c)+RegionTerm(r,c);
              
    end
end


%fill in the holes in the object and binerize the image
fill = imfill(segmentation);
segmentation = im2bw(fill);
output = segmentation;
end