%The Boundary Term is calculated by looking at the disimilarity between
%adjacent pixels. The greater the dissimirity the higher the boundary term.

function output = boundaryTerm(I,binary)
AP = adjacentPairs(I,binary);
[nr,nc] = size(I);
EW = (zeros(nr,nc));

for r = 1:nc
    for c = 1:nr
       for  ii = 2:9
            p = AP(r,c,1);
            q = AP(r,c,ii);
            
            if(q==0)
               continue; 
            end  
      
            if(p <= q) 
                EW(r,c)= EW(r,c)+ 1;
            end

            if(p > q) 
                EW(r,c) = EW(r,c)+exp((-1.*((p-q).^2))./(2*1000));
            end
       end
    end
end
output = EW;
end