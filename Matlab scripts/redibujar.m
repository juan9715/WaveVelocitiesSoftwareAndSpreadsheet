function [ salida ] = redibujar( lims1, lims2, lims3, eje1, eje3, eje4)
%REDIBUJAR Redibuja las figuras para mejorar la selección de las llegada
%   En base a los valores especificados en los ejes


set(eje1, 'ylim', [lims1(1) lims1(2)]);

try
    set(eje3, 'xlim', ([lims2(3) lims2(4)]));
catch
    
end

try
    set(eje3, 'ylim',([lims2(1) lims2(2)]));
catch
end

try
    set(eje4, 'ylim', ([lims3(1) lims3(2)]));
catch

end

try
    set(eje4, 'xlim', ([lims2(3) lims2(4)]));
catch

end



salida = 1;

end

