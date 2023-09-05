-----------------------------------
-- Area: Ordelles Caves
--   NM: Polevik
-- Involved In Quest: Dark Puppet
-- !pos -51 0.1 3 193
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 180)
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
