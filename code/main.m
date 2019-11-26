%   Code of the paper Altuve, M., & Severeyn, E. (2019). Joint analysis of
%   fasting and postprandial plasma glucose and insulin concentrations in
%   Venezuelan women. Diabetes & Metabolic Syndrome: Clinical Research &
%   Reviews, 13(3), 2242-2248. https://doi.org/10.1016/j.dsx.2019.05.029   
%   
%   Cite the data as: Altuve, M., & Severeyn, E. (2019). Fasting and
%   postprandial glucose and insulin dataset. IEEE Dataport.
%   http://dx.doi.org/10.21227/5g52-jc59    
%   
%   Author: Miguel Altuve, PhD
%   Date: December 2018
%   Email: miguelaltuve@gmail.com
%   Last updated: November 2019
%   
%   MIT License
%   Copyright (c) 2019 Miguel Altuve



% Loading data into workspace
cd ../data/
load data.mat

% Number of subjects of the database
N = length(dataoriginal.Age);
fprintf('Number of subjects in the database: %d\n', N);

% Classification of subjects based on fasting and postprandial glucose
% levels
% Identifying NFG and NGT in the database
% normal fasting glucose (NFG) condition
NFG = dataoriginal.G0 >= 70 & dataoriginal.G0 < 100;
% normal 2-hour glucose tolerance (NGT) condition
NGT = dataoriginal.G120 >= 70 & dataoriginal.G120 < 140;
% Identifying normal subjects in the database
Normal = NFG & NGT;
% Adding new table variables
dataoriginal.Normal = double(Normal);
dataoriginal.NFG = double(NFG);
dataoriginal.NGT = double(NGT);

% Identifying IFG and IGT in the database
% impaired fasting glucose (IFG)
IFG = dataoriginal.G0 >= 100 & dataoriginal.G0 < 126;
% impaired glucose tolerance (IGT)
IGT = dataoriginal.G120 >= 140 & dataoriginal.G120 < 200;
% Identifying prediabetic subjects in the database
Prediab = IFG | IGT;
% Adding new table variables
dataoriginal.Prediab = double(Prediab);
dataoriginal.IFG = double(IFG);
dataoriginal.IGT = double(IGT);

% Identifying DFG and DGT in the database
% diabetic fasting glucose (DFG)
DFG = dataoriginal.G0 >= 126;
% diabetic glucose tolerance (DGT)
DGT = dataoriginal.G120 >= 200;
% Identifying diabetic subjects in the database
Diabetes = DFG | DGT;
% Adding new table variables
dataoriginal.Diabetes = double(Diabetes);
dataoriginal.DFG = double(DFG);
dataoriginal.DGT = double(DGT);

% Classification of subjects based on fasting and postprandial insulin
% levels
% Identifying NFI, IFI, NPI and IPI in the database
% normal fasting insulin (NFI)
NFI = dataoriginal.I0 >= 2 & dataoriginal.I0 < 25;
% impaired fasting insulin (IFI)
IFI = dataoriginal.I0 >= 25;
% normal postprandial insulin (NPI)
NPI = dataoriginal.I120 >= 16 & dataoriginal.I120 < 166;
% impaired postprandial insulin (IPI)
IPI = dataoriginal.I120 >= 166;
% Adding new table variables
dataoriginal.NFI = double(NFI);
dataoriginal.IFI = double(IFI);
dataoriginal.NPI = double(NPI);
dataoriginal.IPI = double(IPI);

% The combination of conditions gives us a total of 28 different classes:
% 4 for the normal state, 12 for the prediabetic state and 12 for the
% diabetic state.

% Conditions of the normal state
N1 = NFG & NGT & NFI & NPI; dataoriginal.N1 = double(N1);
N2 = NFG & NGT & NFI & IPI; dataoriginal.N2 = double(N2);
N3 = NFG & NGT & IFI & NPI; dataoriginal.N3 = double(N3);
N4 = NFG & NGT & IFI & IPI; dataoriginal.N4 = double(N4);

% Conditions of the prediabetic state
P1 = NFG & IGT & NFI & NPI; dataoriginal.P1 = double(P1);
P2 = NFG & IGT & NFI & IPI; dataoriginal.P2 = double(P2);
P3 = NFG & IGT & IFI & NPI; dataoriginal.P3 = double(P3);
P4 = NFG & IGT & IFI & IPI; dataoriginal.P4 = double(P4);
P5 = IFG & NGT & NFI & NPI; dataoriginal.P5 = double(P5);
P6 = IFG & NGT & NFI & IPI; dataoriginal.P6 = double(P6);
P7 = IFG & NGT & IFI & NPI; dataoriginal.P7 = double(P7);
P8 = IFG & NGT & IFI & IPI; dataoriginal.P8 = double(P8);
P9 = IFG & IGT & NFI & NPI; dataoriginal.P9 = double(P9);
P10 = IFG & IGT & NFI & IPI; dataoriginal.P10 = double(P10);
P11 = IFG & IGT & IFI & NPI; dataoriginal.P11 = double(P11);
P12 = IFG & IGT & IFI & IPI; dataoriginal.P12 = double(P12);

