function [ salida ] = graphPoisson( Vp, Vs, sigmas, eje2)
%GRAPHPOISSON Graphs the selected poisson result
%   In axe 2, according to user selection

h=findobj('type','line','MarkerFaceColor','b');
delete(h);

rapport = Vp./Vs;
rapport2 = rapport.^2;

poisson = 0.5 .* (rapport2-2)./(rapport2-1);

plot(sigmas,poisson,'w--','MarkerSize',5,...
    'MarkerEdgeColor','b','Marker','s',...
    'MarkerFaceColor','b','parent',eje2);

% ylim([0 0.5]);

salida = poisson;

end

