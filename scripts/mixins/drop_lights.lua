require("scripts/globals/moblights")
require("scripts/globals/abyssea")
require("scripts/globals/mixins")
require("scripts/globals/status")

g_mixins = g_mixins or {}

---------------------------------------------------------
-- Drops Lights
---------------------------------------------------------
g_mixins.drop_lights = function(mob)
	mob:addListener("SPAWN", "ABYSSEA_SPAWN", function(mobArg)
		xi.abyssea_mob.AddDeathListeners(mobArg)
        mobArg:setDeathType(xi.abyssea.deathType.NONE)
    end)

    xi.abyssea_mob.AddDeathListeners(mob)
end

return g_mixins.drop_lights
