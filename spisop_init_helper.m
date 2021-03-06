function [pathInputFolder pathOutputFolder] =  spisop_init_helper(pathPrefix,inputFolderName,outputFolderName,parallelComputation,numParallelWorkers)
try
if matlabpool('size') > 0 % checking to see if my pool is already open
     matlabpool close
end
if strcmp(parallelComputation,'yes') && (matlabpool('size') == 0) % checking to see if my pool is already open
     matlabpool('local',numParallelWorkers)
     %parpool(2)
     fprintf('parallel computing enabled and initialized\n');
end
catch err
    warning('parallel computing seems not working, possibly no Parallel Computing Toolbox installed ...who needs this anyway ?! Just continue with next section and don''t bother!');
end

fprintf('computing parameters are set, check if warnings indicates parallel computing might not work\n');


% check paths: run the next lines and see if error occurs
if ~isdir(pathPrefix)
    error(['the folder ' pathPrefix ' does not exist, please check the variable called pathPrefix!'])
end
pathInputFolder = [pathPrefix filesep 'input' filesep inputFolderName];
if ~isdir(pathInputFolder)
    error(['the folder ' pathInputFolder ' does not exist, please create it and copy parameter files in it!'])
end
pathOutputFolder = [pathPrefix filesep 'output' filesep outputFolderName];
if ~isdir(pathOutputFolder)
    mkdir(pathOutputFolder);
end

if (~isdeployed)
    % add toolbox path and
    %addpath([pathPrefix]);
    addpath([pathPrefix filesep 'mainfunctions']);
    addpath([pathPrefix filesep 'subfunctions']);
    % inclulde fieldtrip in path
    addpath([pathPrefix filesep 'fieldtrip_fw']);
    % initialize fieldtrip
    ft_defaults;
end
% change working directory to output folder
cd([pathOutputFolder]);
fprintf('path to toolbox and input and output folders are initialized\n');
end