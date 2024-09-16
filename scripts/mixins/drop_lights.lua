-----------------------------------
-- Abyssea - Drops Lights
-----------------------------------

local mixin = function(mob, params)
    mob:addListener('SPAWN', 'ABYSSEA_SPAWN', function(mobArg)
        xi.abyssea.AddDeathListeners(mobArg)
        mobArg:setDeathType(xi.abyssea.deathType.NONE)
    end)

    xi.abyssea.AddDeathListeners(mob)
end

return mixin
