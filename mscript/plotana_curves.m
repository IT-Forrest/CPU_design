function [ output_args ] = plotana_curves()%input_args
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    cpu_ana = zeros(32,32);
    cfsa_ana = zeros(32,32);
    oscd_ana = zeros(32,32);
    var_array = zeros(2,1);
    
    %importfile2_cpu_ana
    VarName4  = importfile2_oscd_ana('sweep_67_74_80_25C_516off_cpu_ana.txt'); %the cpu ana witout oscd
    VarName21 = importfile2_cfsa_ana('sweep_67_74_80_25C_516off_cfsa_ana.txt');%the cfsa_ana measurement
    VarName2  = importfile2_oscd_ana('sweep_67_74_80_25C_516off_cpu_oscd_ana.txt');%the cpu ana with oscd
    
    for i=1:1024
        [var_array(1),var_array(2)] = ind2sub(32, i);
        %fprintf('yy=%d\txx=%d\n', var_array(1),var_array(2));
        cpu_ana(var_array(1),var_array(2)) = VarName4(i);% from cpu_ana.txt
        
        cfsa_ana(var_array(1),var_array(2)) = VarName21(i);% from cfsa_ana.txt
        
        oscd_ana(var_array(1),var_array(2)) = VarName2(i); %from oscd_ana.txt
    end

    fprintf('finish!\n');
    figure;
    surf(cfsa_ana);
    title('cost function curve of measurement');
    view(-81.5,48);
    figure;
    surf(cpu_ana);
    title('cost function curve of microprocessor');
    view(-81.5,48);
    figure;
    surf(oscd_ana);
    title('cost function curve of microprocessor oscd');
    view(-81.5,48);
    figure;
    diff = cfsa_ana - oscd_ana;
    surf(diff);
    title('cost function diff curve between measurement and microprocessor oscd');
    view(-81.5,48);
end

