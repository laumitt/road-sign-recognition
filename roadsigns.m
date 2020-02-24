% load data
load signs.mat
scaled = 256 * scale;

% set up training data facespace
train_r = reshape(train_data, [scaled^2, 37]); % reshape to pixels x signs
train_m = train_r - mean(train_r); % mean center training data
% test_r = reshape(test_data, [256*256, 37]); % reshape to pixels x signs
% test_m = test_r - mean(test_r); % mean center test data

% compute eigendecomposition
R = train_m * train_m.'; % find covariance matrix of pixels of training data
[V, D] = eig(R); % find eigenvectors/values of R
D_r = diag(D); % put eigenvalues in one vector
% % for k = k_list
%     t_in_loop_start = tic; % start timing one loop
%     [values, indices] = maxk(D_r, k); % choose k largest eigenvalues
%     vectors = V(:,indices); % choose associated eigenvectors
%     train_c = vectors.' * train_m; % represent training signs with chosen vectors
% 
%     % recognize faces
%     test_c = vectors.' * test_m; % represent test signs with chosen vectors
%     closest = knnsearch(train_c.', test_c.'); % find closest match between test sign and training
% 
%     % compute accuracy
%     matches = 0; % start from 0 matches
%     for i = 1:356
%         if subject_train(closest(i)) == subject_test(i) % if the indices match
%             matches = matches + 1; % count this as a match
%         end
%     end
%     per_matches(rec) = matches/356 * 100; % find percent accurate matches
%     t_in_loop(rec) = toc(t_in_loop_start); % record how long each loop takes
%     rec = rec+1;
% end
% % print final error
% disp("Eigenvectors used");
% disp(k_list);
% disp("Percent accurate");
% disp(per_matches);
% disp("Time per loop");
% disp(t_in_loop);