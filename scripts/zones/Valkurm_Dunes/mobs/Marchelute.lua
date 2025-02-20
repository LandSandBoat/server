-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Marchelute
-- Involved In Quest: Messenger from Beyond
-- !pos -716 -10 66 103
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
