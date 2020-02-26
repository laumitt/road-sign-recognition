% load data
load signs.mat

% other items to use later
scale = transfer(1);
num_pixels = transfer(2);
num_signs = transfer(3);
signs = fopen('signs_index.txt');
labels = fscanf(signs, 'r');
k_list = 1:5:25; % number of eigenvectors to use
% k_list = [10]; % simplifying for testing single images
rec = 1; % index for recording error later
tic;  % start timing

% set up training data facespace
train_r = reshape(train_data, [num_signs,(256*scale)^2]); % reshape to pixels x signs
train_m = train_r - mean(train_r); % mean center training data
train_nums = 1:num_signs; % placeholder until the text file can be read in
test_nums = 1:num_signs; % placeholder until the text file can be read in
test_r = reshape(test_data, [num_signs,(256*scale)^2]); % reshape to pixels x signs
test_m = test_r - mean(test_r); % mean center test data

% compute eigendecomposition
R = train_m.' * train_m; % find covariance matrix of pixels of training data
[V, D] = eig(R); % find eigenvectors/values of R
D_r = diag(D); % put eigenvalues in one vector
for k = k_list
    t_in_loop_start = tic; % start timing one loop
    [values, indices] = maxk(D_r, k); % choose k largest eigenvalues
    vectors = V(:,indices); % choose associated eigenvectors
    train_c = train_m * vectors; % represent training signs with chosen vectors

    % recognize faces
    test_c = test_m * vectors; % represent test signs with chosen vectors
    [close_index, distance] = knnsearch(train_c, test_c); % find closest match between test sign and training

    % compute accuracy
    matches = 0; % start from 0 matches
    for i = 1:num_signs
        if train_nums(close_index(i)) == test_nums(i) % if the indices match
            matches = matches + 1; % count this as a match
        end
    end
    per_matches(rec) = matches/num_signs * 100; % find percent accurate matches
    t_in_loop(rec) = toc(t_in_loop_start); % record how long each loop takes
    rec = rec+1;
end
% print final error
disp("Eigenvectors used");
disp(k_list);
disp("Percent accurate");
disp(per_matches);
disp("Time per loop");
disp(t_in_loop);

% plot error
figure(1);
plot(k_list, per_matches);
hold on;
plot(k_list, t_in_loop * 10000);
legend('Percent Accurate', 'Computation Time (* 1000)', 'Location', 'southeast');
xlabel('Number of eigenvectors');
title('Grayfaces Recognition Error Analysis');

% view versions of one image (original, rep, match, match rep)
a = 12; % image to show
figure(2);
colormap('gray');
subplot(221);
imagesc(reshape(test_m(a,:), [64, 64]));
title('Testing Image (Original)');
subplot(222);
imagesc(reshape(vectors*test_c(a,:).', [64, 64]));
title('Testing Image (Representation)');
subplot(223);
imagesc(reshape(train_m(a,:), [64, 64]));
title('Training Image (Original)');
subplot(224);
imagesc(reshape(vectors*train_c(a,:).', [64, 64]));
title('Training Image (Representation)');

% view eigenfaces
figure(3);
colormap('gray');
subplot(221);
imagesc(reshape(vectors(:,1), [64, 64]));
subplot(222);
imagesc(reshape(vectors(:,2), [64, 64]));
subplot(223);
imagesc(reshape(vectors(:,3), [64, 64]));
subplot(224);
imagesc(reshape(vectors(:,4), [64, 64]));