% Conditions of the diabetic state
D1 = (NFG | IFG) & DGT & NFI & NPI; dataoriginal.D1 = double(D1);
D2 = (NFG | IFG) & DGT & NFI & IPI; dataoriginal.D2 = double(D2);
D3 = (NFG | IFG) & DGT & IFI & NPI; dataoriginal.D3 = double(D3);
D4 = (NFG | IFG) & DGT & IFI & IPI; dataoriginal.D4 = double(D4);
D5 = DFG & (NGT | IGT) & NFI & NPI; dataoriginal.D5 = double(D5);
D6 = DFG & (NGT | IGT) & NFI & IPI; dataoriginal.D6 = double(D6);
D7 = DFG & (NGT | IGT) & IFI & NPI; dataoriginal.D7 = double(D7);
D8 = DFG & (NGT | IGT) & IFI & IPI; dataoriginal.D8 = double(D8);
D9 = DFG & DGT & NFI & NPI; dataoriginal.D9 = double(D9);
D10 = DFG & DGT & NFI & IPI; dataoriginal.D10 = double(D10);
D11 = DFG & DGT & IFI & NPI; dataoriginal.D11 = double(D11);
D12 = DFG & DGT & IFI & IPI; dataoriginal.D12 = double(D12);

% saving the table for further examination
cd ../results/
writetable(dataoriginal,'resultsclassif.csv');

% Assignment of subjects to fasting and postprandial glucose conditions.
disp('Table 4: Assignment of subjects to fasting and postprandial glucose conditions.')
disp('Time: Fasting.')

% Determining the number of subjects per condition and 95% CI of the
% variables
% Fasting glucose
% Age
ClassFastGluc.age{1} = dataoriginal.Age(NFG);
ClassFastGluc.age{2} = dataoriginal.Age(IFG);
ClassFastGluc.age{3} = dataoriginal.Age(DFG);

fprintf('\nNumber of subjects per condition:\n NFG = %d \n IFG = %d \n DFG = %d \n ', ...
    length(ClassFastGluc.age{1}), length(ClassFastGluc.age{2}), length(ClassFastGluc.age{3}));

