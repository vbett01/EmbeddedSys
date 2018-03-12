clear data
s = serial('COM8','BaudRate',115200);
set(s, 'DataBits', 8);
set(s, 'Parity', 'none');
fopen(s);
if ~strcmp(s.Status, 'open')
    fclose(s);
    return
end
vals = 1000;
temp = '';
i = 1;
while i < 3
    %fprintf('Number of bytes available: %g ... \n', s.BytesAvailable)
    while s.BytesAvailable >= 128
        disp('...')
        temp = [temp fscanf(s, '%s', s.BytesAvailable)];
        flushinput(s);
        i = i+1;
    end
end
fclose(s);

data = str2double(regexp(temp, '\d*', 'match'));
plot(data)

%{
        if temp ~= '+' || temp ~= 0
            currData = [currData, temp];
        end
        if temp == 0
            data(i)=str2double(currData);
            currData = '';
        end
        fprintf('Converted to %g ...\n', data(i))
%}



