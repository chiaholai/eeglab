clear all
clc

subjID = textread('subjlist.txt','%s','delimiter','\t');
nsubj = length(subjID);
script_path = pwd;
cd ..
folder_path = pwd;
ana_path = fullfile(folder_path,'Analysis');

%name_gavg = ['RA_analysis_080814.erp'];

ALLERP = buildERPstruct([]);
CURRENTERP = 0;

for i = 1:nsubj;
    name_temp = char(subjID(i));

    if strcmp(name_temp(1:2),'YA') 
        ana_fd = 'YoungerAdults';
    elseif strcmp(name_temp(1:2),'su')
        ana_fd = 'YoungerAdults';
    elseif strcmp(name_temp(1:2),'OA')
        ana_fd = 'OlderAdults';
    end;
    
    data_path = fullfile(ana_path,ana_fd,'data',char(subjID(i)));
    
    %fname_data = [char(subjID(i)) '.set'];
    %fname_elist = [char(subjID(i)) '_elist.set'];
    %fname_bin = [char(subjID(i)) '_elist_bin.set'];
    %fname_AD = [char(subjID(i)) '_elist_bin_AD.set'];
    fname_ADAD = [char(subjID(i)) '_elist_bin_AD_AD.set'];
    fname_erp = [char(subjID(i)) '.erp'];
    
    EEG = pop_loadset('filename',fname_ADAD,'filepath',data_path);
    EEG = eeg_checkset( EEG );
    EEG  = pop_basicfilter( EEG,  1:66 , 'Cutoff',  30, 'Design', 'butter', 'Filter', 'lowpass', 'Order',  2 );
    EEG = eeg_checkset( EEG );
    ERP = pop_averager( EEG , 'Criterion', 'good', 'DSindex',1, 'Stdev', 'on', 'Warning', 'off' );
    ERP = pop_savemyerp(ERP, 'erpname', char(subjID(i)), 'filename', fname_erp, 'filepath', data_path, 'warning', 'off');
    CURRENTERP = CURRENTERP + 1;
    ALLERP(CURRENTERP) = ERP;
end

%ERP = pop_gaverager( ALLERP , 'ERPindex',1:nsubj, 'Stdev', 'on', 'Warning', 'on' );
%ERP = pop_savemyerp(ERP, 'erpname', name_gavg, 'filename', name_gavg, 'filepath', folder_path, 'warning', 'on');
