function [J grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
J = 0;
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================
% Instructions: You should complete the code by working through the
%               following parts.
%
% Part 1: Feedforward the neural network and return the cost in the
%         variable J. After implementing Part 1, you can verify that your
%         cost function computation is correct by verifying the cost
%         computed in ex4.m
%
% Expand y into matrix of values which has a 1 in the ith location if y^i is 1. The code below 
%specifies the (i,j)th component of the matrix eye(num_labels). So if e.g. y = 5 then (y, :) 
%specifies the 5th row and all columns of eye(num_labels). This would be the vector 
%[0 0 0 0 1 0 0 0 0 ]. Since y is 5000 x 1 matrix it does this 5000 times and builds Y that way


Y = eye(num_labels)(y, :);      %5000 x 10
a1 = [ones(m,1), X];    % 5000 x 401
z2 = a1*(Theta1)';     % 5000 x 25
a2 = sigmoid(z2);       % 5000 x 25
a2 = [ones(m,1), a2];    % 5000 x 26
z3 = a2*Theta2';        % 5000 x 10
a3 = sigmoid(z3);         % 5000 x 10


J = 1/m*sum(diag(-log(a3)*Y' - log(1-a3)*(1-Y)'));


Theta1(:,1) = 0;
Theta2(:,1) = 0;

J = J + (lambda/(2*m)) * (sum(sum(Theta1.^2)) + sum(sum(Theta2.^2))); 

% Part 2: Implement the backpropagation algorithm to compute the gradients
%         Theta1_grad and Theta2_grad. You should return the partial derivatives of
%         the cost function with respect to Theta1 and Theta2 in Theta1_grad and
%         Theta2_grad, respectively. After implementing Part 2, you can check
%         that your implementation is correct by running checkNNGradients
%
%         Note: The vector y passed into the function is a vector of labels
%               containing values from 1..K. You need to map this vector into a 
%               binary vector of 1's and 0's to be used with the neural network
%               cost function.
%
%         Hint: We recommend implementing backpropagation using a for-loop
%               over the training examples if you are implementing it for the 
%               first time.
%


a1 = [ones(size(X,1),1) X];
z2 = a1*Theta1';
a2 = [ones(size(z2,1),1) sigmoid(z2)];
z3 = a2*Theta2;
a3 = sigmoid(z3);

d3 = a3-Y;
d2 = d3*Theta2.*(a2.*(1-a2));
d2(:,1) = [];



%Theta1_grad = 

% Part 3: Implement regularization with the cost function and gradients.
%
%         Hint: You can implement this around the code for
%               backpropagation. That is, you can compute the gradients for
%               the regularization separately and then add them to Theta1_grad
%               and Theta2_grad from Part 2.
%










% -------------------------------------------------------------

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
