load results.mat
a = 1;
b = num_signs;
r = round(a + (b-a)*rand()); % random image to show
save_all = true;
view_eigenfaces = false;

if save_all == false
    % view versions of one image (original, rep, match, match rep)
    disp('Image shown');
    disp(r);
    fig = figure(r);
    colormap('gray');
    subplot(221);
    imagesc(reshape(test_m(r,:), [n, n]));
    title('Testing Image (Mean Centered)');
    subplot(222);
    imagesc(reshape(vectors*test_c(r,:).', [n, n]));
    title('Testing Image (Representation)');
    subplot(223);
    imagesc(reshape(train_m(close_index(r),:), [n, n]));
    title('Training Image (Mean Centered)');
    subplot(224);
    imagesc(reshape(vectors*train_c(close_index(r),:).', [n, n]));
    title('Training Image (Representation)');
    
    if view_eigenfaces == true
        % view eigenfaces
        figure(2);
        colormap('gray');
        subplot(221);
        imagesc(reshape(vectors(:,1), [n, n]));
        title('Eigensign 1');
        subplot(222);
        imagesc(reshape(vectors(:,2), [n, n]));
        title('Eigensign 2');
        subplot(223);
        imagesc(reshape(vectors(:,3), [n, n]));
        title('Eigensign 3');
        subplot(224);
        imagesc(reshape(vectors(:,4), [n, n]));
        title('Eigensign 4');
    end
else
    for r = 1:num_signs
        fig = figure(r);
        colormap('gray');
        subplot(221);
        imagesc(reshape(test_m(r,:), [n, n]));
        title('Testing Image (Original)');
        subplot(222);
        imagesc(reshape(vectors*test_c(r,:).', [n, n]));
        title('Testing Image (Representation)');
        subplot(223);
        imagesc(reshape(train_m(close_index(r),:), [n, n]));
        title('Training Image (Original)');
        subplot(224);
        imagesc(reshape(vectors*train_c(close_index(r),:).', [n, n]));
        title('Training Image (Representation)');
        r_name = num2str(r);
        saveas(fig, r_name, 'png');
    end
end