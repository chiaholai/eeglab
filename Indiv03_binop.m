clear all
clc

subjID = textread('subjlist.txt','%s','delimiter','\t');
binop_list = textread('binop_list.txt','%s','delimiter','\t');
nsubj = length(subjID);
script_path = pwd;
cd ..
folder_path = pwd;
ana_path = fullfile(folder_path,'Analysis');

%name_gavg = 'RA_OA_analysis_041918.erp';

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
    
    ERP = pop_loaderp( 'filename', fname_erp, 'filepath', data_path, 'Multiload', 'off', 'overwrite', 'off', 'Warning', 'off' );                                                                                                                                                                                                                                                                                                                                                                                                                        
    ERP = pop_binoperator( ERP, binop_list);
    ERP = pop_savemyerp(ERP, 'erpname', char(subjID(i)), 'filename', fname_erp, 'filepath', data_path, 'warning', 'off');

    CURRENTERP = CURRENTERP + 1;
    ALLERP(CURRENTERP) = ERP;
end

%ERP = pop_gaverager( ALLERP , 'ERPindex',1:nsubj, 'Stdev', 'on', 'Warning', 'off' );
%ERP = pop_savemyerp(ERP, 'erpname', name_gavg, 'filename', name_gavg, 'filepath', folder_path, 'warning', 'off');

