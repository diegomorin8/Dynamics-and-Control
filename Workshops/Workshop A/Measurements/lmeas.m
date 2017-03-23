%%      Info and Help Section
%
%       name = 'sdd_004-step_response_tuned'
%
%
%
%       Loading Measurements
%
%       To Plot call
%               
%                   [X,Y] = lmeas(name,1,2); 
%
%
%       To get measurement data call      
%
%                   [X,Y] = lmeas(name,0,2);
%
%
%  Printing Simulink models as eps
%   print -smIO/submodel -deps -r300 simmodel.eps
% legend('Signal Input (V)','w_{SIM}(rad/s)','w_{REAL}(rad/s)','Location','northwest')
function   [X,Y] = lmeas(name,pl,z)

    data = load(name);                      % Load Structure
    name2=fieldnames(data);                 % Get Fieldnames
    name2=name2{1,1};                       % CELL ARRAY TO STRING Transformation
    data=data.(name2);                        % Go down to data hierarchy
    
    
    
    
    
    
    X = data.X.Data;
    Y = data.Y;
    SiZ=z;
    display(SiZ);
    lbl=string(eye(1,SiZ));
    z=1;
    if pl==1
        figure();
        hold;
        grid;
        for z=1:SiZ
                plot(X,Y(z).Data,'LineWidth',3);
                lbl(z) = Y(z).Name;
        end
        
    else
        ;
    end
%     legend(lbl,'Location','northeast');
legend('w_{SIM}(rad/s)','w_{REAL}(rad/s)','Location','northeast')
ylabel('Angular Velocity (rad/s)');
% legend('Signal Input (V)','w_{SIM}(rad/s)','w_{REAL}(rad/s)','Location','northwest')
%     ylabel('Angular Velocity (rad/s) / Voltage (V)');
    xlabel('Time (seconds)');
    
end
