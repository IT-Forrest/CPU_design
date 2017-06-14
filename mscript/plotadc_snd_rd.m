function [ output_args ] = plotadc_snd_rd( input_args )
%This function is used to compared the send-to and read-out ADC data
%   Detailed explanation goes here
    %file_name = 'test_14_bit_failed_analysis.txt';
    %output_name = 'test_14_bit_failed_bits.txt';
    %file_name = 'test_14_error_analysis_1LIOA.txt';
    %output_name = 'test_14_error_analysis_1LIOA_bits.txt';
    file_name = 'test14_error_analysis2.txt';
    output_name = 'test14_error_analysis2_bits.txt';
    fid = fopen(output_name, 'w+');
    
    offset_snd = 2;
    offset_rd  = 6;
    block_len = 6;
    data_len = 1024;
    keybits = 10;
    
    snd_data = zeros(1,data_len);
    rd_data = zeros(1,data_len);
    for i=0:data_len-1
        start_row = i*block_len+offset_snd;
        end_row = i*block_len+offset_snd;
        gua = importfile_get_ADC_snd(file_name, start_row, end_row);
        snd_data(i+1) = str2num(cell2mat(gua)); %#ok<ST2NM>
        %fprintf('i=%d\n',i);
        snd_bits = de2bi(snd_data(i+1),keybits,'left-msb');
        
        start_row = i*block_len+offset_rd;
        end_row = i*block_len+offset_rd;
        gua = importfile_get_ADC_read(file_name, start_row, end_row);
        rd_data(i+1) = str2num(cell2mat(gua)); %#ok<*ST2NM>
        rd_bits = de2bi(rd_data(i+1),keybits,'left-msb');

        for j=1:keybits
            fprintf(fid, '%d', snd_bits(j));
        end
        fprintf(fid, '\t\t');
        for j=1:keybits
            fprintf(fid, '%d', rd_bits(j));
        end
        if snd_data(i+1) == rd_data(i+1)
            fprintf(fid, '\n');
        else
            fprintf(fid, '\t<--Error\n');
        end
    end
    fclose(fid);
    
    plot(snd_data);
    hold on;
    plot(rd_data);
end

