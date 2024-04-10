-----------------------------------
--  MIXINS
--  Contains helper functions for
--  applying mixins
-----------------------------------
xi = xi or {}

xi.applyMixins = function(entity, mixins)
    -- TODO: This could probably be made nicely with recursion
    if type(mixins) == 'string' then
        mixins = { mixins }
    elseif type(mixins) == 'function' then
        mixins = { mixins }
    end

    for i, v in pairs(mixins) do
        if type(v) == 'table' then
            if type(v[1]) == 'string' then
                xi.mixins[v[1]](entity, v[2])
            elseif type(v[1]) == 'function' then
                v[1](entity, v[2])
            end
        elseif type(v) == 'string' then
            xi.mixins[v](entity)
        elseif type(v) == 'function' then
            v(entity)
        end
    end
end
