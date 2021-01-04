% [gbest, xb] = levyPSO(@func, vars) is a function that searches for the global minimum of
% an n-Dimensional function defined in 'func' using the PSO algorithm based on Levy distribution randomization.
% It returns the global (not guaranteed) minimal value and the coordinate at which the function takes that value.
% The input to this function is designed in the similar manner of the Matlab built-in function "fminsearch()". 
% Sample syntax: [gbest, xb] = levyPSO(@func_test, [0 0], [100 100], 100, 200) for 2-D,
% [gbest, xb] = levyPSO(@func_test_3d, [0 0 0], [100 100 100], 100, 200) for 3-D function demo
% Tuning parameters are defined as follows:
% varargin = {[x1_l x2_l ... xn_l], [x1_u x2_u ... xn_u], swam_size, iter, inertia, corr_factor}
% '[x1_l x2_l ... xn_l]' states the lower bound of the search space on each dimension;
% '[x1_u x2_u ... xn_u]' states the upper bound of the search space on each dimension;
% 'swam_size' defines the number of particles in the swarm;
% 'iter' defines how many iterations users want the swarm to move within one call of this function;
% 'inertia' defines the inertia;
% 'corr_factor' defines the correction factor.


function [gbest, xb] = levyPSO(func, varargin)
% set default values
% parameters for Levy dist random number generation
if nargin < 3
    disp('Insurficient number of input variables.');
    disp('Please check the Help doc for the syntax of this function.')
    return;
end
    
swarm_size = 100;        % default swarm size is 50
iterations = 100;  % default iteration is 100
corr_factor = 2.0;
inertia = 1.0;

dim = length(varargin{1});  % determine the dimension of the function
x_l = varargin{1};
x_u = varargin{2};

alpha = 1.5;
beta = 1/2;
gamma_pool = min(0.1*ones(1,dim), (x_u-x_l)/1000);   % scale
theta = 0;               % position

switch nargin
    case 7,
        corr_factor = varargin{6};
        inertia = varargin{5};
        iterations = varargin{4};
        swarm_size = varargin{3};
    case 6,
        inertia = varargin{5};
        iterations = varargin{4};
        swarm_size = varargin{3};
    case 5,
        iterations = varargin{4};
        swarm_size = varargin{3};
    case 4
        swarm_size = varargin{3};
end

% ---- initial swarm position -----
% part_coord: particle coordinate
scaling1 = repmat(varargin{2}-varargin{1}, [swarm_size 1]); % re-shape the vector
scaling2 = repmat(varargin{1}, [swarm_size 1]);
scaling3 = repmat(varargin{2}, [swarm_size 1]);
x = rand(swarm_size,dim).*scaling1 + scaling2;   % Initial position of the swarm, uniform random is used here

% individual particle's best value so far, give a huge number if function value is big
p(1:swarm_size) = inf;    
% initial velocity
v = zeros(swarm_size,dim);     
x_best = inf*ones(swarm_size,dim);
%% Iterations
for iter = 1 : iterations
    %-- evaluating position & quality ---
    x = x + v;
    x = max(x, scaling2);
    x = min(x, scaling3);

    val = func(x);

    ID_improved = find(val < p');                   % log the particle's ID if new position is better
    x_best(ID_improved, :) = x(ID_improved, :);     % update best x1, x2, ... xn
    p(ID_improved) = val(ID_improved);              % and best value

    [gbest, particle_ID] = min(p);                  % global best position, gbest is the swarm ID
    
    for kk = 1:dim
        gamma = gamma_pool(kk);
        v(:, kk) = stblrnd(alpha, beta, gamma, theta, [1 swarm_size]).*inertia.*v(:,kk)' ...
            + corr_factor.*stblrnd(alpha, beta, gamma, theta, [1 swarm_size]).*(x_best(:,kk) - x(:, kk))' ...
            + corr_factor.*stblrnd(alpha, beta, gamma, theta, [1 swarm_size]).*(x_best(particle_ID,kk) - x(:, kk))';   %x velocity component
    end
end

xb = x(particle_ID,:);



