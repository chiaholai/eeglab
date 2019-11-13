clear all
clc

subjID = textread('subjlist.txt','%s','delimiter','\t');
nsubj = length(subjID);
script_path = pwd;
cd ..
folder_path = pwd;
ana_path = fullfile(folder_path,'Analysis');


ALLERP = buildERPstruct([]);
CURRENTERP = 0;
trl_accept = [];

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
    temp = ERP.ntrials.accepted;
    trl_accept(i,:) = temp;
end

cd(script_path)
binnum = 1:size(trl_accept,2);
subjno = ['subjID';subjID];
trl_accept = [binnum;trl_accept];
trl_accept = [subjno num2cell(trl_accept)];
save trl_accept trl_accept -v7.3