function out = distance(x,d,Rtarget,Ztarget,plot)
    s = x(1);
    t = x(2);
    R = get_spec_R_derivatives( d, 1, s, t, 0, 'R' );
    Z = get_spec_R_derivatives( d, 1, s, t, 0, 'Z' );
    
    out = sqrt((R{1}-Rtarget)^2 + (Z{1}-Ztarget)^2);
    
    if plot
        hold on
       scatter(R{1},Z{1})
    end
end