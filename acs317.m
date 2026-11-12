%%%%%%%%%%%%% ACS317 Lab %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% V2020a
%% Initialisation
sslabsc;    % Initialise Simulation Model

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DO NOT MODIFY ANY LINES ABOVE
%
% Develop your programme below
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Exercise 1 - System Modelling and Analysis

% 1) Open-loop response.
%    QUESTION: Having run a step-response simulation of the open-loop
%  Simulink system, what do you conclude about the stability of the system?
%    ANSWER: STABLE/UNSTABLE (delete as appropriate)
% AV ANSWER: System is unstable

% 2) State-space model and analysis.
% Uncomment the lines below to define the state-space matrices and create
% the state-space system in matlab
A = [ 1.4, -0.2,  6.7, -5.7;
     -0.6, -4.3,  0.0,  0.7;
      1.1,  4.3, -6.7,  5.9;
      0.0,  4.3,  1.3, -2.1 ];
B = [0,0;
    5.7,0;
    1.1,-3.1;
    1.1,0];

C = [1,0,0,0;
    0,1,0,0;
    0,0,1,-1];

D = zeros(3,2);
sys = ss(A,B,C,D);  % Create state-space system

% Stability analysis
% Uncomment the line below and compute the eigenvalues of the A matrix
 eig_A = eig(A);
% QUESTION: Is your modelled system stable or unstable?
% ANSWER: UNSTABLE (delete as appropriate)

%%% AV ANSWER: System is unstable as there are positive elements of matrix

% Reachability analysis
% Uncomment the line below and compute the rank of the Reachability matrix
 rank_Wr = rank(ctrb(sys));
% QUESTION: Is your modelled system reachable or unreachable?
% ANSWER: REACHABLE (delete as appropriate)

% Observability analysis
% Uncomment the line below and compute the rank of the Observability matrix
rank_Wo = rank(obsv(sys));
% QUESTION: Is your modelled system observable or unobservable?
% ANSWER: OBSERVABLE

%% Exercise 2 - State feedback and feedforward control

% 1) State feedback gain K
% Uncomment the lines below to specify the desired eigenvalues
% and design a full state feedback control gain K
deseig = [-1 + 0.4i; -1-0.4i; -2; -3];
K = place(A,B,deseig);

% Simulation
% QUESTION: Having run a step-response simulation of the closed-loop
%  Simulink system, what do you conclude about the stability of the system?
% ANSWER: STABLE (delete as appropriate)

% Analysis
% Uncomment the line below and compute the eigenvalues of the closed-
% loop dynamics matrix
 eig_cl = eig(A-B*K);
 fprintf("A Eigen Values \n")
 disp(eig_A)
 fprintf("\n CL Eigen Values \n ")
 disp(eig_cl)
% QUESTION: How are these eigenvalues different to those of A?
% ANSWER: All eigenvalues have NEGATIVE real part (delete as appropriate)

% 2) Feedforward gain kr
% Uncomment the lines below to specify Cr and then compute kr
Cr = [1 0 1 -1     % This is the sum of the top and bottom row of C (y1+y3)
      0 1 0  0];   % ... and this is just the second row of C (y2)
n = size(A,1);  % number of states (4)
m = size(B,2);  % number of inputs = number of controlled outputs (2)
kxku = [A B; Cr zeros(m,m)]\[zeros(n,m); eye(m)];
kx = kxku(1:n,:);       % Extract kx from kxku (4x2)
ku = kxku(n+1:n+m,:);   % Extract ku from kxku (2x2)
kr = ku + K*kx;   % Construct kr from kx,ku and K (2x2)

% Simulation
% QUESTION: Having run a step-response of the closed-loop Simulink model
% with the feedforward controller, do you achieve offset-free tracking?
% ANSWER: NO (OWING TO THE MODELS NOT BEING THE SAME)
% The outputs settle close to the references but with a small steady-state
% offset. kr was designed from the identified model (A,B), but Simulink uses
% the true plant (Ao,Bo in sslabsc.m), which differs slightly. Feedforward
% has no feedback on the error, so it can't correct for model mismatch.

%% Exercise 3 - Optimal control and Integral Control

