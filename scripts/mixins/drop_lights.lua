-----------------------------------
-- Drops Lights
-----------------------------------
g_mixins = g_mixins or {}

g_mixins.drop_lights = function(mob)
    mob:addListener('SPAWN', 'ABYSSEA_SPAWN', function(mobArg)
        xi.abyssea.AddDeathListeners(mobArg)
        mobArg:setDeathType(xi.abyssea.deathType.NONE)
    end)

    xi.abyssea.AddDeathListeners(mob)
end

return g_mixins.drop_lights
