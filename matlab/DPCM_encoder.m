function [quantized_error] = DPCM_encoder(img, levels)
% Perform Differential Pulse Code Modulation encoding

N = size(img,1);

predictor = zeros(N);
quantized_error = zeros(N);

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
        
        error = img(i,j) - predicted;
        quantized_error(i,j) = quantize_error(error,levels);
        predictor(i,j) = predicted + quantized_error(i,j);
    end
    
    % Read column i
    for j=(i+1):N
        if i==1
            predicted = 0.95*predictor(j-1,i);
        else
            predicted = 0.95*predictor(j-1,i) +  0.95*predictor(j,i-1) - 0.95^2*predictor(j-1,i-1);
        end
        
        error = img(j,i) - predicted;
        quantized_error(j,i) = quantize_error(error,levels);
        predictor(j,i) = predicted + quantized_error(j,i);
    end
end

end

function quantized_error = quantize_error(error, levels)
% Perform uniform quantization of the error

max=255;
min=-255;

q = (max-min)/levels;

i = 1;

while error >= min+q*i
    i=i+1;
end

quantized_error = min+q*(i-1) + q/2;

end