% computing CI
ciSujetosFastGluc.age = ComputConfInt(ClassFastGluc.age);
disp('Confidence Interval of Age:');
disp(ciSujetosFastGluc.age');

% Glucose
ClassFastGluc.G0{1} = dataoriginal.G0(NFG);
ClassFastGluc.G0{2} = dataoriginal.G0(IFG);
ClassFastGluc.G0{3} = dataoriginal.G0(DFG);
% computing CI
ciSujetosFastGluc.G0 = ComputConfInt(ClassFastGluc.G0);
disp('Confidence Interval of Glucose:');
disp(ciSujetosFastGluc.G0');

disp('Time: Postprandial.')
% Postprandial Glucose
% Age
ClassPospGluc.age{1} = dataoriginal.Age(NGT);
ClassPospGluc.age{2} = dataoriginal.Age(IGT);
ClassPospGluc.age{3} = dataoriginal.Age(DGT);

fprintf('\nNumber of subjects per condition:\n NGT = %d \n IGT = %d \n DGT = %d \n ', ...
    length(ClassPospGluc.age{1}), length(ClassPospGluc.age{2}), length(ClassPospGluc.age{3}));

% computing CI
ciSujetosPospGluc.age = ComputConfInt(ClassPospGluc.age);
disp('Confidence Interval of Age:');
disp(ciSujetosPospGluc.age');

% Glucose
ClassPospGluc.G120{1} = dataoriginal.G120(NGT);
ClassPospGluc.G120{2} = dataoriginal.G120(IGT);
ClassPospGluc.G120{3} = dataoriginal.G120(DGT);
% computing CI
ciSujetosPospGluc.G120 = ComputConfInt(ClassPospGluc.G120);
disp('Confidence Interval of Glucose:');
disp(ciSujetosPospGluc.G120');

% The Kruskal-Wallis nonparametric statistical test was performed to find
% significant differences in the variables of interest (age, and fasting
% and postprandial glucose and insulin values) between the different
% classes (independent samples). In addition, Tukey's honestly significant
% difference test was used as a post hoc test

disp('Kruskal-Wallis nonparametric statistical test:');

% Assigning labels to classes
clase = [char('A'*(ones(length(ClassFastGluc.age{1}),1))); char('B'*(ones(length(ClassFastGluc.age{2}),1)));char('C'*(ones(length(ClassFastGluc.age{3}),1)))];

variable = [ClassFastGluc.age{1}; ClassFastGluc.age{2}; ClassFastGluc.age{3}];
% Kruskal-Wallis test
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between age in fasting condition:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassFastGluc.G0{1}; ClassFastGluc.G0{2}; ClassFastGluc.G0{3}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between glucose in fasting condition:');
c = multcompare(stats) % Multiple comparison test

% Assigning labels to classes
clase = [char('A'*(ones(length(ClassPospGluc.age{1}),1))); char('B'*(ones(length(ClassPospGluc.age{2}),1)));char('C'*(ones(length(ClassPospGluc.age{3}),1)))];

variable = [ClassPospGluc.age{1}; ClassPospGluc.age{2}; ClassPospGluc.age{3}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between age in postprandial condition:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassPospGluc.G120{1}; ClassPospGluc.G120{2}; ClassPospGluc.G120{3}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between glucose in postprandial condition:');
c = multcompare(stats) % Multiple comparison test


% Assignment of subjects to fasting and postprandial glucose conditions.
disp('Table 5: Assignment of subjects to fasting and postprandial insulin conditions.')
disp('Time: Fasting.')

% Determining the number of subjects per condition and 95% CI of the
% variables
% Fasting insulin
% Age
ClassFastInsu.age{1} = dataoriginal.Age(NFI);
ClassFastInsu.age{2} = dataoriginal.Age(IFI);

fprintf('\nNumber of subjects per condition:\n NFI = %d \n IFI = %d \n', ...
    length(ClassFastInsu.age{1}), length(ClassFastInsu.age{2}));

% computing CI
ciSujetosFastInsu.age = ComputConfInt(ClassFastInsu.age);
disp('Confidence Interval of Age:');
disp(ciSujetosFastInsu.age');

%Insulin
ClassFastInsu.I0{1} = dataoriginal.I0(NFI);
ClassFastInsu.I0{2} = dataoriginal.I0(IFI);

% computing CI
ciSujetosFastInsu.I0 = ComputConfInt(ClassFastInsu.I0);
disp('Confidence Interval of Insulin:');
disp(ciSujetosFastInsu.I0');

disp('Time: Postprandial.')
% Postprandial Insulin
% Age
ClassPospInsu.age{1} = dataoriginal.Age(NPI);
ClassPospInsu.age{2} = dataoriginal.Age(IPI);

fprintf('\nNumber of subjects per condition:\n NPI = %d \n IPI = %d \n', ...
    length(ClassPospInsu.age{1}), length(ClassPospInsu.age{2}));

% computing CI
ciSujetosPospInsu.age = ComputConfInt(ClassPospInsu.age);
disp('Confidence Interval of age:');
disp(ciSujetosPospInsu.age');

%Insulin
ClassPospInsu.I120{1} = dataoriginal.I120(NPI);
ClassPospInsu.I120{2} = dataoriginal.I120(IPI);

ciSujetosPospInsu.I120 = ComputConfInt(ClassPospInsu.I120);
disp('Confidence Interval of Insulin:');
disp(ciSujetosPospInsu.I120');

disp('Kruskal-Wallis nonparametric statistical test:');

% Assigning labels to classes
clase = [char('A'*(ones(length(ClassFastInsu.age{1}),1))); char('B'*(ones(length(ClassFastInsu.age{2}),1)))];

variable = [ClassFastInsu.age{1}; ClassFastInsu.age{2}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between age in fasting condition:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassFastInsu.I0{1}; ClassFastInsu.I0{2}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between insulin in fasting condition:');
c = multcompare(stats) % Multiple comparison test

% Assigning labels to classes
clase = [char('A'*(ones(length(ClassPospInsu.age{1}),1))); char('B'*(ones(length(ClassPospInsu.age{2}),1)))];

variable = [ClassPospInsu.age{1}; ClassPospInsu.age{2}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between age in postprandial condition:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassPospInsu.I120{1}; ClassPospInsu.I120{2}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between insulin in postprandial condition:');
c = multcompare(stats) % Multiple comparison test


% Assignment of subjects to fasting and postprandial glucose conditions.
disp('Table 6: Assignment of subjects to the normal class.');

% Age
ClassNorm.age{1} = dataoriginal.Age(N1);
ClassNorm.age{2} = dataoriginal.Age(N2);
ClassNorm.age{3} = dataoriginal.Age(N3);
ClassNorm.age{4} = dataoriginal.Age(N4);

fprintf('\nNumber of subjects per condition:\n N1 = %d \n N2 = %d \n N3 = %d \n N4 = %d \n', ...
    length(ClassNorm.age{1}), length(ClassNorm.age{2}), length(ClassNorm.age{3}), length(ClassNorm.age{4}));

% computing CI
ciSujetosNormal.age = ComputConfInt(ClassNorm.age);
disp('Confidence Interval of age:');
disp(ciSujetosNormal.age');

% Fasting Glucose
ClassNorm.G0{1} = dataoriginal.G0(N1);
ClassNorm.G0{2} = dataoriginal.G0(N2);
ClassNorm.G0{3} = dataoriginal.G0(N3);
ClassNorm.G0{4} = dataoriginal.G0(N4);
% computing CI
ciSujetosNormal.G0 = ComputConfInt(ClassNorm.G0);
disp('Confidence Interval of fasting glucose:');
disp(ciSujetosNormal.G0');

% Postprandial Glucose
ClassNorm.G120{1} = dataoriginal.G120(N1);
ClassNorm.G120{2} = dataoriginal.G120(N2);
ClassNorm.G120{3} = dataoriginal.G120(N3);
ClassNorm.G120{4} = dataoriginal.G120(N4);
% computing CI
ciSujetosNormal.G120 = ComputConfInt(ClassNorm.G120);
disp('Confidence Interval of postprandial glucose:');
disp(ciSujetosNormal.G120');

% Fasting Insulin
ClassNorm.I0{1} = dataoriginal.I0(N1);
ClassNorm.I0{2} = dataoriginal.I0(N2);
ClassNorm.I0{3} = dataoriginal.I0(N3);
ClassNorm.I0{4} = dataoriginal.I0(N4);
% computing CI
ciSujetosNormal.I0 = ComputConfInt(ClassNorm.I0);
disp('Confidence Interval of fasting insulin:');
disp(ciSujetosNormal.I0');

% Postprandial Insulin
ClassNorm.I120{1} = dataoriginal.I120(N1);
ClassNorm.I120{2} = dataoriginal.I120(N2);
ClassNorm.I120{3} = dataoriginal.I120(N3);
ClassNorm.I120{4} = dataoriginal.I120(N4);
% computing CI
ciSujetosNormal.I120 = ComputConfInt(ClassNorm.I120);
disp('Confidence Interval of postprandial insulin:');
disp(ciSujetosNormal.I120');

disp('Kruskal-Wallis nonparametric statistical test:');

% Assigning labels to classes
clase = [char('A'*(ones(length(ClassNorm.age{1}),1))); char('B'*(ones(length(ClassNorm.age{2}),1)));char('C'*(ones(length(ClassNorm.age{3}),1))); char('D'*(ones(length(ClassNorm.age{4}),1)))];

variable = [ClassNorm.age{1}; ClassNorm.age{2}; ClassNorm.age{3};ClassNorm.age{4}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between age in normal states:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassNorm.G0{1}; ClassNorm.G0{2}; ClassNorm.G0{3};ClassNorm.G0{4}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between fasting glucose in normal states:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassNorm.G120{1}; ClassNorm.G120{2}; ClassNorm.G120{3};ClassNorm.G120{4}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between postprandial glucose in normal states:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassNorm.I0{1}; ClassNorm.I0{2}; ClassNorm.I0{3};ClassNorm.I0{4}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between fasting insulin in normal states:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassNorm.I120{1}; ClassNorm.I120{2}; ClassNorm.I120{3};ClassNorm.I120{4}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between postprandial insulin in normal states:');
c = multcompare(stats) % Multiple comparison test


% Assignment of subjects to fasting and postprandial glucose conditions.
disp('Table 7: Assignment of subjects to the prediabetic class.');

% Age
ClassPred.age{1} = dataoriginal.Age(P1);
ClassPred.age{2} = dataoriginal.Age(P2);
ClassPred.age{3} = dataoriginal.Age(P3);
ClassPred.age{4} = dataoriginal.Age(P4);
ClassPred.age{5} = dataoriginal.Age(P5);
ClassPred.age{6} = dataoriginal.Age(P6);
ClassPred.age{7} = dataoriginal.Age(P7);
ClassPred.age{8} = dataoriginal.Age(P8);
ClassPred.age{9} = dataoriginal.Age(P9);
ClassPred.age{10} = dataoriginal.Age(P10);
ClassPred.age{11} = dataoriginal.Age(P11);
ClassPred.age{12} = dataoriginal.Age(P12);

fprintf('\nNumber of subjects per condition:\n P1 = %d \n P2 = %d \n P3 = %d \n P4 = %d \n P5 = %d \n P6 = %d \n P7 = %d \n P8 = %d \n P9 = %d \n P10 = %d \n P11 = %d \n P12 = %d \n', ...
    length(ClassPred.age{1}), length(ClassPred.age{2}), length(ClassPred.age{3}), length(ClassPred.age{4}), ...
    length(ClassPred.age{5}), length(ClassPred.age{6}), length(ClassPred.age{7}), length(ClassPred.age{8}), ...
    length(ClassPred.age{9}), length(ClassPred.age{10}), length(ClassPred.age{11}), length(ClassPred.age{12}));

% computing CI
ciSujetosPrediab.age = ComputConfInt(ClassPred.age);
disp('Confidence Interval of age:');
disp(ciSujetosPrediab.age');

% Fasting glucose
ClassPred.G0{1} = dataoriginal.G0(P1);
ClassPred.G0{2} = dataoriginal.G0(P2);
ClassPred.G0{3} = dataoriginal.G0(P3);
ClassPred.G0{4} = dataoriginal.G0(P4);
ClassPred.G0{5} = dataoriginal.G0(P5);
ClassPred.G0{6} = dataoriginal.G0(P6);
ClassPred.G0{7} = dataoriginal.G0(P7);
ClassPred.G0{8} = dataoriginal.G0(P8);
ClassPred.G0{9} = dataoriginal.G0(P9);
ClassPred.G0{10} = dataoriginal.G0(P10);
ClassPred.G0{11} = dataoriginal.G0(P11);
ClassPred.G0{12} = dataoriginal.G0(P12);
% computing CI
ciSujetosPrediab.G0 = ComputConfInt(ClassPred.G0);
disp('Confidence Interval of fasting glucose:');
disp(ciSujetosPrediab.G0');

% Postprandial glucose
ClassPred.G120{1} = dataoriginal.G120(P1);
ClassPred.G120{2} = dataoriginal.G120(P2);
ClassPred.G120{3} = dataoriginal.G120(P3);
ClassPred.G120{4} = dataoriginal.G120(P4);
ClassPred.G120{5} = dataoriginal.G120(P5);
ClassPred.G120{6} = dataoriginal.G120(P6);
ClassPred.G120{7} = dataoriginal.G120(P7);
ClassPred.G120{8} = dataoriginal.G120(P8);
ClassPred.G120{9} = dataoriginal.G120(P9);
ClassPred.G120{10} = dataoriginal.G120(P10);
ClassPred.G120{11} = dataoriginal.G120(P11);
ClassPred.G120{12} = dataoriginal.G120(P12);
% computing CI
ciSujetosPrediab.G120 = ComputConfInt(ClassPred.G120);
disp('Confidence Interval of postprandial glucose:');
disp(ciSujetosPrediab.G120');

% Fasting Insulin
ClassPred.I0{1} = dataoriginal.I0(P1);
ClassPred.I0{2} = dataoriginal.I0(P2);
ClassPred.I0{3} = dataoriginal.I0(P3);
ClassPred.I0{4} = dataoriginal.I0(P4);
ClassPred.I0{5} = dataoriginal.I0(P5);
ClassPred.I0{6} = dataoriginal.I0(P6);
ClassPred.I0{7} = dataoriginal.I0(P7);
ClassPred.I0{8} = dataoriginal.I0(P8);
ClassPred.I0{9} = dataoriginal.I0(P9);
ClassPred.I0{10} = dataoriginal.I0(P10);
ClassPred.I0{11} = dataoriginal.I0(P11);
ClassPred.I0{12} = dataoriginal.I0(P12);
% computing CI
ciSujetosPrediab.I0 = ComputConfInt(ClassPred.I0);
disp('Confidence Interval of fasting insulin:');
disp(ciSujetosPrediab.I0');

% Postprandial insulin
ClassPred.I120{1} = dataoriginal.I120(P1);
ClassPred.I120{2} = dataoriginal.I120(P2);
ClassPred.I120{3} = dataoriginal.I120(P3);
ClassPred.I120{4} = dataoriginal.I120(P4);
ClassPred.I120{5} = dataoriginal.I120(P5);
ClassPred.I120{6} = dataoriginal.I120(P6);
ClassPred.I120{7} = dataoriginal.I120(P7);
ClassPred.I120{8} = dataoriginal.I120(P8);
ClassPred.I120{9} = dataoriginal.I120(P9);
ClassPred.I120{10} = dataoriginal.I120(P10);
ClassPred.I120{11} = dataoriginal.I120(P11);
ClassPred.I120{12} = dataoriginal.I120(P12);
% computing CI
ciSujetosPrediab.I120 = ComputConfInt(ClassPred.I120);
disp('Confidence Interval of postprandial insulin:');
disp(ciSujetosPrediab.I120');

disp('Kruskal-Wallis nonparametric statistical test:');

% Assigning labels to classes
clase = [char('A'*(ones(length(ClassPred.age{1}),1))); char('B'*(ones(length(ClassPred.age{2}),1)));char('C'*(ones(length(ClassPred.age{3}),1))); char('D'*(ones(length(ClassPred.age{4}),1)));...
    char('E'*(ones(length(ClassPred.age{5}),1))); char('F'*(ones(length(ClassPred.age{6}),1)));char('G'*(ones(length(ClassPred.age{7}),1))); char('H'*(ones(length(ClassPred.age{8}),1)));...
    char('I'*(ones(length(ClassPred.age{9}),1))); char('J'*(ones(length(ClassPred.age{10}),1)));char('K'*(ones(length(ClassPred.age{11}),1))); char('L'*(ones(length(ClassPred.age{12}),1)))];

variable = [ClassPred.age{1}; ClassPred.age{2}; ClassPred.age{3};ClassPred.age{4};...
    ClassPred.age{5}; ClassPred.age{6}; ClassPred.age{7};ClassPred.age{8};...
    ClassPred.age{9}; ClassPred.age{10}; ClassPred.age{11};ClassPred.age{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between age in prediabetic states:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassPred.G0{1}; ClassPred.G0{2}; ClassPred.G0{3};ClassPred.G0{4};...
    ClassPred.G0{5}; ClassPred.G0{6}; ClassPred.G0{7};ClassPred.G0{8};...
    ClassPred.G0{9}; ClassPred.G0{10}; ClassPred.G0{11};ClassPred.G0{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between fasting glucose in prediabetic states:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassPred.G120{1}; ClassPred.G120{2}; ClassPred.G120{3};ClassPred.G120{4};...
    ClassPred.G120{5}; ClassPred.G120{6}; ClassPred.G120{7};ClassPred.G120{8};...
    ClassPred.G120{9}; ClassPred.G120{10}; ClassPred.G120{11};ClassPred.G120{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between postprandial glucose in prediabetic states:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassPred.I0{1}; ClassPred.I0{2}; ClassPred.I0{3};ClassPred.I0{4};...
    ClassPred.I0{5}; ClassPred.I0{6}; ClassPred.I0{7};ClassPred.I0{8};...
    ClassPred.I0{9}; ClassPred.I0{10}; ClassPred.I0{11};ClassPred.I0{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between fasting insulin in prediabetic states:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassPred.I120{1}; ClassPred.I120{2}; ClassPred.I120{3};ClassPred.I120{4};...
    ClassPred.I120{5}; ClassPred.I120{6}; ClassPred.I120{7};ClassPred.I120{8};...
    ClassPred.I120{9}; ClassPred.I120{10}; ClassPred.I120{11};ClassPred.I120{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between postprandial insulin in prediabetic states:');
c = multcompare(stats) % Multiple comparison test


% Assignment of subjects to fasting and postprandial glucose conditions.
disp('Table 8: Assignment of subjects to the diabetic class.');

% Age
ClassDiabet.age{1} = dataoriginal.Age(D1);
ClassDiabet.age{2} = dataoriginal.Age(D2);
ClassDiabet.age{3} = dataoriginal.Age(D3);
ClassDiabet.age{4} = dataoriginal.Age(D4);
ClassDiabet.age{5} = dataoriginal.Age(D5);
ClassDiabet.age{6} = dataoriginal.Age(D6);
ClassDiabet.age{7} = dataoriginal.Age(D7);
ClassDiabet.age{8} = dataoriginal.Age(D8);
ClassDiabet.age{9} = dataoriginal.Age(D9);
ClassDiabet.age{10} = dataoriginal.Age(D10);
ClassDiabet.age{11} = dataoriginal.Age(D11);
ClassDiabet.age{12} = dataoriginal.Age(D12);

fprintf('\nNumber of subjects per condition:\n D1 = %d \n D2 = %d \n D3 = %d \n D4 = %d \n D5 = %d \n D6 = %d \n D7 = %d \n D8 = %d \n D9 = %d \n D10 = %d \n D11 = %d \n D12 = %d \n', ...
    length(ClassDiabet.age{1}), length(ClassDiabet.age{2}), length(ClassDiabet.age{3}), length(ClassDiabet.age{4}), ...
    length(ClassDiabet.age{5}), length(ClassDiabet.age{6}), length(ClassDiabet.age{7}), length(ClassDiabet.age{8}), ...
    length(ClassDiabet.age{9}), length(ClassDiabet.age{10}), length(ClassDiabet.age{11}), length(ClassDiabet.age{12}));

% computing CI
ciSujetosDiabet.age = ComputConfInt(ClassDiabet.age);
disp('Confidence Interval of age:');
disp(ciSujetosDiabet.age');

% Fasting glucose
ClassDiabet.G0{1} = dataoriginal.G0(D1);
ClassDiabet.G0{2} = dataoriginal.G0(D2);
ClassDiabet.G0{3} = dataoriginal.G0(D3);
ClassDiabet.G0{4} = dataoriginal.G0(D4);
ClassDiabet.G0{5} = dataoriginal.G0(D5);
ClassDiabet.G0{6} = dataoriginal.G0(D6);
ClassDiabet.G0{7} = dataoriginal.G0(D7);
ClassDiabet.G0{8} = dataoriginal.G0(D8);
ClassDiabet.G0{9} = dataoriginal.G0(D9);
ClassDiabet.G0{10} = dataoriginal.G0(D10);
ClassDiabet.G0{11} = dataoriginal.G0(D11);
ClassDiabet.G0{12} = dataoriginal.G0(D12);
% computing CI
ciSujetosDiabet.G0 = ComputConfInt(ClassDiabet.G0);
disp('Confidence Interval of fasting glucose:');
disp(ciSujetosDiabet.G0');

% Postprandial glucose
ClassDiabet.G120{1} = dataoriginal.G120(D1);
ClassDiabet.G120{2} = dataoriginal.G120(D2);
ClassDiabet.G120{3} = dataoriginal.G120(D3);
ClassDiabet.G120{4} = dataoriginal.G120(D4);
ClassDiabet.G120{5} = dataoriginal.G120(D5);
ClassDiabet.G120{6} = dataoriginal.G120(D6);
ClassDiabet.G120{7} = dataoriginal.G120(D7);
ClassDiabet.G120{8} = dataoriginal.G120(D8);
ClassDiabet.G120{9} = dataoriginal.G120(D9);
ClassDiabet.G120{10} = dataoriginal.G120(D10);
ClassDiabet.G120{11} = dataoriginal.G120(D11);
ClassDiabet.G120{12} = dataoriginal.G120(D12);
% computing CI
ciSujetosDiabet.G120 = ComputConfInt(ClassDiabet.G120);
disp('Confidence Interval of postprandial glucose:');
disp(ciSujetosDiabet.G120');

% Fasting Insulin
ClassDiabet.I0{1} = dataoriginal.I0(D1);
ClassDiabet.I0{2} = dataoriginal.I0(D2);
ClassDiabet.I0{3} = dataoriginal.I0(D3);
ClassDiabet.I0{4} = dataoriginal.I0(D4);
ClassDiabet.I0{5} = dataoriginal.I0(D5);
ClassDiabet.I0{6} = dataoriginal.I0(D6);
ClassDiabet.I0{7} = dataoriginal.I0(D7);
ClassDiabet.I0{8} = dataoriginal.I0(D8);
ClassDiabet.I0{9} = dataoriginal.I0(D9);
ClassDiabet.I0{10} = dataoriginal.I0(D10);
ClassDiabet.I0{11} = dataoriginal.I0(D11);
ClassDiabet.I0{12} = dataoriginal.I0(D12);
% computing CI
ciSujetosDiabet.I0 = ComputConfInt(ClassDiabet.I0);
disp('Confidence Interval of fasting insulin:');
disp(ciSujetosDiabet.I0');

% Postprandial Insulin
ClassDiabet.I120{1} = dataoriginal.I120(D1);
ClassDiabet.I120{2} = dataoriginal.I120(D2);
ClassDiabet.I120{3} = dataoriginal.I120(D3);
ClassDiabet.I120{4} = dataoriginal.I120(D4);
ClassDiabet.I120{5} = dataoriginal.I120(D5);
ClassDiabet.I120{6} = dataoriginal.I120(D6);
ClassDiabet.I120{7} = dataoriginal.I120(D7);
ClassDiabet.I120{8} = dataoriginal.I120(D8);
ClassDiabet.I120{9} = dataoriginal.I120(D9);
ClassDiabet.I120{10} = dataoriginal.I120(D10);
ClassDiabet.I120{11} = dataoriginal.I120(D11);
ClassDiabet.I120{12} = dataoriginal.I120(D12);
% computing CI
ciSujetosDiabet.I120 = ComputConfInt(ClassDiabet.I120);
disp('Confidence Interval of postprandial insulin:');
disp(ciSujetosDiabet.I120');


disp('Kruskal-Wallis nonparametric statistical test:');

% Assigning labels to classes
clase = [char('A'*(ones(length(ClassDiabet.age{1}),1))); char('B'*(ones(length(ClassDiabet.age{2}),1)));char('C'*(ones(length(ClassDiabet.age{3}),1))); char('D'*(ones(length(ClassDiabet.age{4}),1)));...
    char('E'*(ones(length(ClassDiabet.age{5}),1))); char('F'*(ones(length(ClassDiabet.age{6}),1)));char('G'*(ones(length(ClassDiabet.age{7}),1))); char('H'*(ones(length(ClassDiabet.age{8}),1)));...
    char('I'*(ones(length(ClassDiabet.age{9}),1))); char('J'*(ones(length(ClassDiabet.age{10}),1)));char('K'*(ones(length(ClassDiabet.age{11}),1))); char('L'*(ones(length(ClassDiabet.age{12}),1)))];

variable = [ClassDiabet.age{1}; ClassDiabet.age{2}; ClassDiabet.age{3};ClassDiabet.age{4};...
    ClassDiabet.age{5}; ClassDiabet.age{6}; ClassDiabet.age{7};ClassDiabet.age{8};...
    ClassDiabet.age{9}; ClassDiabet.age{10}; ClassDiabet.age{11};ClassDiabet.age{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between age in diabetic states:');
c = multcompare(stats) % Multiple comparison test

variable = [ClassDiabet.G0{1}; ClassDiabet.G0{2}; ClassDiabet.G0{3};ClassDiabet.G0{4};...
    ClassDiabet.G0{5}; ClassDiabet.G0{6}; ClassDiabet.G0{7};ClassDiabet.G0{8};...
    ClassDiabet.G0{9}; ClassDiabet.G0{10}; ClassDiabet.G0{11};ClassDiabet.G0{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between fasting glucose in diabetic states:');
c = multcompare(stats)

variable = [ClassDiabet.G120{1}; ClassDiabet.G120{2}; ClassDiabet.G120{3};ClassDiabet.G120{4};...
    ClassDiabet.G120{5}; ClassDiabet.G120{6}; ClassDiabet.G120{7};ClassDiabet.G120{8};...
    ClassDiabet.G120{9}; ClassDiabet.G120{10}; ClassDiabet.G120{11};ClassDiabet.G120{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between postprandial glucose in diabetic states:');
c = multcompare(stats)

variable = [ClassDiabet.I0{1}; ClassDiabet.I0{2}; ClassDiabet.I0{3};ClassDiabet.I0{4};...
    ClassDiabet.I0{5}; ClassDiabet.I0{6}; ClassDiabet.I0{7};ClassDiabet.I0{8};...
    ClassDiabet.I0{9}; ClassDiabet.I0{10}; ClassDiabet.I0{11};ClassDiabet.I0{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between fasting insulin in diabetic states:');
c = multcompare(stats)

variable = [ClassDiabet.I120{1}; ClassDiabet.I120{2}; ClassDiabet.I120{3};ClassDiabet.I120{4};...
    ClassDiabet.I120{5}; ClassDiabet.I120{6}; ClassDiabet.I120{7};ClassDiabet.I120{8};...
    ClassDiabet.I120{9}; ClassDiabet.I120{10}; ClassDiabet.I120{11};ClassDiabet.I120{12}];
[p,tbl,stats] = kruskalwallis(variable,clase);
disp('Significant difference between postprandial insulin in diabetic states:');
c = multcompare(stats)

close all;

% saving confidence intervals
save('ConfidenceInterval','ciSujetosDiabet','ciSujetosFastGluc','ciSujetosFastInsu',...
    'ciSujetosNormal','ciSujetosPospGluc','ciSujetosPospInsu','ciSujetosPrediab');
% saving classes
save('Classes','ClassDiabet','ClassFastGluc','ClassFastInsu','ClassNorm',...
    'ClassPospGluc','ClassPospInsu','ClassPred');