% 1) LQR control
% Uncomment the lines below to specify the penalty matrices and design a
% state feedback gain K using the lqr command
% Qx = ?;
% rho = ?;
% Qu = rho*?;
% [K,P] = lqr(?,?,?);

% Analysis
% Uncomment the line below and compute the eigenvalues of the closed-
% loop dynamics matrix 
% eig_cl = eig(?);

% Analysis
% Uncomment the line below and compute the eigenvalues of the solution, P, to the Algebraic Ricatti Equation for the LQR controller 
% eig_P = eig(?);

% Question: Is the solution to the LQR algebraic Riccati equation, P, a positive
% definite matrix?
% ANSWER: YES/NO (delete as appropriate)

% 2) Feedforward gain kr
% Uncomment the line below and compute kr
% kr = ?;

% Simulation
% QUESTION: Do you agree with the following statement: The LQR controller
% has a faster transient response (since the closed-loop poles are further
% into the left-half plane), but steady-state error persists.
% ANSWER: YES/NO (delete as appropriate)

% 3) Integral control
% Uncomment the line below to define the new Qx matrix
% Qx = [? ? ? ? ? ?
%       ? ? ? ? ? ?
%       ? ? ? ? ? ?
%       ? ? ? ? ? ?
%       ? ? ? ? ? ?
%       ? ? ? ? ? ?];

% Uncomment the lines below to define the augmented system matrices and
% augmented state-space model
% Aaug = [A zeros(?,?); -Cr zeros(?,?)];
% Baug = [B; zeros(?,?)];
% Caug = [C zeros(?,?)];
% Daug = D;
% sys_aug = ss(?,?,?,?);

% Uncomment the lines below to synthesise the LQR state feedback controller
% for the augmented sytem and check stability of the augmented system
% Kaug = lqr(?,?,?);
% eig_cl_aug = eig(?); % Check all have -ve real parts for stability

% 4) Implementation of integral control
% Uncomment the lines below to extract K and ki from Kaug, and
% re-synthesise feedforward controller kr
% K = Kaug(:,?:?);
% ki = -Kaug(:,?:?);
% kr = ?;

% Simulation
% QUESTION: Having run a step-response of the closed-loop Simulink model
% with integral control, does the steady-state error between the
% referenceinputs and reference outputs converge to zero?
% ANSWER: YES (WITH A SMALL AMOUNT OF ERROR DUE TO PLANT/MODEL MISMATCH) / NO (delete as appropriate)

%% Exercise 4 - Controller Tuning for Sustainability

% 1) Tuning the LQR for Sustainable Control
% Consider the impact of changes to the parameter rho from line 96 of this code. 
% Evaluate three cases: rho = 1e-2, rho = 1, and rho = 1e2. For each case,
% change the value in line 96, re-run this code (acs317.m), and then observe
% the response in the scopes of the simulink model (sslab.slx).

% 2) Minimising Excessive Flow Rate
% QUESTION: Does increasing the value of rho increase the maximum value of
% the control variable u1?
% ANSWER: YES/NO (delete as appropriate)

% 3) Ensuring Product Quality
% QUESTION: Does increasing the value of rho increase the integral of the error between
% the output y_{r,2} and its reference?
% ANSWER: YES/NO (delete as appropriate)

% Re-set rho = 1; in line 96 and re-run this code (acs317.m).

%% Exercise 5 - Observer design and output feedback control

% 1) Observer design
% Uncomment the lines below to specify the desired eigenvalues and design
% the observer gain matrix L
% deseig = [?; ?; ?; ?];
% L = place(?,?,?); % Refer to matlab code in lecture 18 notes (can use place or acker here)
% L = L'; % Need to take the transpose for dimensional compatibility

% Uncomment the lines below check the error dynamics (A-LC) are stable
% eig_error_dyn = eig(?);   % All e-values should have -ve real part

% 2) Observer implementation
% Simulation
% QUESTION: Having run a step-response of the closed-loop Simulink model
% with the observer, do the state estimates from the observer closely match
% the actual states?
% ANSWER: YES/NO (delete as appropriate)

% 3) Output feedback control
% Simulation
% QUESTION: Having run a step-response of the closed-loop Simulink model
% with output feedback control, do you still achieve steady-state
% offset-free reference tracking?
% ANSWER: YES/NO (delete as appropriate)

% % End
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%