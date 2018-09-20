function img = DPCM_decoder(error)

N = size(error,1);

img = zeros(N);

predictor = zeros(N);

% We read the image row1, column1, row2, column2, row3, ... because the
% predictor uses the adjacent elements in the previous row and column
for i=1:N
    % Read row i
    for j=i:N
        if i==1
            if j==1
                predicted = 0;
            else
                predicted = 0.95*predictor(i,j-1);
            end
        else
            predicted = 0.95*predictor(i-1,j) +  0.95*predictor(i,j-1) - 0.95^2*predictor(i-1,j-1);
        end
        
        img(i,j) = predicted + error(i,j);
        predictor(i,j) = predicted + error(i,j);
    end
    
    % Read column i
    for j=(i+1):N
        if i==1
            predicted = 0.95*predictor(j-1,i);
        else
            predicted = 0.95*predictor(j-1,i) +  0.95*predictor(j,i-1) - 0.95^2*predictor(j-1,i-1);
        end
        
        img(j,i) = predicted + error(j,i);
        predictor(j,i) = predicted + error(j,i);
    end
end

end