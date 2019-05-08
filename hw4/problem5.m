A=double(imread('Lena.bmp'));
[U, S, V]=svd(A);
singvals=diag(S);
indices=find(singvals >= 0.01 * max(singvals));
U_red=U(:, indices);
S_red=S(indices, indices);
V_red=V(:, indices);
A_red=U_red * S_red * V_red';
imshow(uint8(A_red));
export_fig problem5a.pdf