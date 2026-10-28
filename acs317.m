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
% A = [ ? ? ? ?
%       ? ? ? ?
%       ? ? ? ?
%       ? ? ? ?];    
% B = [? ?
%      ? ?
%      ? ?
%      ? ?];
% C = [? ? ? ?
%      ? ? ? ?
%      ? ? ? ?];
% D = [? ?
%      ? ?
%      ? ?];
% sys = ss(?,?,?,?);  % Create state-space system

% Stability analysis
% Uncomment the line below and compute the eigenvalues of the A matrix
% eig_A = eig(?);
% QUESTION: Is your modelled system stable or unstable?
% ANSWER: STABLE/UNSTABLE (delete as appropriate)

% Reachability analysis
% Uncomment the line below and compute the rank of the Reachability matrix
% rank_Wr = rank(ctrb(?,?));
% QUESTION: Is your modelled system reachable or unreachable?
% ANSWER: REACHABLE/UNREACHABLE (delete as appropriate)

% Observability analysis
% Uncomment the line below and compute the rank of the Observability matrix
% rank_Wo = rank(obsv(?,?));
% QUESTION: Is your modelled system observable or unobservable?
% ANSWER: OBSERVABLE/UNOBSERVABLE

%% Exercise 2 - State feedback and feedforward control

% 1) State feedback gain K
% Uncomment the lines below to specify the desired eigenvalues
% and design a full state feedback control gain K
% deseig = [?; ?; ?; ?];
% K = place(?,?,?);

% Simulation
% QUESTION: Having run a step-response simulation of the closed-loop
%  Simulink system, what do you conclude about the stability of the system?
% ANSWER: STABLE/UNSTABLE (delete as appropriate)

% Analysis
% Uncomment the line below and compute the eigenvalues of the closed-
% loop dynamics matrix
% eig_cl = eig(A-B*?);
% QUESTION: How are these eigenvalues different to those of A?
% ANSWER: All eigenavlues have NEGATIVE/POSITIVE real part (delete as appropriate)

% 2) Feedforward gain kr
% Uncomment the lines below to specify Cr and then compute kr
% Cr = [? ? ? ?     % This is the sum of the top and bottom row of C (y1+y3)
%       ? ? ? ?];   % ... and this is just the second row of C (y2) 
% kxku = [A B; Cr zeros(?,?)]\[zeros(?,?); eye(?)];
% kx = kxku(?:?,:);     % Extract kx from kxku
% ku = kxku(?:?,:);     % Extract ku from kxku
% kr = ?;   % Construct kr from kx,ku and K

% Simulation
% QUESTION: Having run a step-response of the closed-loop Simulink model
% with the feedforward controller, do you achieve offset-free tracking?
% ANSWER: YES / NO (OWING TO THE MODELS NOT BEING THE SAME) (delete as appropriate)

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