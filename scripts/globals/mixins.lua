-----------------------------------
--  MIXINS
--  Contains helper functions for
--  applying mixins
-----------------------------------
xi = xi or {}

xi.applyMixins = function(entity, mixins, params)
    if type(mixins) == 'string' or type(mixins) == 'function' then
        if type(mixins) == 'string' then
            xi.mixins[mixins](entity, params)
        else
            mixins(entity, params)
        end
        return
    end

    if type(mixins) == 'table' then
        if type(mixins[1]) == 'string' or type(mixins[1]) == 'function' then
            if mixins[2] then
                xi.applyMixins(entity, mixins[1], mixins[2])
            else
                for _, mixin in ipairs(mixins) do
                    if type(mixin) == 'string' then
                        xi.mixins[mixin](entity)
                    elseif type(mixin) == 'function' then
                        mixin(entity)
                    end
                end
            end
            return
        elseif type(mixins[1]) == 'table' then
            for _, mixin in ipairs(mixins) do
                xi.applyMixins(entity, mixin[1], mixin[2])
            end
            return
        end
    end
end

xi.applyZoneMobMixins = function(zone, mixins, params)
    local mobs = zone:getMobs()
    for _, mob in ipairs(mobs) do
        xi.applyMixins(mob, mixins, params)
    end
end

xi.applyZoneNPCMixins = function(zone, mixins, params)
    local npcs = zone:getNPCs()
    for _, npc in ipairs(npcs) do
        xi.applyMixins(npc, mixins, params)
    end
end
