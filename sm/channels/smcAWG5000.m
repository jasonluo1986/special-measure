function val = smcAWG5000(ico, val, rate)
% 1: freq (FG mode), 2: clock (AWG mode), 3-6: CH1,2 amplitude (not sure if working in FG mode),  
% 7: jump to line (requires active sequence)
% 8-11 DC offset for channels 1-4
% 12:27: MARKER 1-4 Low/High for channels 1-4

global smdata;

cmds = {'AWGC:FG:FREQ', ':FREQ', 'SOUR1:VOLT', 'SOUR2:VOLT', 'SOUR3:VOLT', 'SOUR4:VOLT', 'SEQ:JUMP', ...
    'AWGDC1:VOLT:OFFS', 'AWGDC2:VOLT:OFFS','AWGDC3:VOLT:OFFS','AWGDC4:VOLT:OFFS','SOUR1:MARK1:VOLT:LOW',...
    'SOUR1:MARK1:VOLT:HIGH', 'SOUR1:MARK2:VOLT:LOW', 'SOUR1:MARK2:VOLT:HIGH', ... 
    'SOUR2:MARK1:VOLT:LOW', 'SOUR2:MARK1:VOLT:HIGH', 'SOUR2:MARK2:VOLT:LOW', 'SOUR2:MARK2:VOLT:HIGH'...
    'SOUR3:MARK1:VOLT:LOW', 'SOUR3:MARK1:VOLT:HIGH', 'SOUR3:MARK2:VOLT:LOW', 'SOUR3:MARK2:VOLT:HIGH'...
    'SOUR4:MARK1:VOLT:LOW', 'SOUR4:MARK1:VOLT:HIGH', 'SOUR4:MARK2:VOLT:LOW', 'SOUR4:MARK2:VOLT:HIGH'};

switch ico(2)
    case 7;
        switch ico(3) 
            case 1
                fprintf(smdata.inst(ico(1)).data.inst, sprintf('%s %f', cmds{ico(2)}, val));
                smdata.inst(ico(1)).data.line = val;
            case 0
                val = smdata.inst(ico(1)).data.line;
            otherwise
                error('Operation not supported');
        end
        
    otherwise
        switch ico(3) 
            case 1
                fprintf(smdata.inst(ico(1)).data.inst, sprintf('%s %f', cmds{ico(2)}, val));
            case 0
                val = query(smdata.inst(ico(1)).data.inst, sprintf('%s?', cmds{ico(2)}), '%s\n', '%f');
            otherwise
                error('Operation not supported');
        end
end