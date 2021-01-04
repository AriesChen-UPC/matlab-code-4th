[gbest, xb] = levyPSO(@func, vars) is a function that searches for the global minimum of
an n-Dimensional function defined in 'func' using the PSO algorithm based on Levy distribution randomization.
It returns the global (not guaranteed) minimal value and the coordinate at which the function takes that value.
The input to this function is designed in the similar manner of the Matlab built-in function "fminsearch()". 
Sample syntax: [gbest, xb] = levyPSO(@func_test, [0 0], [100 100], 100, 200) for 2-D,
[gbest, xb] = levyPSO(@func_test_3d, [0 0 0], [100 100 100], 100, 200) for 3-D function demo
Tuning parameters are defined as follows:
varargin = {[x1_l x2_l ... xn_l], [x1_u x2_u ... xn_u], swam_size, iter, inertia, corr_factor}
'[x1_l x2_l ... xn_l]' states the lower bound of the search space on each dimension;
'[x1_u x2_u ... xn_u]' states the upper bound of the search space on each dimension;
'swam_size' defines the number of particles in the swarm;
'iter' defines how many iterations users want the swarm to move within one call of this function;
'inertia' defines the inertia;
'corr_factor' defines the correction factor.



To run this function, add the "STBL_CODE" folder to the Matlab path, write your function to be minimized in the same format as the attached test_function().

-----
The performance of this function is tested on the attached test functions. It is compatitive with "fminsearch()" and "GOAT()" in terms of the target hitting rate (locate global minimum successfully), better than the built-in "particleswarm()" (2014b). Faster than GOAT().


-----
Acknowledgement: 
Alpha-Stable distributions in MATLAB
http://www.mathworks.com/matlabcentral/fileexchange/37514-stbl--alpha-stable-distributions-for-matlab
http://math.bu.edu/people/mveillet/html/alphastablepub.html

Prof.Dingyu Xue, 		http://www.researchgate.net/profile/Dingyu_Xue
Prof.Yangquan Chen,		http://mechatronics.ucmerced.edu/



