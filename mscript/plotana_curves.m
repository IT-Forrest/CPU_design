function [ output_args ] = plotana_curves(VarName4, VarName21)%input_args
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    cpu_ana = zeros(32,32);
    cfsa_ana = zeros(32,32);
    var_array = zeros(2,1);
    
    for i=1:1024
        [var_array(1),var_array(2)] = ind2sub(32, i);
        %fprintf('yy=%d\txx=%d\n', var_array(1),var_array(2));
        cpu_ana(var_array(1),var_array(2)) = VarName4(i);% from cpu_ana.txt
        
        cfsa_ana(var_array(1),var_array(2)) = VarName21(i);% from cfsa_ana.txt
    end

    fprintf('finish!\n');
    figure;
    surf(cfsa_ana);
    title('cost function curve of measurement');
    figure;
    surf(cpu_ana);
    title('cost function curve of microprocessor');
end

