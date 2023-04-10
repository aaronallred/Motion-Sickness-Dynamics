function MISC = cont2MISC(cont)

    cutoff = 10; % specify

    % MISC bounds for scores of 1-10
    MISC_bounds = linspace(0,cutoff,11);
    % MISC scores do not change
    MISC_scores = 0:10;

    MISC = cont;
    for k = 1:length(cont)
        for l = 1:length(MISC_scores)
            if l == 1
                MISC(cont>MISC_bounds(11-l+1)) = MISC_scores(11-l+1);
            else
                lower = cont >= MISC_bounds(11-l+1);
                upper = cont < MISC_bounds(11-l+2);
                MISC(lower.*upper == 1) =  cont(lower.*upper == 1)*...
                    max(MISC_scores)/max(MISC_bounds);
            end
        end
    end
end