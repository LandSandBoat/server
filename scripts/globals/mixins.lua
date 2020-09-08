-----------------------------------
--  MIXINS
--  Contains helper functions for
--  applying mixins
-----------------------------------

function applyMixins(entity, mixins, mixinOptions)
    for i, v in pairs(mixins) do
        if type(v) == "table" then
            applyMixins(entity, v, mixinOptions)
        else
            v(entity, mixinOptions)
        end
    end
end
