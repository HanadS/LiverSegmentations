function output  = SD_function(I)
mask = zeros(8,8);
cellmean=mat2tiles(I,[64,64]);
for j = 1:8
    for i = 1:8
        cell_test2 = cell2mat((cellmean(i,j)));
        mask(i,j) = std2(cell_test2);
    end
end

output = mask;
end
