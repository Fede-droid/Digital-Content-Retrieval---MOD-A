%% -- DCR-MOD A: Fede-droid PROGRAM --
% Author: Fede-droid
% Created: November 2023
%
% Objective: Create a custom color gradient
%
% Description:
% Given a predefined number of randomly chosen colors (6), the user selects
% the desired number of colors to use.
% 3D arrays are created to store the RGB values of each chosen color.
% Subsequently, the interpolation function begins its process with
% the previously considered colors, creating the so-called
% 'smoothing' between colors.
% Finally, the end result is displayed.
%
% Input:
% - nColors: the number of colors to be used.
%
% Output:
% - rgbMatrix: matrix representing the final 'smoothing.'
%
% Notes:
%   - If you want to use more than 6 colors, you need to
%     add a vector of length 3 representing a color in
%     RGB format, and you must also add a 3D array referring to the RGB values
%     of that color added just before.
%

% Clear the command window and workspace
clc;
clear;

% Prompt the user to enter the number of colors desired
nColors = input('Enter the number of colors you want to use: ');

% Check if the entered number of colors is valid
if nColors == 1
    % Display an error message and prompt the user again
    disp('Error: not enough colors!!.');
    nColors = input('Enter the number of colors you want to use: ');
end

% Calculate the number of columns based on the chosen number of colors
nColumns = nColors - 1;

% Set the size of each color section
dimSezione = 128;
n = dimSezione * nColumns;

% Initialize a matrix to store RGB values for each pixel
rgbMatrix = zeros(n, n, 3, 'uint8');

% Define 6 colors: red, green, blue, magenta, cyan, white
r = [255, 0, 0];
g = [0, 255, 0];
b = [0, 0, 255];
m = [255, 0, 255];
c = [0, 255, 255];
w = [255, 255, 255];


% Create a 3D matrix to store the RGB values for each color
v(:,:,1) = r;
v(:,:,2) = g;
v(:,:,3) = b;
v(:,:,4) = m;
v(:,:,5) = c;
v(:,:,6) = w;


% Define a function for linear interpolation between two colors
fun = @(x, dim, col1, col2) (x / dim) * col2 + (1 - (x / dim)) * col1;

% Initialize variables for gradient calculation
a = 1;

% Loop through each column to generate the color gradient
for x = 1:nColumns
    % Calculate the start and end indices for the current color section
    a = ((x - 1) * dimSezione) + 1; % +1 because the array starts from 1, not 0
    b = (x * dimSezione);
    
    % Loop through each pixel in the current color section
    for i = 1:n
        for j = a:b
            % Interpolate RGB values using the defined function
            rgbMatrix(i, j, 1) = fun(j - a, dimSezione, v(:, 1, x), v(:, 1, x + 1));
            rgbMatrix(i, j, 2) = fun(j - a, dimSezione, v(:, 2, x), v(:, 2, x + 1));
            rgbMatrix(i, j, 3) = fun(j - a, dimSezione, v(:, 3, x), v(:, 3, x + 1));
        end
    end
end

% Show the result
imshow(rgbMatrix, 'InitialMagnification', 'fit');



%+1 because the array starts from 1, not 0

%j è la mia colonna pixel dove sono arrivato, devo poi togliere A che è la
%sezione da 0 a dove sono quindi trovo il numero di pixel della sezione
%corrente a cui sono arrivato
