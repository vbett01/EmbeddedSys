clear data
s = serial('COM8','BaudRate',115200);
set(s, 'DataBits', 8);
set(s, 'Parity', 'none');
fopen(s);
if ~strcmp(s.Status, 'open')
    fclose(s);
    return
end

% Sampling time
time = 5;
% The string to store the ADC values
temp = '';
% Start sampling
tic
% Sample until the set amount of seconds
while toc < time
    if s.BytesAvailable >= 128
        temp = [temp fscanf(s, '%s', s.BytesAvailable)];
        flushinput(s);
    end
end
fclose(s);

data = str2double(regexp(temp, '\d*', 'match'));

figure
subplot(2,1,1)
plot(data)
xlabel('N Samples');
ylabel('ADC Values');
title('Raw Data');
subplot(2,1,2)
semilogy(data);
xlabel('N Samples');
ylabel('ADC Values');
title('logarithmic scale')



