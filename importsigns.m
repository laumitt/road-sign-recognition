% file import code adapted from
% https://matlab.fandom.com/wiki/FAQ#How_can_I_process_a_sequence_of_files.3F
% and https://www.mathworks.com/matlabcentral/answers/77062-how-to-store-images-in-a-single-array-or-matrix

scale = 0.5;
num_pixels = (256*scale)^2;
num_signs = 43;
n = sqrt(num_pixels);

% training data
train_data = ones(num_pixels,num_signs);
for img_num = 1:num_signs
	% Create an image filename, and read it in to a variable called imageData.
	train_file = strcat('Signs\train\img', num2str(img_num), '.png');
	if exist(train_file, 'file')
		img = imread(train_file);
        img_gray = (0.2989*img(:,:,1)) + (0.5870*img(:,:,2)) + (0.1140*img(:,:,3));
        img_small = imresize(img_gray, scale);
        img_reshape = reshape(img_small, [num_pixels, 1]);
        for row = 1:num_pixels
            train_data(row, img_num) = img_small(row);
        end
	else
		fprintf('File %s does not exist.\n', train_file);
    end
end

% testing data
test_data = ones(num_pixels,num_signs);
for img_num = 1:num_signs
	% Create an image filename, and read it in to a variable called imageData.
	test_file = strcat('Signs\test\test', num2str(img_num), '.png');
	if exist(test_file, 'file')
		img = imread(test_file);
        img_gray = (0.2989*img(:,:,1)) + (0.5870*img(:,:,2)) + (0.1140*img(:,:,3));
        img_small = imresize(img_gray, scale);
        img_reshape = reshape(img_small, [num_pixels, 1]);
        for row = 1:num_pixels
            test_data(row, img_num) = img_small(row);
        end
	else
		fprintf('File %s does not exist.\n', train_file);
    end
end

save signs.mat scale num_pixels num_signs n train_data test_data