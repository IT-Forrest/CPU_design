function [ output_args ] = ADCs_2binary( input_args )
% This file change integer ADCs into binary for Verilog code
% Detailed explanation goes here
    filename = 'sweep_67_74_80_25C_516off';
    oscdname = 'sweep_67_74_80_25C_516off_oscd';
    txt_name = [filename, '.txt'];
    bin_name = [filename, '.bin'];
    osc_name = [oscdname, '.bin'];
    %% Get the data from txt file
    ADC_raw = importfile2_ADCs(txt_name);
    
    % remove the first 2 data Io and Qo
    row = 1024*16;
    col = 10;
    ADC_no_OSC = ADC_raw(:,3:end);
    ADC_OSC = ADC_raw;
    
    %% Create the ADC for Verilog
    for k=1:2
        switch(k)
            case 1
                adc_val = ADC_no_OSC'; row = 1024*16; fid = fopen(bin_name,'w');
            case 2
                adc_val = ADC_OSC'; row = 1024*18; fid = fopen(osc_name,'w');
        end
        
        adc_tmp = de2bi(reshape(adc_val,[],1),'left-msb');
        adc_str = num2str(adc_tmp);
        adc_res = adc_str(adc_str~=' ');
        adc_bit = reshape(adc_res,row,[]);
        
        % save(file_name,ana_bit);
        %fid = fopen(bin_name,'w');
        for i=1:row
            for j=1:col
                fprintf(fid, '%c', adc_bit(i,j));
            end
            fprintf(fid, '\n');
        end
        fclose(fid);
    end
end

