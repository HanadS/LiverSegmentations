%RegionTerm is caluclated by determining the intensity distribution of an
%image and then taking the negative likelihood of each pixel. 

function output = regionTerm(I,binary,background,obj_mean,obj_sd,bkg_mean,bkg_sd)
[nr,nc] = size(I);
regionTerm_object = -1.*(log(normpdf(I,obj_mean,obj_sd)));
regionTerm_background = -1.*(log(normpdf(background,bkg_mean,bkg_sd)));
mask = (zeros(nr,nc));

for r = 1:nc-1
    for c = 1:nr-1
  
               if (binary(r,c) == 0 ) 
                    mask(r,c) = (0.01).*regionTerm_background(r,c); % Fraction of background region term is taken to increase contrast 
               end

               if (binary(r,c) == 1)
                   mask(r,c) = regionTerm_object(r,c);
               end
    end
end
output = mask;
end