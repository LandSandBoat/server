-----------------------------------
-- Area: Outer Horutoto Ruins
--  Mob: Ghoul
-- Note: Place holder for Ah Puch
-----------------------------------
local ID = zones[xi.zone.OUTER_HORUTOTO_RUINS]
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
end

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    xi.mob.phOnDespawn(mob, ID.mob.AH_PUCH, 20, 3600) -- 1 to 3 hours
end

return entity
