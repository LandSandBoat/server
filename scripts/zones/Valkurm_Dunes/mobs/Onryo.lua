-----------------------------------
-- Area: Valkurm Dunes
--  Mob: Onryo
-- Involved in Quest: Yomi Okuri
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
