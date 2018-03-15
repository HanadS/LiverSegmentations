%Creates 512 X 512 X 9 matrix where the first element is the pixel and the
% other 8 are adjacent pixels. 

function r = adjacentPairs(I,binary)
[nr,nc] = size(I);
mask = (zeros(nr,nc,9));
for c = 2:nc-2

    for r = 2:nr-2
        
       
        % If the adjacent pixels are from the same 'terminal' make the
        % element zeor.
        above = I(r - 1, c);
        if(binary(r,c) == binary(r-1,c) )
          above = 0;
        end
        
        below = I(r + 1, c);
        if(binary(r,c) == binary(r+1,c) )
          below = 0;
        end
        left = I(r , c-1);
        if(binary(r,c) == binary(r,c-1) )
          left = 0;
        end
        
        right = I(r , c+1);
        if(binary(r,c) == binary(r,c+1) )
          right = 0;
        end
        

        aboveleft = I(r-1, c-1);
        if(binary(r,c) == binary(r-1,c-1) )
          aboveleft = 0;
        end
        
        aboveright = I(r-1, c+1);
        if(binary(r,c) == binary(r-1,c+1) )
          aboveright = 0;
        end
        
        belowleft = I(r + 1, c - 1);
        if(binary(r,c) == binary(r+1,c-1) )
          belowleft = 0;
        end
        belowright = I(r + 1, c + 1);
        if(binary(r,c) == binary(r+1,c+1) )
          belowright = 0;
        end
   

        neighbors = [I(r,c),above, aboveright, right, belowright, below, belowleft, left, aboveleft];
        mask(r,c,:) = neighbors;
        
          
    end
end

r = mask;
end