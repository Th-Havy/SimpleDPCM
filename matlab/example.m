%% Load test image
figure;
lena=imread('lena.jpg');
imshow(lena); % Original image

% Extract color components
lena_red=double(lena(:,:,1));
lena_green=double(lena(:,:,2));
lena_blue=double(lena(:,:,3));

%% Test different error sampling rates on red component
QP=4;
error = DPCM_encoder(lena_red, QP);
reconstructed_4 = DPCM_decoder(error);

QP=8;
error = DPCM_encoder(lena_red, QP);
reconstructed_8 = DPCM_decoder(error);

QP=16;
error = DPCM_encoder(lena_red, QP);
reconstructed_16 = DPCM_decoder(error);


%% Display result of compressed image
figure; imshow(reconstructed_4,[]); title('Reconstruction images QP=4'); 
figure; imshow(reconstructed_8,[]); title('Reconstruction images QP=8');
figure; imshow(reconstructed_16,[]); title('Reconstruction images QP=16');

%% Result on color image
QP=16;
error = DPCM_encoder(lena_red, QP);
recon_red = DPCM_decoder(error);
error = DPCM_encoder(lena_green, QP);
recon_green = DPCM_decoder(error);
error = DPCM_encoder(lena_blue, QP);
recon_blue = DPCM_decoder(error);

% Combine three color channels and display compressed image
imshow(uint8(cat(3,recon_red, recon_green, recon_blue)));